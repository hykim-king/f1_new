package com.roadscanner.dto;

import com.roadscanner.domain.qna.Category;
import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class QuestionSaveRequestDto {

    private Integer category; // enum 적용
    private String id; // 유저 아이디로 변경될것
    private String idx; // 첨부파일
    private String title;
    private String content;

}
