package com.roadscanner.result.dao;

import java.sql.SQLException;
import java.util.List;

import com.roadscanner.result.domain.ResultVO;

public interface ResultDao {

	// 결과 이미지 상세 조회
	ResultVO doSelectOne(ResultVO inVO) throws SQLException;

	// 결과 이미지 수정
	int doUpdate(ResultVO inVO) throws SQLException;

	// 결과 이미지 삭제
	int doDelete(ResultVO inVO) throws SQLException;

	// 결과 이미지 등록
	int doSave(ResultVO inVO) throws SQLException;

}