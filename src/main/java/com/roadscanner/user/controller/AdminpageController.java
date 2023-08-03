package com.roadscanner.user.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.roadscanner.domain.Adminpage;
import com.roadscanner.domain.MemberVO;
import com.roadscanner.user.service.AdminService;

@Controller
public class AdminpageController {

		@Inject
		AdminService service;
		
		@RequestMapping(value = "/admin", method = RequestMethod.GET)
		public void getSearchTypeKeywordBoxlogin 
				(Model model, 
				@RequestParam(value = "num",required = false, defaultValue = "1") int num,
				@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword,	
				@RequestParam(value = "pageid",required = false, defaultValue = "") String pageid
						) 
						 
						throws Exception {
			
		Adminpage page = new Adminpage();
		
		page.setNum(num);
		
		page.setCount(service.searchCountBox(
				keyword
				)); 
		
		page.setKeyword(keyword);
		page.setPageid(pageid);
		
		List<MemberVO> list = null;
		list = service.listPageSearchBox(
		page.getDisplayPost(), 
		page.getPostNum(), 
		keyword
		);
		
		model.addAttribute("list", list);   
		model.addAttribute("page", page);
		model.addAttribute("select", num);
			
		}	
	}		
