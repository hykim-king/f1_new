package com.roadscanner.dto;

import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@ToString
@Getter @Setter
public class QuestionListResponseDTO {

    private Long no;
    private int category;
    private String title;
    private String id; // 작성자 -> 유저 아이디
    private LocalDateTime createDate;
    private int views;

    public QuestionListResponseDTO(QuestionVO vo) {
        this.no = vo.getNo();
        this.category = vo.getCategory();
        this.title = vo.getTitle();
        this.id = vo.getId();
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        this.createDate = vo.getCreateDate();
        this.views = vo.getViews();
    }
}
