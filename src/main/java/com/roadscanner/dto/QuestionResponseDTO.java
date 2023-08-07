package com.roadscanner.dto;

import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class QuestionResponseDTO {

    /**
     * 상세화면을 정의하는 DTO
     */

    private Long no;
    private Integer category;
    private String title;
    private String id; // 작성자 -> 유저 아이디
    private Long idx;
    private LocalDateTime createDate;
    private LocalDateTime updateDate;
    private int views;
    private String content;


    public QuestionResponseDTO(QuestionVO vo) {
        this.no = vo.getNo();
        this.category = vo.getCategory();
        this.title = vo.getTitle();
        this.id = vo.getId();
        this.idx = vo.getIdx();
        this.createDate = vo.getCreateDate();
        this.updateDate = vo.getUpdateDate();
        this.views = vo.getViews();
        this.content = vo.getContent();
    }

}
