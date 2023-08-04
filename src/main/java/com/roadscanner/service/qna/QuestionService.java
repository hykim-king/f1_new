package com.roadscanner.service.qna;

import com.roadscanner.dto.QuestionCreateDTO;
import com.roadscanner.dto.QuestionListDTO;

import java.util.List;

public interface QuestionService {

    // 전체 게시글 조회
    List<QuestionListDTO> getAllQuestions();

    // 게시글 작성
    void createQuestion(QuestionCreateDTO dto);
}
