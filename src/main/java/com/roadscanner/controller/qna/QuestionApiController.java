package com.roadscanner.controller.qna;

import com.roadscanner.cmn.AmazonS3Store;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.UploadFile;
import com.roadscanner.dto.qna.QuestionResponseDTO;
import com.roadscanner.dto.qna.QuestionSaveRequestDTO;
import com.roadscanner.dto.qna.QuestionUpdateRequestDTO;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 질문 작성, 수정, 삭제에 관련된 클래스
 * 비동기 처리 - qna.js와 관련됨.
 */
@RequiredArgsConstructor
@RestController
public class QuestionApiController implements PcwkLogger {

    private final QuestionService questionService;
    private final AmazonS3Store fileStore;

    /**
     * @ModelAttribute는 model.addAttribute()를 생략시키게 해준다.
     * @param request
     * @return
     * @throws IOException
     */
    // 등록
    @PostMapping("/api/qna/save")
    public ResponseEntity<?> save(@ModelAttribute QuestionSaveRequestDTO request) throws IOException {
        Map<String, String> errors = validateRequest(request);
        LOG.debug("save 실행");

        if (!errors.isEmpty()) {
            LOG.debug("error ={}", errors);
            // 실패하게 되면 에러메시지를 담아 전송하고 Ajax를 통해 에러메시지를 출력시킨다.
            return ResponseEntity.badRequest().body(errors);
        }

        questionService.save(request);
        return ResponseEntity.ok("성공");
    }

    /**
     * 검증로직을 사용하는 클래스
     * @param request
     * @return
     */
    private Map<String, String> validateRequest(QuestionSaveRequestDTO request) {
        // 검증 오류 보관
        Map<String, String> errors = new HashMap<>();

        // 제목 검증
        if (request.getTitle() == null || request.getTitle().isEmpty()) {
            errors.put("title", "제목은 필수입니다.");
        } else if (request.getTitle().length() > 15) {
            errors.put("title", "제목은 15글자 이하여야 합니다.");
        }

        // 내용 검증
        if (!StringUtils.hasText(request.getContent())) {
            errors.put("content", "내용은 필수입니다.");
        }

        // 이미지 파일 검증
        MultipartFile attachFile = request.getAttachFile();
        if (attachFile != null) {
            // 이미지 파일만 허용
            String contentType = attachFile.getContentType();
            if (contentType == null || !contentType.startsWith("image")) {
                errors.put("attachFile", "이미지 파일만 업로드 가능합니다.");
            }

            // 파일 크기 제한 (예: 5MB)
            long maxSizeInBytes = 5 * 1024 * 1024; // 5MB
            if (attachFile.getSize() > maxSizeInBytes) {
                errors.put("attachFile", "파일 크기는 5MB를 초과할 수 없습니다.");
            }
        }
        return errors;
    }

    // 조회
    @GetMapping("/api/qna/{no}")
    public QuestionResponseDTO findByNo(@PathVariable Long no) {
        return questionService.findByNo(no);
    }

    // 수정
    @PostMapping("/api/qna/{no}")
    public Long update(@PathVariable Long no, @ModelAttribute QuestionUpdateRequestDTO request) throws IOException {
        LOG.debug("request={}", request);
        return questionService.update(no, request);
    }

    // 삭제
    @DeleteMapping("/api/qna/{no}")
    public Long delete(@PathVariable Long no) {
        return questionService.delete(no);
    }

}
