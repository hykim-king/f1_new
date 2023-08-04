package com.roadscanner.controller.qna;

import com.roadscanner.dto.QuestionCreateDTO;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j // 아파치 로거2로 써야함
@RequiredArgsConstructor
@RestController
// 클라이언트(브라우저)에게 JSON형식의 데이터를 제공
public class QuestionApiController {

    private final QuestionService questionService;

    // 등록
    @PostMapping("api/qna/create")
    public void createQuestion(@RequestBody QuestionCreateDTO dto) {
        questionService.createQuestion(dto);
    }
}
