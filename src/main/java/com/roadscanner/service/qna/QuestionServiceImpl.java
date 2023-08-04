package com.roadscanner.service.qna;

import com.roadscanner.dao.qna.QuestionDAO;
import com.roadscanner.domain.qna.QuestionVO;
import com.roadscanner.dto.QuestionCreateDTO;
import com.roadscanner.dto.QuestionListDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionDAO questionDAO;

    @Override
    public List<QuestionListDTO> getAllQuestions() {
        return null;
    }

    @Override
    public void createQuestion(QuestionCreateDTO dto) {
        QuestionVO vo = dto.toEntity();
        vo.setCreateDate(LocalDate.now());
        vo.setCreateDate(LocalDate.now());
        vo.setViews(0);
        questionDAO.create(vo);
    }

}
