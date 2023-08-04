package com.roadscanner.dao.result;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.result.ResultVO;

@Repository
public class ResultDaoImpl implements PcwkLogger, ResultDao {
	
	final String NAMESPACE = "com.roadscanner.result";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	// Default 생성자
	public ResultDaoImpl() {
	}
	
	// 결과 이미지 상세 조회
	@Override
	public ResultVO doSelectOne(ResultVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│      doSelectOne()     │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSelectOne");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doSelectOne", inVO);
	}
	
	// 결과 이미지 수정
	@Override
	public int doUpdate(ResultVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doUpdate()       │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doUpdate");
		LOG.debug("└────────────────────────┘");
		
		return sqlSessionTemplate.update(NAMESPACE + DOT + "doUpdate", inVO);
	}
	
	// 결과 이미지 삭제
	@Override
	public int doDelete(ResultVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│       doDelete()       │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doDelete");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.delete(NAMESPACE + DOT + "doDelete", inVO);
	}
	
	// 결과 이미지 등록
	@Override
	public int doSave(final ResultVO inVO) throws SQLException {
		LOG.debug("┌────────────────────────┐");
		LOG.debug("│        doSave()        │");
		LOG.debug("│          inVO          │" + inVO);
		LOG.debug("│        statement       │" + NAMESPACE + DOT + "doSave");
		LOG.debug("└────────────────────────┘");

		return sqlSessionTemplate.insert(NAMESPACE + DOT + "doSave", inVO);
	}
}
