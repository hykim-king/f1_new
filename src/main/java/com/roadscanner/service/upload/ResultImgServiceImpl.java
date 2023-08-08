package com.roadscanner.service.upload;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.dao.upload.ResultImgDao;
import com.roadscanner.domain.upload.ResultImgVO;

@Service
public class ResultImgServiceImpl implements PcwkLogger, ResultImgService {
	
	@Autowired
	ResultImgDao dao;
	
	@Autowired
	ResultImgVO resultVO;

	@Override
	public ResultImgVO getResultImg(ResultImgVO inVO) throws SQLException {
		
		return dao.getResultImg(inVO);
	}

}