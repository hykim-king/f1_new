package com.roadscanner.controller.board;

import com.roadscanner.service.board.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequiredArgsConstructor
@RequestMapping("/board")
@Controller
// 게시판 페이지 URL 요청을 담당하는 컨트롤러
public class QuestionController {

    private final QuestionService questionService;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("questions", questionService.getAllQuestions());
        return "board/question-list";
    }
}
