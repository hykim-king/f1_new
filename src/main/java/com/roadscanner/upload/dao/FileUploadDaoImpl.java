package com.roadscanner.upload.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.upload.domain.FileUploadVO;

public class FileUploadDaoImpl implements PcwkLogger, FileUploadDao {

	final String NAMESPACE = "com.roadscanner.upload";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	// Default 생성자
	public FileUploadDaoImpl() {
	}

	// 피드백 분기별 그래프
	@Override
	public List<FileUploadVO> quarterlyFeedback(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│   quarterlyFeedback(   │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "quarterlyFeedback");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "quarterlyFeedback", inVO);

	}

	// 피드백 누적 그래프, 표
	@Override
	public FileUploadVO totalFeedback(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│     totalFeedback()    │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "totalFeedback");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "totalFeedback", inVO);
	}

	// 사진 목록 조회
	@Override
	public List<FileUploadVO> doRetrieve(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doRetrieve()     │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doRetrieve");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doRetrieve", inVO);
	}

	// 사진 상세 조회
	@Override
	public FileUploadVO doSelectOne(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│      doSelectOne()     │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSelectOne");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doSelectOne", inVO);
	}

	// 사진 삭제
	@Override
	public int doDelete(FileUploadVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doDelete()       │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doDelete");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.delete(NAMESPACE + DOT + "doDelete", inVO);
	}

	// 사진 업로드
	@Override
	public int doSave(final FileUploadVO inVO) throws SQLException {

		LOG.debug("┌────────────────────────┐");
		LOG.debug("│        doSave()        │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSave");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.insert(NAMESPACE + DOT + "doSave", inVO);
	}

}
