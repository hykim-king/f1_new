package com.roadscanner.controller;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.roadscanner.dao.user.UserDao;
import com.roadscanner.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)												//스프링 테스트 컨텍스 프레임워크의 JUnit 확장 기능 지정
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/root-context.xml",
		"file:src/main/resources/mybatis-config.xml"
		})	//테스트 컨텍스트가 자동으로 만들어줄 applicationContext 위치
public class MemberDaoTest {
	
	@Autowired
	UserDao dao;
	
	MemberVO vo01;
	MemberVO vo02;
	MemberVO vo03;
	
	MemberVO search;
	
	@Before
	public void setUp() throws Exception {
		vo01 = new MemberVO("DaoTest01", "password01", "test01@gmail.com", 1);
		vo02 = new MemberVO("DaoTest02", "password02", "test02@gmail.com", 1);
		vo03 = new MemberVO("DaoTest03", "password03", "test03@gmail.com", 1);
		
	}
	
	
	@Test
	public void daoTest() throws SQLException {
		
		// Delete
		dao.deleteOne(vo01);
		dao.deleteOne(vo02);
		dao.deleteOne(vo03);
	
		// Create
		dao.insertOne(vo01);
		dao.insertOne(vo02);
		dao.insertOne(vo03);

		// Retrieve
		MemberVO out01 = dao.selectOne(vo01);
		CompareData(out01, vo01);
		System.out.println("dao test out value : "+out01);
		System.out.println("dao test vo value : "+vo01);
		
		// Update
		MemberVO out02 = dao.selectOne(vo02);
		MemberVO out03 = dao.selectOne(vo03);

		String updatestr01 = "123"; 
		String updatestr02 = "456";
		String updatestr03 = "789";
		
		out01.setPassword(out01.getPassword()+"asdasda"); 
		out02.setPassword(out02.getPassword()+"즐겁다");
		out03.setPassword(out03.getPassword()+"즐겁다겁즐");
		
		dao.updateUser(out01);
		dao.updateUser(out02);
		dao.updateUser(out03);
		
		MemberVO update01 = dao.selectOne(vo01);
		MemberVO update02 = dao.selectOne(vo02);
		MemberVO update03 = dao.selectOne(vo03);
		
		CompareData(update01, out01);
		CompareData(update02, out02);
		CompareData(update03, out03);
		
		// Re: Retrieve	
		MemberVO reout01 = dao.selectOne(vo01);
		MemberVO reout02 = dao.selectOne(vo02);
		MemberVO reout03 = dao.selectOne(vo03);
		System.out.println("dao test reout01 value : "+reout01);
		System.out.println("dao test reout02 value : "+reout02);
		System.out.println("dao test reout03 value : "+reout03);
		
	}
	
	private void CompareData(MemberVO out01, MemberVO vo01) {
		assertEquals(out01.getId(), vo01.getId());
		assertEquals(out01.getPassword(), vo01.getPassword());
		assertEquals(out01.getEmail(), vo01.getEmail());
		assertEquals(out01.getGrade(), vo01.getGrade());
	}
	
	@Test
	public void Bean() {
		System.out.println("= = = = = = = = = = = = = = = = = =");
		System.out.println("bean()");
		System.out.println("dao : "+dao);
		System.out.println("= = = = = = = = = = = = = = = = = =");
		
		assertNotNull(dao);
	}

}