package com.roadscanner.controller.user;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.domain.user.MemberVO;
import com.roadscanner.service.user.MailSendService;
import com.roadscanner.service.user.UserService;

@Controller
public class UserInfoController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailSendService mailSend;
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String myPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("user");
		
		System.out.println("= = = = = = = = = = = = = = = = = =");
		System.out.println("로그인 성공, 마이페이지 시작");
		System.out.println("= = = = = = = = = = = = = = = = = =");
		
		return "/login/mypage";
		
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doChangeInfo(MemberVO member) throws Exception {
		System.out.println("┌────────────────────────────────────────────────────────┐");
        System.out.println("│ doChangeInfo()                                   │");
        System.out.println("└────────────────────────────────────────────────────────┘");
        
        int flag = this.userService.doChangeInfo(member);
        
        String jsonString = "";
        MessageVO message = new MessageVO();
        
        if(1 == flag) {
        	message.setMsgId("10");
        	message.setMsgContents("비빌번호를 수정했습니다");
        } else {
        	message.setMsgId("20");
        	message.setMsgContents("회원정보 수정에 실패했습니다.");
        }
        
       jsonString = new Gson().toJson(message);
       
       return jsonString;
        
	}
	
	// 비밀번호 재설정 페이지
	@RequestMapping("/changePw")
    public String changePw() {
        return "/login/changePw";
    }
	
	// 비밀번호 재설정 이메일 체크
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emailCheck(MemberVO user, HttpSession httpSession) throws SQLException {
		System.out.println("┌────────────────────────────────────────────────────────┐");
        System.out.println("│ emailCheck()                                           │");
        System.out.println("└────────────────────────────────────────────────────────┘");
        
        String jsonString = "";
        MessageVO message = new MessageVO();
        
        System.out.println("===================================================");
        
        int result = 0;
        result = this.userService.doEmailDuplCheck(user);
        
        if(10 == result) {
        	message.setMsgId("10");
        	message.setMsgContents("가입된 이메일입니다, 비밀번호를 재설정하겠습니다.");
        } else if(20 == result) {
        	message.setMsgId("20");
        	message.setMsgContents("가입된 이메일이 없습니다.");
        } 
        
       jsonString = new Gson().toJson(message);
       System.out.println("│ jsonString : "+jsonString);
        
        System.out.println("===================================================");
        
        return jsonString;
	}	
	
    // 비밀번호 재설정 페이지 인증번호 전송
    @GetMapping("/**/change_mailCheck")
	@ResponseBody
	public String change_mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailSend.change_mailCheck(email);
	}
    
    // 비밀번호 재설정 페이지 비밀번호 수정
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String changePw(MemberVO member) throws Exception {
		System.out.println("┌────────────────────────────────────────────────────────┐");
        System.out.println("│ changePw()                                             │");
        System.out.println("└────────────────────────────────────────────────────────┘");
        
        int flag = this.userService.changePw(member);
        
        String jsonString = "";
        MessageVO message = new MessageVO();
        
        if(1 == flag) {
        	message.setMsgId("10");
        	message.setMsgContents("비빌번호를 재설정했습니다");
        } else {
        	message.setMsgId("20");
        	message.setMsgContents("비밀번호 재설정에 실패했습니다.");
        }
        
       jsonString = new Gson().toJson(message);
       
       return jsonString;
        
	}
	
}
