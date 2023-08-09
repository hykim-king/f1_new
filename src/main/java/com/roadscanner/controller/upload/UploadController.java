package com.roadscanner.controller.upload;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.result.ResultImgVO;
import com.roadscanner.domain.upload.FileUploadVO;
import com.roadscanner.service.result.ResultImgService;
import com.roadscanner.service.upload.FileUploadService;

@Controller
public class UploadController implements PcwkLogger {
	
	@Autowired
	FileUploadService service;
	
	@Autowired
	ResultImgService imgService;
	
	@Autowired
	MessageVO messageVO;

	// default 생성자
	public UploadController() {
		LOG.debug("┌────────────────────────────┐");
        LOG.debug("│     UploadController()     │");
        LOG.debug("└────────────────────────────┘");
	}
	
	@RequestMapping(value = "/preUpload")
	public String preUpload() {
		return "preUpload";
	}
	
	// upload 화면
	@RequestMapping("/upload")
	//@RequestMapping(value = "/upload", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String upload(@RequestParam(name = "imgName", required = false) String imageName, Model model,
					FileUploadVO inVO, ResultImgVO resultVO) throws SQLException {
		//직전 업로드한 파일url
		if (imageName != null) {
			model.addAttribute("thisName", imageName);
			String url = "https://roadscanner-test-bucket.s3.ap-northeast-2.amazonaws.com/"+imageName;
			model.addAttribute("thisUrl", url);
		} else {
			LOG.debug("session Connect Failed!");
		}
		
		//피드백 원인을 리스트로
		List<String> reasonList = new ArrayList<String>(Arrays.asList("싫어요 이유1", "싫어요 이유2"));
		model.addAttribute("reasons", reasonList);
		
		//결과 이미지
		Random rand = new Random();
		int randImg = rand.nextInt(10)+1;  // 1 <= randImg < 11
		resultVO.setNo(randImg);
		ResultImgVO resultImg = imgService.getResultImg(resultVO);
		model.addAttribute("resultImg", resultImg.getUrl());
		
		return "upload";
	}
	
	// 사진 검토 여부 Update
	@PostMapping(value = "/checkedUpdate")
	@ResponseBody
	public String checkedUpdate(String[] checkboxes) throws Exception {
		String jsonString = "";
		int flag = 0;
		FileUploadVO inVO = new FileUploadVO(); //checkedName에서 이름 꺼내와 넣을 빈 VO
		HashMap<String,String> successOrNot = new HashMap<String,String>(); //수정 여부 담을 해시맵
		LOG.debug("┌───────────────┐");
		LOG.debug("│ checkedUpdate │");
		LOG.debug("│ checkedName   │" + checkboxes.toString());
		LOG.debug("└───────────────┘");

		try {
			for (String name:checkboxes) {
				inVO.setName(name);
				FileUploadVO resultVO = service.doSelectOne(inVO);
				flag = service.checkedUpdate(resultVO);
				if (1 == flag) { // 수정 성공
					successOrNot.put(name, "1");
				} else {
					successOrNot.put(name, "0");
					
				}
			}
			
			String message = "";
			if (successOrNot.containsValue("0")) { // 수정 실패한 이미지 있음
				flag = 0;
				message = "수정을 실패했습니다.";
			} else if (successOrNot.isEmpty()) {   // 체크된 이미지 없음
				flag = 0;
				message = "수정을 실패했습니다.";
			} else {                               // 체크된 이미지 전체 수정 성공
				flag = 1;
				message = "수정되었습니다.";
			}
			
			messageVO = new MessageVO(String.valueOf(flag), message);
			LOG.debug(messageVO.toString());
			jsonString = new Gson().toJson(flag);
			
		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("**Failed: "+error);
			throw e;
		}
		
		return jsonString;
	}
	
	// 사진 삭제
	@PostMapping(value = "/doDelete")
	@ResponseBody
	public String doDelete(String[] checkboxes) throws SQLException, IOException {
		String jsonString = "";
		int flag = 0;
		FileUploadVO inVO = new FileUploadVO(); //checkedName에서 이름 꺼내와 넣을 빈 VO
		HashMap<String,String> successOrNot = new HashMap<String,String>(); //삭제 여부 담을 해시맵
		LOG.debug("┌─────────────┐");
		LOG.debug("│ doDelete    │");
		LOG.debug("│ checkedName │" + checkboxes.toString());
		LOG.debug("└─────────────┘");
		
		try {
			for (String name:checkboxes) {
				inVO.setName(name);
				FileUploadVO resultVO = service.doSelectOne(inVO);
				flag = service.doDelete(resultVO);
				if (1 == flag) { //삭제 성공
					successOrNot.put(name, "1");
				} else {
					successOrNot.put(name, "0");
					
				}
			}
			
			String message = "";
			if (successOrNot.containsValue("0")) { // 삭제 실패한 이미지 있음
				flag = 0;
				message = "삭제를 실패했습니다.";
			} else if (successOrNot.isEmpty()) {   // 체크된 이미지 없음
				flag = 0;
				message = "삭제를 실패했습니다.";
			} else {                               // 체크된 이미지 전체 삭제 성공
				flag = 1;
				message = "삭제되었습니다.";
			}
			
			messageVO = new MessageVO(String.valueOf(flag), message);
			LOG.debug(messageVO.toString());
			jsonString = new Gson().toJson(flag);
			
		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("**Failed: "+error);
			throw e;
		}
	
		return jsonString;
	}
	
    // 파일 업로드 처리
	@RequestMapping(value = "/fileUploaded", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String uploadFile(@RequestParam("fileUpload") MultipartFile file, FileUploadVO inVO, HttpSession session) throws Exception {
		String result = "";
		String message = "";
		LOG.debug("┌─────────────────────────────────┐");
        LOG.debug("│uploadFile from Client to Service│");
        
		try {
			String saved = service.doSave(file, inVO);
			messageVO = new MessageVO();
			if ("0".equals(saved)) {
				messageVO.setMsgId("0");
				messageVO.setMsgContents("업로드 실패");
				result = new Gson().toJson("업로드 실패");
			} else {
				messageVO.setMsgId("1");
				String fileName = file.getOriginalFilename();
				String shortFile = fileName.substring(0, fileName.indexOf("."));
				if (shortFile.length() > 6) {
					message = shortFile.substring(0, 6)+"...가 업로드되었습니다.";
					messageVO.setMsgContents(message);
				} else {
					message = shortFile+"가 업로드되었습니다.";
					messageVO.setMsgContents(message);
				}
				LOG.debug("│             Success             │");
				result = new Gson().toJson(saved);
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
	
    // 피드백
	@RequestMapping(value = "/feedbackUpdate", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String feedbackUpdate(FileUploadVO inVO) throws SQLException {
		FileUploadVO newVO = service.doSelectOne(inVO);
		newVO.setCategory(inVO.getCategory());
		newVO.setU1(inVO.getU1());
		newVO.setU2(inVO.getU2());
		
		String result = "";
		LOG.debug("┌───────────────────────────────┐");
        LOG.debug("│feedback from Client to Service│");
        LOG.debug(newVO.toString());
        
        try {
			int flag = service.doUpdate(newVO);
			messageVO = new MessageVO();
			
			if (1 == flag) {
				messageVO.setMsgId("1");
				messageVO.setMsgContents("피드백 반영 성공");
				
				LOG.debug("│            Success            │");
			} else {
				messageVO.setMsgId("0");
				messageVO.setMsgContents("피드백 반영 실패");
			}
			
			LOG.debug(messageVO.toString());
			result = new Gson().toJson(messageVO);
		} catch (SQLException e) {
			String error = e.getMessage();
			LOG.debug("│*****Failed: "+error);
			throw e;
		}
        
        LOG.debug("└───────────────────────────────┘");
		return result;
	}
}
