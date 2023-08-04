package com.roadscanner.dto;

import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@ToString
@Getter
@Setter
public class QuestionListDTO {

    private Long no;
    private Integer category;
    private String title;
    private String id; // 작성자 -> 유저 아이디
    private String createDate;
    private Integer views;

    // 도메인 VO를 DTO(필요한정보)만으로 변환
    public static QuestionListDTO of(QuestionVO vo) {
        QuestionListDTO dto = new QuestionListDTO();
        dto.setNo(vo.getNo());
        dto.setCategory(vo.getCategory());
        dto.setTitle(vo.getTitle());
        dto.setId(vo.getId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
        dto.setCreateDate(vo.getCreateDate().format(formatter));
        dto.setViews(vo.getViews());

        return dto;
    }


}
