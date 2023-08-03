package com.roadscanner.user.dao;

import java.util.List;

import com.roadscanner.domain.MemberVO;


public interface AdminpageDao {
	
	 public List<MemberVO> list() throws Exception;
	 
	 public int count() throws Exception;
	 
	 public List<MemberVO> listPage(int displayPost, int postNum) throws Exception;
	 
	 public List<MemberVO> detaillist(String keyword) throws Exception;
	
	 
	 public List<MemberVO> listPageSearchBox(
			   int displayPost, 
			   int postNum,
			   String   keyword

			   
			   ) throws Exception;
	 
	 public int searchCountBox(
			 String   	keyword) throws Exception;

}
