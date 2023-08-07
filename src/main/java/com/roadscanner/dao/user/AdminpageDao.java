package com.roadscanner.dao.user;

import java.util.List;

import com.roadscanner.domain.MemberVO;


public interface AdminpageDao {
	
	 public List<MemberVO> list() throws Exception;
	 
	 public int count() throws Exception;
	 
	 public List<MemberVO> listPage(int displayPost, int postNum) throws Exception;
	 
	 
	 public List<MemberVO> listPageSearchBox(int displayPost, int postNum, String keyword
			 								) throws Exception;
 
	 public int searchCountBox(String keyword) throws Exception;
	 
	 
	 public List<MemberVO> listPageSearchBox2(int displayPost2, int postNum2, String keyword2
			 								) throws Exception;
 
	 public int searchCountBox2(String keyword2) throws Exception;
	 
	 
	 public List<MemberVO> listPageSearchBox3(int displayPost3, int postNum3, String keyword3
			 								) throws Exception;

	 public int searchCountBox3(String keyword3) throws Exception;
	 
}