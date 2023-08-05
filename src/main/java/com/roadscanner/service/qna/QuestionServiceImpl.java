package com.roadscanner.service.qna;

import com.roadscanner.dao.qna.QuestionDAO;
import com.roadscanner.domain.qna.QuestionVO;
import com.roadscanner.dto.QuestionSaveRequestDto;
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

        List<QuestionVO> questions = questionDAO.getAllQuestions();

        // QuestionVO를 QeustuonListDTO로 변환
        List<QuestionListDTO> questionListDTOs = new ArrayList<>();
        for (QuestionVO question : questions) {
            questionListDTOs.add(QuestionListDTO.of(question));
        }
        return questionListDTOs;
    }

    @Override
    public Long save(QuestionSaveRequestDto dto) {

        // DTO(사용자가 제공한 정보를 통해) 질문 VO 객체 생성
//        QuestionVO vo = new QuestionVO(dto.getCategory().getValue(), dto.getId(), dto.getTitle(), dto.getContent());
        QuestionVO vo = new QuestionVO(dto.getCategory(), dto.getId(), dto.getTitle(), dto.getContent());
        // DAO를 통해 데이터베이스에 질문 등록 잘지내시나요?
        return questionDAO.save(vo);
    }


}
