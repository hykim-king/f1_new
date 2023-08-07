package com.roadscanner.service.qna;

import com.roadscanner.dao.qna.QuestionDAO;
import com.roadscanner.domain.qna.QuestionVO;
import com.roadscanner.dto.QuestionResponseDTO;
import com.roadscanner.dto.QuestionSaveRequestDto;
import com.roadscanner.dto.QuestionListResponseDTO;
import com.roadscanner.dto.QuestionUpdateRequestDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionDAO questionDAO;

    @Override
    public List<QuestionListResponseDTO> findAll() {
        List<QuestionVO> questions = questionDAO.findAll();
        List<QuestionListResponseDTO> dto = new ArrayList<>();

        for (QuestionVO question : questions) {
            dto.add(new QuestionListResponseDTO(question));
        }
        return dto;
    }


    @Override
    public Long save(QuestionSaveRequestDto dto) {

        // DTO(사용자가 제공한 정보를 통해) 질문 VO 객체 생성
        QuestionVO vo = dto.toEntity();
        // DAO를 통해 데이터베이스에 질문 등록 잘지내시나요?
        return questionDAO.save(vo);
    }

    @Override
    public QuestionResponseDTO findByNo(Long no) {
        QuestionVO vo = (QuestionVO) questionDAO.findByNo(no);
        return new QuestionResponseDTO(vo);
    }

    @Override
    public Long update(Long no, QuestionUpdateRequestDTO dto) {
        // findById 메서드를 완성 시켜야함 단건 조회후 수정
        QuestionVO vo = (QuestionVO) questionDAO.findByNo(no);
        vo.update(dto.getCategory(), dto.getTitle(), dto.getIdx(), dto.getContent());
        questionDAO.update(vo);
        return no;
    }

    @Override
    public Long delete(Long no) {
        return null;
    }
}
