package com.roadscanner.controller;

import java.io.IOException;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.upload.domain.FileUploadVO;
import com.roadscanner.upload.service.FileUploadService;

import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController implements PcwkLogger {
	
	@Autowired
	FileUploadService service;
	
	@Autowired
	MessageVO messageVO;
	
	@RequestMapping(value = "/feedback")
	public String feedback() {
		return "feedback";
	}
	
	@RequestMapping(value = "/upload")
	public String upload() {
		return "upload";
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
