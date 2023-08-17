package com.roadscanner.controller.qna;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.upload.FileUploadVO;
import com.roadscanner.dto.PaginationDTO;
import com.roadscanner.dto.QuestionResponseDTO;
import com.roadscanner.service.qna.QuestionService;
import com.roadscanner.service.upload.FileUploadService;

import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@RequestMapping("/qna")
@Controller
public class QuestionController implements PcwkLogger {

    private final QuestionService questionService;
    
    private final FileUploadService fileUploadService;
    MessageVO messageVO;
    

    @GetMapping
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        // 페이지 번호가 유효한지 확인
        if (page < 1) {
            page = 1;
        }

        PaginationDTO pagination = new PaginationDTO(page, size);
        model.addAttribute("questions", questionService.findAllWithPaging(pagination));

        int totalQuestions = questionService.countQuestions();
        int totalPages = (int) Math.ceil((double) totalQuestions / size);

        // 총 페이지 수가 0이면, 페이지 번호도 0으로 설정
        if (totalPages == 0) {
            page = 0;
        }
        // 현재 페이지 번호가 총 페이지 수보다 크면, 현재 페이지 번호를 총 페이지 수로 설정
        else if (page > totalPages) {
            page = totalPages;
        }

        model.addAttribute("totalPages", totalPages);
        model.addAttribute("page", page);

        return "qna/index";
    }

    @GetMapping("/save")
    public String QuestionSave() {
        return "qna/question-save";
    }

    @GetMapping("/{no}")
    public String detail(@PathVariable Long no, Model model) throws SQLException {
        // 조회수 증가
        questionService.increaseViews(no);

        QuestionResponseDTO dto = questionService.findByNo(no);
        model.addAttribute("question", dto);
        
        if (dto.getIdx() != null) {
        	LOG.debug("┌──────────────────────────────┐");
        	LOG.debug("│get url from FileUploadService│");
        	LOG.debug("│*****idx: "+dto.getIdx().intValue());
        	
        	FileUploadVO fileVO = new FileUploadVO();
        	fileVO.setIdx(dto.getIdx().intValue());
        	LOG.debug("│*****inVO: "+fileVO.toString());
        	
        	fileVO = fileUploadService.doSelectOne(fileVO);
        	LOG.debug("│*****outVO: "+fileVO.toString());
        	
        	String url = fileVO.getUrl();
        	LOG.debug("│*****url: "+url);
        	
        	model.addAttribute("img", url);
        	
        	LOG.debug("└──────────────────────────────┘");
        }
        
        return "qna/question-detail";
    }

    @GetMapping("/update/{no}")
    public String questionUpdate(@PathVariable Long no, Model model) throws SQLException {
        QuestionResponseDTO dto = questionService.findByNo(no);
        model.addAttribute("question", dto);
        
        if (dto.getIdx() != null) {
        	LOG.debug("┌──────────────────────────────┐");
        	LOG.debug("│get url from FileUploadService│");
        	LOG.debug("│*****idx: "+dto.getIdx().intValue());
        	
        	FileUploadVO fileVO = new FileUploadVO();
        	fileVO.setIdx(dto.getIdx().intValue());
        	LOG.debug("│*****inVO: "+fileVO.toString());
        	
        	fileVO = fileUploadService.doSelectOne(fileVO);
        	LOG.debug("│*****outVO: "+fileVO.toString());
        	
        	String originFileName = fileVO.getName();
        	String fileName = originFileName.substring(18);
        	LOG.debug("│*****fileName: "+fileName);
        	
        	model.addAttribute("originFileName", originFileName);
        	model.addAttribute("fileName", fileName);
        	
        	LOG.debug("└──────────────────────────────┘");
        }
        
        return "qna/question-update";
    }
    
    // 파일 업로드 처리
	@RequestMapping(value = "/fileUploaded", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String uploadFile(@RequestParam("fileUpload") MultipartFile file, FileUploadVO inVO, HttpSession session) throws Exception {
		String result = "";
		LOG.debug("┌─────────────────────────────────┐");
        LOG.debug("│uploadFile from Client to Service│");
        
		try {
			String saved = fileUploadService.doSave(file, inVO);
			messageVO = new MessageVO();
			if ("0".equals(saved)) {
				messageVO.setMsgId("0");
				messageVO.setMsgContents("업로드 실패");
				result = new Gson().toJson("업로드 실패");
			} else {
				messageVO.setMsgId("1");
				inVO.setName(saved);
				int idx = fileUploadService.doSelectOne(inVO).getIdx();
				LOG.debug("│*****idx: "+Integer.toString(idx));
				LOG.debug("│             Success             │");
				result = new Gson().toJson(Integer.toString(idx));
			}
			
			LOG.debug("│success or not: "+messageVO.toString());
		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("│*****Failed: "+error);
			throw e;
		}
		
        LOG.debug("└─────────────────────────────────┘");
        
        return result;
    }
	
	// 이미지 삭제
	@RequestMapping(value = "/fileDelete", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteFile(FileUploadVO inVO) throws SQLException, IOException {
		String jsonString = "";

		LOG.debug("┌─────────────┐");
		LOG.debug("│ doDelete    │");
		LOG.debug("│ inVO        │" + inVO);
		LOG.debug("└─────────────┘");

		try {
			int flag = this.fileUploadService.doDelete(inVO);

			String message = "";
			if (1 == flag) { // 삭제 성공
				message = "삭제되었습니다.";
			} else { // 삭제 실패
				message = "삭제를 실패했습니다.";
			}

			MessageVO messageVO = new MessageVO(String.valueOf(flag), message);
			jsonString = new Gson().toJson(messageVO);

		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("**Failed: " + error);
			throw e;
		}

		return jsonString;
	}

}
