package com.roadscanner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ImgManageController {
	
	@RequestMapping(value = "/imgManagement")
	public String imgManagement() {
		return "imgManagement";
	}
}
