package com.roadscanner.dto;

import lombok.Builder;
import lombok.Getter;
import java.time.LocalDateTime;

@Getter
@Builder
public class Posts {

    private final Long id; // q_idx -> id
    private final String category; // q_div -> category
    private final String title; // q_title -> title
    private final String content; // q_contents -> content
    private final String author; // a_id -> author
    private final LocalDateTime createdDate; // q_reg_date -> createdDate
    private final LocalDateTime updatedDate; // q_mod_date -> updatedDate
    private final int views; // q_read_cnt -> views
}
