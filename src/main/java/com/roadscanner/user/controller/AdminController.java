package com.roadscanner.user.controller;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.roadscanner.domain.MemberVO;
import com.roadscanner.user.service.UserService;


@Controller
public class AdminController {
    final Logger LOG = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    UserService userService;
   
    
    //------관리자 회원관리기능은 여기에 추가-----
   
//    @RequestMapping(value = "/memberAdmin", method = RequestMethod.GET)
//    public String viewMembers(Model model) throws SQLException {
//        // 데이터베이스에서 모든 회원 목록을 가져오기
//        List<MemberVO> memberList = userService.getAllMembers();
//
//        // 회원 목록을 뷰에서 사용할 수 있도록 모델에 추가
//        model.addAttribute("memberList", memberList);
//
//        return "memberAdmin"; // memberAdmin.jsp로 연결
//    }
}