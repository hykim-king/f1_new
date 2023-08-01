package com.roadscanner.dto;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class Posts {

    private final Long id;
    private final String category;
    private final String title;
    private final String content;
    private final String author;
    private final Integer views;
    private final LocalDateTime createdDate;
    private final LocalDateTime updatedDate;

}
