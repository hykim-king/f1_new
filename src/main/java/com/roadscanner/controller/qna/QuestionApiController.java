package com.roadscanner.controller.qna;

import com.roadscanner.cmn.AmazonS3Store;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.UploadFile;
import com.roadscanner.dto.qna.QuestionResponseDTO;
import com.roadscanner.dto.qna.QuestionSaveRequestDTO;
import com.roadscanner.dto.qna.QuestionUpdateRequestDTO;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RequiredArgsConstructor
@RestController
public class QuestionApiController implements PcwkLogger {

    private final QuestionService questionService;
    private final AmazonS3Store fileStore;

    // 등록
    // 등록
    @PostMapping("/api/qna/save")
    public Long save(@ModelAttribute QuestionSaveRequestDTO dto) throws IOException {
        LOG.info("save 실행");

        UploadFile attachFile = null;
        if (dto.getAttachFile() != null && !dto.getAttachFile().isEmpty()) {
            attachFile = fileStore.storeFile(dto.getAttachFile());
        }

        LOG.info("attachFile={}", attachFile);
        return questionService.save(dto);
    }



    // 조회
    @GetMapping("/api/qna/{no}")
    public QuestionResponseDTO findByNo(@PathVariable Long no) {
        return questionService.findByNo(no);
    }

    // 수정
    @PutMapping("/api/qna/{no}")
    public Long update(@PathVariable Long no, @RequestBody QuestionUpdateRequestDTO dto) {
        return questionService.update(no, dto);
    }

    // 삭제
    @DeleteMapping("/api/qna/{no}")
    public Long delete(@PathVariable Long no) {
        return questionService.delete(no);
    }

}
