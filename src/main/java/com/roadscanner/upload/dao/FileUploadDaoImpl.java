package com.roadscanner.upload.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.FileUploadVO;

public class FileUploadDaoImpl implements PcwkLogger {

	final String NAMESPACE = "com.roadscanner.upload";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	// Default 생성자
	public FileUploadDaoImpl() {
	}
	
	
	// 분기별 그래프
	
	// 누적 표
	
	// 누적 그래프
	
	// 목록 조회
	public List<FileUploadVO> doRetrieve(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doRetrieve()     │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doRetrieve");
		LOG.debug("└────────────────────────┘");
		
		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doRetrieve", inVO);
	}
	
	// 상세 조회
	public FileUploadVO doSelectOne(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│      doSelectOne()     │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSelectOne");
		LOG.debug("└────────────────────────┘");
		
		return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doSelectOne", inVO);
	}
	
	// 삭제
	public int doDelete(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doDelete()       │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doDelete");
		LOG.debug("└────────────────────────┘");
		
		return sqlSessionTemplate.delete(NAMESPACE + DOT + "doDelete", inVO);
	}
	
	// 사진 업로드
	public int doSave(final FileUploadVO inVO) throws SQLException {
		
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│        doSave()        │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSave");
		LOG.debug("└────────────────────────┘");
		
		return sqlSessionTemplate.insert(NAMESPACE + DOT + "doSave", inVO);
	}
	
}
