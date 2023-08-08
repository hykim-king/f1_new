package com.roadscanner.dao.upload;

import java.sql.SQLException;

import com.roadscanner.domain.upload.ResultImgVO;

public interface ResultImgDao {

	ResultImgVO getResultImg(ResultImgVO inVO) throws SQLException;
}
