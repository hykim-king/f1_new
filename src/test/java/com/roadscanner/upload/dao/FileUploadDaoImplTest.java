package com.roadscanner.upload.dao;

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
import com.roadscanner.upload.domain.FileUploadVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/root-context.xml"
                                  ,"file:src/main/webapp/WEB-INF/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING) 
public class FileUploadDaoImplTest implements PcwkLogger {
	
	@Autowired
	ApplicationContext context;

	@Autowired
	FileUploadDao dao;
	FileUploadVO uploadVO;

	// 테스트를 수행하는데 필요한 정보나 오브젝트: fixture
	FileUploadVO uploadVO1;
	FileUploadVO uploadVO2;
	FileUploadVO uploadVO3;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│         context        │" + context);
		LOG.debug("└────────────────────────┘");

		// null이 아니면 성공
		assertNotNull(context);
		assertNotNull(dao);
		
		uploadVO = new FileUploadVO(11, "a", 10, "20230731", "230731095807_dog.jpg", "url01", 700, 0);
		
		uploadVO1 = new FileUploadVO(11, "a", 10, "20230731", "230731095807_dog.jpg", "url01", 700, 0);
		uploadVO2 = new FileUploadVO(12, "a", 20, "20230731", "230731095807_cat.jpg", "url02", 800, 0);
		uploadVO3 = new FileUploadVO(13, "a", 30, "20230731", "230731095807_cow.jpg", "url03", 900, 0);
	}
	
	
	@Test
	@Ignore
	public void doDelete() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doDelete()       │");
		LOG.debug("└────────────────────────┘");
		
		dao.doDelete(uploadVO1);
		dao.doDelete(uploadVO2);
		dao.doDelete(uploadVO3);
		
	}
	
	@Test
	@Ignore
	public void doSave() throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│        doSave()        │");
		LOG.debug("└────────────────────────┘");
		
		dao.doSave(uploadVO1);
		dao.doSave(uploadVO2);
		dao.doSave(uploadVO3);
		
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