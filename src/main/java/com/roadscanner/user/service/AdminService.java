package com.roadscanner.user.service;

import java.util.List;

import com.roadscanner.domain.MemberVO;

public interface AdminService {

	//약품 리스팅
	public List<MemberVO> list() throws Exception;
	
	//게시물 총 갯수
	public int count() throws Exception;
	
	public List<MemberVO> listPage(int displayPost, int postNum) throws Exception;
	
	
	public List<MemberVO> listPageSearchBox(
			int displayPost, int postNum, 
			String keyword
			) throws Exception;
	
	public int searchCountBox(
			String keyword
			)throws Exception;
	
	public List<MemberVO> listPageSearchBox2(
			int displayPost2, int postNum2, 
			String keyword2
			) throws Exception;
	
	public int searchCountBox2(
			String keyword2
			)throws Exception;

}
