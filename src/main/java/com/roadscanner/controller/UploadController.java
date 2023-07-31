package com.roadscanner.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.roadscanner.upload.FileUtil;
import com.roadscanner.upload.S3FileUploader;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
	final Logger LOG = LogManager.getLogger(getClass());
	
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
    public String uploadFile(@RequestParam("file") MultipartFile file) {
        LOG.debug("┌────────────────────────────────────┐");
        LOG.debug("│Send convertedFile to S3FileUploader│");
        LOG.debug("└────────────────────────────────────┘");
        
        if (!file.isEmpty()) {
            String fileName = file.getOriginalFilename();
            try {
                // MultipartFile을 File로 변환
                File convertedFile = FileUtil.convertMultipartFileToFile(file);
                // 업로드된 파일을 S3에 전송
                S3FileUploader.uploadFile(convertedFile, fileName);
                return "upload"; // 파일 전송 완료 후에 원하는 페이지로 이동
            } catch (Exception e) {
                e.printStackTrace();
                // 파일 업로드 실패 시 처리할 로직 (예: 에러 메시지 출력 등)
                return "upload";
            }
        } else {
            // 파일이 비어있을 경우 처리할 로직 (예: 에러 메시지 출력 등)
            return "upload";
        }
    }
}
