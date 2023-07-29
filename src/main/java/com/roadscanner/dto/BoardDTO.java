package com.roadscanner.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

// 롬복을 통한 Getter, Setter 메소드 생성
@Getter
@Setter
public class BoardDTO {
    private Long qIdx;
    private String rId;
    private int uIdx;
    private int qDiv;
    private int qReadCnt;
    private String qTitle;
    private String qContents;
    private Date qRegDate;
    private Date qModDate;
    private String aId;
    private String aContents;
    private Date aRegDate;
    private Date aModDate;

    // getters and setters
}

