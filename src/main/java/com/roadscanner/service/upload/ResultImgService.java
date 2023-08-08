package com.roadscanner.service.upload;

import java.sql.SQLException;

import com.roadscanner.domain.upload.ResultImgVO;

public interface ResultImgService {

	ResultImgVO getResultImg(ResultImgVO inVO) throws SQLException;
}
