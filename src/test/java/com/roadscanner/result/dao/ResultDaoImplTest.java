package com.roadscanner.result.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.result.domain.ResultVO;
import com.roadscanner.upload.domain.FileUploadVO;

//@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/root-context.xml",
		"file:src/main/webapp/WEB-INF/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ResultDaoImplTest implements PcwkLogger {
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	ResultDao dao;
	
	// 테스트를 수행하는데 필요한 정보나 오브젝트: fixture
	ResultVO resultVO1;
	ResultVO resultVO2;
	ResultVO resultVO3;
	
	
	@Before
	public void setUp() throws Exception {
		
		resultVO1 = new ResultVO(1, "stop", "일시정지", "url01");
		resultVO2 = new ResultVO(2, "slow", "천천히", "url02");
		resultVO3 = new ResultVO(3, "no parking", "주차금지", "url03");
	}
	
	/*
	 * 수정
	 */
	@Test
	@Ignore
	public void update() throws SQLException {
		LOG.debug("┌───────────────────────┐");
		LOG.debug("│        update()       │");
		LOG.debug("└───────────────────────┘");

		// 삭제
		dao.doDelete(resultVO1);
		dao.doDelete(resultVO2);
		dao.doDelete(resultVO3);

		// 등록
		dao.doSave(resultVO1);
		dao.doSave(resultVO2);
		dao.doSave(resultVO3);

		// 조회
		ResultVO outVO1 = dao.doSelectOne(resultVO1);
		ResultVO outVO2 = dao.doSelectOne(resultVO2);
		ResultVO outVO3 = dao.doSelectOne(resultVO3);

		// 조회 데이터 한 건 수정
		String str = "_u";

		outVO1.setName(outVO1.getName() + str);
		outVO1.setContent(outVO1.getContent() + str);
		outVO1.setUrl(outVO1.getUrl() + str);
		

		int flag = dao.doUpdate(outVO1);
		assertEquals(flag, 1);

		// 수정 데이터 조회
		ResultVO upVO1 = dao.doSelectOne(outVO1);
		
		System.out.println(upVO1);
		System.out.println(outVO1);
		
		// 조회 데이터 비교
		//isSameData(upVO1, outVO1);
		
	}
	
	/*
	 * 삭제, 등록, 단건조회
	 */
	@Test
	@Ignore
	public void addAndGet() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       addAndGet()      │");
		LOG.debug("└────────────────────────┘");

		// 삭제
		dao.doDelete(resultVO1);
		dao.doDelete(resultVO2);
		dao.doDelete(resultVO3);

		// 등록
		dao.doSave(resultVO1);
		dao.doSave(resultVO2);
		dao.doSave(resultVO3);

		// 조회
		ResultVO outVO1 = dao.doSelectOne(resultVO1);
		ResultVO outVO2 = dao.doSelectOne(resultVO2);
		ResultVO outVO3 = dao.doSelectOne(resultVO3);

		// 조회 데이터 비교
		isSameData(outVO1, resultVO1);
		isSameData(outVO2, resultVO2);
		isSameData(outVO3, resultVO3);

	}
	
	@Test
	@Ignore
	public void doSelectOne() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│      doSelectOne()     │");
		LOG.debug("└────────────────────────┘");

		ResultVO outVO1 = dao.doSelectOne(resultVO1);
		ResultVO outVO2 = dao.doSelectOne(resultVO2);
		ResultVO outVO3 = dao.doSelectOne(resultVO3);

		isSameData(outVO1, resultVO1);
		isSameData(outVO2, resultVO2);
		isSameData(outVO3, resultVO3);
	}
	
	@Test
	@Ignore
	public void doDelete() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doDelete()       │");
		LOG.debug("└────────────────────────┘");

		dao.doDelete(resultVO1);
		dao.doDelete(resultVO2);
		dao.doDelete(resultVO3);

	}
	
	@Test
	@Ignore
	public void doSave() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│        doSave()        │");
		LOG.debug("└────────────────────────┘");
		
		dao.doSave(resultVO1);
		dao.doSave(resultVO2);
		dao.doSave(resultVO3);
	}
	
	// 테스트 검증 자동화
	public void isSameData(ResultVO outVO, ResultVO inVO) {
		assertEquals(outVO.getNo(), inVO.getNo());
		assertEquals(outVO.getName(), inVO.getName());
		assertEquals(outVO.getContent(), inVO.getContent());
		assertEquals(outVO.getUrl(), inVO.getUrl());
	}
	
	@Test
	@Ignore
	public void bean() {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│          bean          │");
		LOG.debug("│          dao           │" + dao);
		LOG.debug("└────────────────────────┘");

		assertNotNull(dao); // dao 객체가 잘 만들어졌는지 확인
	}

}
