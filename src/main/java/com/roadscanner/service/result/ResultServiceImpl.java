package com.roadscanner.service.result;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.dao.result.ResultDao;
import com.roadscanner.domain.result.ResultVO;

@Service
public class ResultServiceImpl implements PcwkLogger, ResultService {

	@Autowired
	ResultDao dao;

	// 결과 이미지 상세 조회
	@Override
	public ResultVO doSelectOne(ResultVO inVO) throws SQLException {

		return dao.doSelectOne(inVO);
	}

	// 결과 이미지 수정
	@Override
	public int doUpdate(ResultVO inVO) throws SQLException {

		return dao.doUpdate(inVO);
	}

	// 결과 이미지 삭제
	@Override
	public int doDelete(ResultVO inVO) throws SQLException {

		return dao.doDelete(inVO);
	}

	// 결과 이미지 등록
	@Override
	public int doSave(ResultVO inVO) throws SQLException {

		return dao.doSave(inVO);
	}

}