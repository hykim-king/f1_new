package com.roadscanner.dao;

import com.roadscanner.domain.board.QuestionVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionDAO {

    // 전체 게시글 조회
    List<QuestionVO> getAllQuestions();

}
