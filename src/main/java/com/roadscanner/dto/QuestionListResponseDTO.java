package com.roadscanner.dto;

import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.format.DateTimeFormatter;

@ToString
@Getter @Setter
public class QuestionListResponseDTO {

    private Long no;
    private Integer category;
    private String title;
    private String id; // 작성자 -> 유저 아이디
    private String createDate;
    private Integer views;

    public QuestionListResponseDTO(QuestionVO vo) {
        this.no = vo.getNo();
        this.category = vo.getCategory();
        this.title = vo.getTitle();
        this.id = vo.getId();
        this.createDate = String.valueOf(vo.getCreateDate());
        this.views = vo.getViews();
    }
}
