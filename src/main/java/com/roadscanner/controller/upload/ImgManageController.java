package com.roadscanner.controller.upload;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.roadscanner.cmn.MessageVO;
import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.domain.upload.FileUploadVO;
import com.roadscanner.service.upload.FileUploadService;

@Controller
public class ImgManageController implements PcwkLogger {
	
	@Autowired
	FileUploadService service;

	@Autowired
	MessageVO messageVO;


	// default 생성자
	public ImgManageController() {
		LOG.debug("┌───────────────────────────┐");
		LOG.debug("│   ImgManageController()   │");
		LOG.debug("└───────────────────────────┘");
	}

	// feedback 화면
	@RequestMapping(value = "/graph")
	public String feedback() throws SQLException {
		return "graph";
	}

	// 분기별 피드백
	@RequestMapping(value = "/quarterlyFeedback", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String quarterlyFeedback(FileUploadVO inVO) throws SQLException {
		String jsonString = "";

		List<FileUploadVO> outVO = this.service.quarterlyFeedback(inVO);

		jsonString = new Gson().toJson(outVO);

		return jsonString;
	}

	// 누적 피드백
	@RequestMapping(value = "/totalFeedback", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String totalFeedback(FileUploadVO inVO) throws SQLException {
		String jsonString = "";

		FileUploadVO outVO = this.service.totalFeedback(inVO);

		jsonString = new Gson().toJson(outVO);

		return jsonString;
	}
	
	// 이미지 목록 관리
	@RequestMapping(value = "/imgManagement")
	public String imgManagement(FileUploadVO inVO, Model model) throws SQLException {

		// 페이지 번호 초기값: 1
		if (null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1);
		}
		// 페이지 사이즈 초기값: 9
		if (null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(9);
		}
		
		// 카테고리 초기값: 10
		if (null != inVO) {
			inVO.setCategory(10);
		}
		
		// 목록 조회
		List<FileUploadVO> list = this.service.doRetrieve(inVO);
		model.addAttribute("list", list);
		model.addAttribute("inVO", inVO);

		// 총 글 수
		int totalCnt = 0;
		if (null != list && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
			LOG.debug("totalCnt : " + totalCnt);
		}
		model.addAttribute("totalCnt", totalCnt);

		return "imgManagement";
	}

}
