package com.roadscanner.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.roadscanner.domain.MemberVO;
import com.roadscanner.user.dao.AdminpageDao;


@Service
public class AdminServiceImpl implements AdminService{
	
	@Inject
	private AdminpageDao adminpageDao; 
	
	@Override
	public List<MemberVO> list() throws Exception {
		return adminpageDao.list();
	}
	
	@Override
	public int count() throws Exception {
		return adminpageDao.count();
	}
	
	@Override
	public List<MemberVO> listPage(int displayPost, int postNum) throws Exception {
	 return adminpageDao.listPage(displayPost, postNum);
	}

	@Override
	public List<MemberVO> listPageSearchBox(int displayPost, int postNum,String keyword) throws Exception {
		
		return adminpageDao.listPageSearchBox(displayPost, postNum,
												keyword
								);
	}

	@Override
	public int searchCountBox(String keyword) throws Exception {
		
		return adminpageDao.searchCountBox(
				keyword);
	}

	@Override
	public List<MemberVO> detaillist(String keyword) throws Exception {
		return adminpageDao.detaillist(keyword);
	}



	
	
}
