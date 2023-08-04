package com.roadscanner.service.board;

import com.roadscanner.dto.QuestionListDTO;

import java.util.List;

public interface QuestionService {

    // 전체 게시글 조회
    List<QuestionListDTO> getAllQuestions();

}
