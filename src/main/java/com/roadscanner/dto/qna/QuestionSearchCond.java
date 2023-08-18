package com.roadscanner.dto.qna;

import lombok.Getter;
import lombok.Setter;

/**
 * 게시글(질문) 검색을 위해 사용되는 DTO
 * 검색조건 : 제목, 내용, 제목+내용
 */
@Getter @Setter
public class QuestionSearchCond {

    private String searchType;
    private String keyword;

}