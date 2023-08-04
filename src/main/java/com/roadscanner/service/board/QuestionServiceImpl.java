package com.roadscanner.service.board;

import com.roadscanner.dao.QuestionDAO;
import com.roadscanner.domain.board.QuestionVO;
import com.roadscanner.dto.QuestionListDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionDAO questionDAO;

    @Override
    public List<QuestionListDTO> getAllQuestions() {

        List<QuestionVO> questions = questionDAO.getAllQuestions();

        // QuestionVO를 QeustuonListDTO로 변환
        List<QuestionListDTO> questionListDTOs = new ArrayList<>();
        for (QuestionVO question : questions) {
            questionListDTOs.add(QuestionListDTO.of(question));
        }
        return questionListDTOs;
    }
}
