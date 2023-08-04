package com.roadscanner.domain.board;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

// domain 클래스 => 데이터베이스랑 1대1 매칭
@Getter
@Setter
@NoArgsConstructor
public class QuestionVO {

    private Long no; // 번호
    private Integer category; // 카테고리
    private Integer views; // 조회수
    private Long idx; // 이미지ID
    private String id; // 사용자 아이디 -> userId
    private String title; // 제목
    private String content; // 내용
    private LocalDate createDate; // 작성일
    private LocalDate updateDate; // 수정일

}
