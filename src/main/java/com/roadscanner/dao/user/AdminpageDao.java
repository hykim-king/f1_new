package com.roadscanner.dao.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.roadscanner.domain.MemberVO;


public interface AdminpageDao {
	
	 public List<MemberVO> list() throws Exception;
	 
	 public int count() throws Exception;
	 
	 public List<MemberVO> listPage(int displayPost, int postNum) throws Exception;
	 
	 
	 public List<MemberVO> listPageSearchBox(
			 @Param("displayPost") int displayPost,
			 @Param("postNum") int postNum,
			 @Param("keyword") String keyword
			 								) throws Exception;
 
	 public int searchCountBox(String keyword) throws Exception;
	 
	 

	 public List<MemberVO> listPageSearchBox2(
			 @Param("displayPost2") int displayPost2, 
			 @Param("postNum2") int postNum2,
			 @Param("keyword2") String keyword2,
			 @Param("nekeyword") String nekeyword

			   
			   ) throws Exception;
 
	 public int searchCountBox2(
			 @Param("keyword2") String keyword2,
			 @Param("nekeyword") String nekeyword) throws Exception;

	 
	 public List<MemberVO> listPageSearchBox3(
			 @Param("displayPost3") int displayPost3, 
			 @Param("postNum3") int postNum3, 
			 @Param("keyword3") String keyword3
			 								) throws Exception;

	 public int searchCountBox3(String keyword3) throws Exception;
	 
}