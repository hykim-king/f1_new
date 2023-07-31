package com.roadscanner.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PostDTO {

    private Long id;
    private String title;
    private String category;
    private String content;
    private String author;

    @Builder
    public PostDTO(String title, String category, String content, String author) {
        this.title = title;
        this.category = category;
        this.content = content;
        this.author = author;
    }
}
