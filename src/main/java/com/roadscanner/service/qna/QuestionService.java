package com.roadscanner.service.qna;

import com.roadscanner.domain.qna.QuestionVO;
import com.roadscanner.dto.QuestionSaveRequestDto;
import com.roadscanner.dto.QuestionListDTO;

import java.util.List;

public interface QuestionService{

    /**
     * 게시글 작성
     */
    Long save(QuestionSaveRequestDto dto);

    QuestionVO findById(Long id);

    List<QuestionListDTO> findAll();

    Long update(QuestionSaveRequestDto dto);

    Long delete(Long id);

}
