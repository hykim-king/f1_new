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

    private String title;
    private String id; // 작성자 -> 유저 아이디
    private LocalDateTime createDate;
    private LocalDateTime updateDate;
    private int views;

    public QuestionResponseDTO(QuestionVO vo) {
        this.title = vo.getTitle();
        this.id = vo.getId();
        this.createDate = vo.getCreateDate();
        this.updateDate = vo.getUpdateDate();
        this.views = vo.getViews();
    }

    public QuestionResponseDTO(Object o) {
    }
}
