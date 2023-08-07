package com.roadscanner.dto;

import com.roadscanner.domain.qna.AnswerVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter @Setter
@NoArgsConstructor
public class AnswerSaveRequestDTO {

    private String id;  // admin id
    private String content;

    public AnswerVO toEntity() {
        return new AnswerVO(this.getId(), this.getContent());
    }

}
