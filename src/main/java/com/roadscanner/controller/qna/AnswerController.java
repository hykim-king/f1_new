package com.roadscanner.controller.qna;

import com.roadscanner.service.qna.AnswerService;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@RequestMapping("/qna")
@Controller
public class AnswerController {

    private final AnswerService answerService;
    private final QuestionService questionService;




}
