package com.roadscanner.controller.upload;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.upload.FileUploadVO;
import com.roadscanner.service.upload.FileUploadService;

@Controller
public class UploadController implements PcwkLogger {
	
	@Autowired
	FileUploadService service;
	
	@Autowired
	MessageVO messageVO;

	// default 생성자
	public UploadController() {
		LOG.debug("┌────────────────────────────┐");
        LOG.debug("│     UploadController()     │");
        LOG.debug("└────────────────────────────┘");
	}
	
	// upload 화면
	@RequestMapping(value = "/upload")
	public String upload(Model model) {
		List<String> reasonList = new ArrayList<String>(Arrays.asList("싫어요 이유1", "싫어요 이유2"));
		model.addAttribute("reasons", reasonList);
		
		return "upload";
	}
	
	// 사진 검토 여부 Update
	@RequestMapping(value = "/checkedUpdate", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkedUpdate(FileUploadVO inVO) throws Exception {
		String jsonString = "";
		LOG.debug("┌───────────────┐");
		LOG.debug("│ checkedUpdate │");
		LOG.debug("│ inVO          │" + inVO);
		LOG.debug("└───────────────┘");

		try {
			inVO = service.doSelectOne(inVO);
			int flag = service.checkedUpdate(inVO);
			
			String message = "";
			if (1 == flag) { // 삭제 성공
				message = "수정되었습니다.";
			} else { // 삭제 실패
				message = "수정을 실패했습니다.";
			}
			
			messageVO = new MessageVO(String.valueOf(flag), message);
			jsonString = new Gson().toJson(messageVO);
			
		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("**Failed: "+error);
			throw e;
		}
		
		return jsonString;
	}
	
	// 사진 삭제
	@RequestMapping(value = "/doDelete", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(FileUploadVO inVO) throws SQLException, IOException {
		String jsonString = "";
		
		LOG.debug("┌─────────────┐");
		LOG.debug("│ doDelete    │");
		LOG.debug("│ inVO        │" + inVO);
		LOG.debug("└─────────────┘");
		
		try {
			int flag = this.service.doDelete(inVO);
			
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
			LOG.debug("**Failed: "+error);
			throw e;
		}
	
		return jsonString;
	}
	
    // 파일 업로드 처리
	@RequestMapping(value = "/fileUploaded", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String uploadFile(@RequestParam("fileUpload") MultipartFile file, FileUploadVO inVO) throws Exception {
		String jsonString = "";
		String message = "";
		LOG.debug("┌─────────────────────────────────┐");
        LOG.debug("│uploadFile from Client to Service│");
		try {
			int flag = service.doSave(file, inVO);
			
			if (1 == flag) {
				String fileName = file.getOriginalFilename();
				String shortFile = fileName.substring(0, fileName.indexOf(".")+1);
				if (shortFile.length() > 6) {
					message = shortFile.substring(0, 6)+"...가 업로드되었습니다.";
				} else {
					message = shortFile+"가 업로드되었습니다.";
				}
				LOG.debug("│             Success             │");
			} else {
				message = "업로드 실패";
			}
			
			messageVO = new MessageVO(String.valueOf(flag), message);
			jsonString = new Gson().toJson(messageVO);
		} catch (SQLException | IOException e) {
			String error = e.getMessage();
			LOG.debug("│*****Failed: "+error);
			throw e;
		}
		
        LOG.debug("└─────────────────────────────────┘");
        
        return jsonString;
    }
}
