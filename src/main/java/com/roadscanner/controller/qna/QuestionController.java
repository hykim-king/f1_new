package com.roadscanner.controller.qna;

import com.roadscanner.dto.QuestionListDTO;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/qna")
@Controller
// 게시판 페이지 URL 요청을 담당하는 컨트롤러
public class QuestionController {

    private final QuestionService questionService;

    @GetMapping
    public String index(Model model) {
        List<QuestionListDTO> questions = questionService.getAllQuestions();
        model.addAttribute("questions", questions);
        return "qna/question-list";
    }

    @GetMapping("/create")
    public String createQuestion() {
        return "qna/question-create";
    }

}
