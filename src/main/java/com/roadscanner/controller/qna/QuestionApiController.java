package com.roadscanner.controller.qna;

import com.roadscanner.dto.QuestionSaveRequestDto;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j // 아파치 로거2로 써야함
@RequiredArgsConstructor
@RestController
public class QuestionApiController {

    private final QuestionService questionService;

    // 등록
    @PostMapping("/api/qna/save")
    public Long save(@RequestBody QuestionSaveRequestDto dto) {
        log.info(dto.toString());
        return questionService.save(dto);
    }
}
