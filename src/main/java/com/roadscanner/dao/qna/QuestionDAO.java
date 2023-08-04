package com.roadscanner.dao.qna;

import com.roadscanner.domain.qna.QuestionVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionDAO {

    // 전체 게시글 조회
    List<QuestionVO> getAllQuestions();

    // 단건 조회
    QuestionVO getQuestionById();

    // 게시글 작성
    void create(QuestionVO vo);

    void update(QuestionVO vo);

    void delete(Long id);


}
