package com.roadscanner.controller.user;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.user.MemberVO;
import com.roadscanner.domain.user.list_admin;
import com.roadscanner.domain.user.list_banned;
import com.roadscanner.domain.user.list_member;
import com.roadscanner.service.user.AdminService;

@Controller
@RequestMapping("/login")
public class AdminpageController implements PcwkLogger {

@Inject
AdminService service;
	
	// 일반 회원 페이징
	@RequestMapping(value = "/list_member", method = RequestMethod.GET)
	public void list_member (Model model, 
			@RequestParam(value = "num",required = false, defaultValue = "1") int num,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword,	
			@RequestParam(value = "pageid",required = false, defaultValue = "") String pageid) throws Exception {
		
		list_member memberPage = new list_member();
		
		LOG.debug("***********");
		LOG.debug("list_member");
		
		memberPage.setNum(num);
		memberPage.setCount(service.member_searchCntBox(keyword)); 
		memberPage.setKeyword(keyword);
		memberPage.setPageid(pageid);
		LOG.debug("*m111111111");
		
		List<MemberVO> list = null;
		list = service.member(memberPage.getdpPost(), memberPage.getPostNum(), keyword);
		LOG.debug("*m222222222");
			
		model.addAttribute("list", list);   
		model.addAttribute("memberPage", memberPage);
		model.addAttribute("select", num);
		LOG.debug("*m333333333");
		LOG.debug("***********");
				
		}
	
	// 관리자 계정 페이징
	@RequestMapping(value = "/list_admin", method = RequestMethod.GET)
	public void list_admin (Model model, 
			@RequestParam(value = "num",required = false, defaultValue = "1") int num,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword,
			@RequestParam(value = "exclude",required = false, defaultValue = "") String exclude,
			@RequestParam(value = "pageid",required = false, defaultValue = "") String pageid) throws Exception {
		
		list_admin adminPage = new list_admin();
		
		LOG.debug("**********");
		LOG.debug("list_admin");
		
		adminPage.setnum(num);
		adminPage.setcount(service.admin_searchCntBox(keyword,exclude)); 
		adminPage.setkeyword(keyword);
		adminPage.setexclude(exclude);
		adminPage.setpageid(pageid);
		LOG.debug("*a11111111");
		
		List<MemberVO> list = null;
		list = service.admin(adminPage.getdpPost(), adminPage.getPostnum(),keyword,exclude);
		LOG.debug("*a22222222");
			
		model.addAttribute("list", list);   
		model.addAttribute("adminPage", adminPage);
		model.addAttribute("select", num);
		LOG.debug("*a33333333");
		LOG.debug("**********");
		
		}
	
	// 정지 회원 페이징
	@RequestMapping(value = "/list_banned", method = RequestMethod.GET)
	public void list_banned(Model model, 
			@RequestParam(value = "num",required = false, defaultValue = "1") int num,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword,	
			@RequestParam(value = "pageid",required = false, defaultValue = "") String pageid) throws Exception {
		
		list_banned BannedPage = new list_banned();
		
		LOG.debug("***********");
		LOG.debug("list_banned");
		
		BannedPage.setnum(num);
		BannedPage.setcount(service.banned_searchCntBox(keyword)); 
		BannedPage.setkeyword(keyword);
		BannedPage.setPageid(pageid);
		LOG.debug("*b111111111");
		
		List<MemberVO> list = null;
		list = service.banned(BannedPage.getdpPost(), BannedPage.getPostnum(), keyword);
		LOG.debug("*b222222222");
		
		model.addAttribute("list", list);   
		model.addAttribute("BannedPage", BannedPage);
		model.addAttribute("select", num);
		LOG.debug("*b333333333");
		LOG.debug("***********");
				
		}

}		