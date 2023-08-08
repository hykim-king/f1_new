package com.roadscanner.controller.qna;

import com.roadscanner.service.qna.AnswerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@RequestMapping("/qna")
@Controller
public class AnswerController {

    private final AnswerService answerService;

    @GetMapping("/save/answer")
    public String answerSave() {
        return "qna/answer-save";
    }


}
