package com.roadscanner.dto;

import com.roadscanner.domain.qna.Category;
import com.roadscanner.domain.qna.QuestionVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QuestionCreateDTO {

    private String category; // enum 적용
    private String id; // 유저 아이디로 변경될것
//    private Long idx; // 첨부파일
    private String title;
    private String content;

    // DTO -> VO 데이터 베이스에 값을 주입할 때 변환하는 메소드
    public QuestionVO toEntity() {
        QuestionVO vo = new QuestionVO();
        vo.setCategory(Category.fromLabel(this.category).getValue());
        vo.setId(this.id);
//        vo.setIdx(this.idx);
        vo.setTitle(this.title);
        vo.setContent(this.content);
        return vo;
    }

}
