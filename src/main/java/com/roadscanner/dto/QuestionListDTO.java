package com.roadscanner.dto;

import com.roadscanner.domain.board.QuestionVO;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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
    public static QuestionListDTO of(QuestionVO question) {
        QuestionListDTO dto = new QuestionListDTO();
        dto.setNo(question.getNo());
        dto.setCategory(question.getCategory());
        dto.setTitle(question.getTitle());
        dto.setId(question.getId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
        dto.setCreateDate(question.getCreateDate().format(formatter));
        dto.setViews(question.getViews());

        return dto;
    }


}
