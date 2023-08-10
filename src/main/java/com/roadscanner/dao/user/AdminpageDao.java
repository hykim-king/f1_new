package com.roadscanner.dao.user;

import java.util.List;

import com.roadscanner.domain.MemberVO;


public interface AdminpageDao {
	
	 public List<MemberVO> list() throws Exception;
	 
	 public int count() throws Exception;
	 
	 public List<MemberVO> listPage(int dpPost, int postNum) throws Exception;
	 
	 
	 public List<MemberVO> member(int dpPost, int postNum, String keyword) throws Exception;
 
	 public int member_searchCntBox(String keyword) throws Exception;
	 
	 
	 public List<MemberVO> admin(int dpPost, int postNum, String exclude, String keyword) throws Exception;
 
	 public int admin_searchCntBox(String exclude, String keyword) throws Exception;

	 
	 public List<MemberVO> banned(int dpPost, int postNum, String keyword) throws Exception;

	 public int banned_searchCntBox(String keyword) throws Exception;
	 
}