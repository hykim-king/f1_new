package com.roadscanner.controller.qna;

import com.roadscanner.domain.user.MemberVO;
import com.roadscanner.dto.qna.AnswerResponseDTO;
import com.roadscanner.dto.qna.PaginationDTO;
import com.roadscanner.dto.qna.QuestionResponseDTO;
import com.roadscanner.dto.qna.QuestionSearchCond;
import com.roadscanner.service.qna.AnswerService;
import com.roadscanner.service.qna.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/qna")
@Controller
public class QuestionController {

    private final QuestionService questionService;
    private final AnswerService answerService;


    @GetMapping
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size,
                        @RequestParam(defaultValue = "") String searchType,
                        @RequestParam(defaultValue = "") String keyword,
                        @RequestParam(required = false) Integer category) {
        // 페이지 번호가 유효한지 확인
        if (page < 1) {
            page = 1;
        }

        QuestionSearchCond searchCond = new QuestionSearchCond();
        searchCond.setSearchType(searchType);
        searchCond.setKeyword(keyword);
        searchCond.setCategory(category); // 카테고리 설정

        PaginationDTO pagination = new PaginationDTO(page, size);
        model.addAttribute("questions", questionService.findAll(pagination, searchCond));
//        model.addAttribute("questions", questionService.findAllWithPaging(pagination));

        int totalQuestions = questionService.countQuestions(searchCond);
        int totalPages = (int) Math.ceil((double) totalQuestions / size);

        // 총 페이지 수가 0이면, 페이지 번호도 0으로 설정
        if (totalPages == 0) {
            page = 0;
        }
        // 현재 페이지 번호가 총 페이지 수보다 크면, 현재 페이지 번호를 총 페이지 수로 설정
        else if (page > totalPages) {
            page = totalPages;
        }

        model.addAttribute("totalPages", totalPages);
        model.addAttribute("page", page);

        return "qna/index";
    }

    /**
     * 로그인 하지 않은 유저가 글쓰기 버튼을 클릭 하면 로그인 화면으로 이동 시킨다.
     * 로그인 한 유저는 세션에 저장되어있다. memberVO 변수로 값을 받고, 모델로 View 에 전달 시킨다.
     * 로그인 하지 않은 유저가 접근하려고 한다면 login으로 보낸다.
     * @param memberVO
     * @param model
     * @return
     */
    @GetMapping("/save")
    public String QuestionSave(@SessionAttribute(value = "user", required = false) MemberVO memberVO, Model model) {

        if (memberVO == null) {
            return "redirect:/login";
        }

        model.addAttribute("userId", memberVO.getId());
        return "qna/question-save";
    }

    @GetMapping("/{no}")
    public String detail(@PathVariable Long no, Model model) {
        // 조회수 증가
        questionService.increaseViews(no);

        QuestionResponseDTO dto = questionService.findByNo(no);
        model.addAttribute("question", dto);

        // 답변 등록 결과를 반환값으로 받아서 이용
        AnswerResponseDTO answerDto = answerService.findByNo(no);
        model.addAttribute("answer", answerDto);

        return "qna/question-detail";
    }

    @GetMapping("/update/{no}")
    public String questionUpdate(@PathVariable Long no, Model model) {
        QuestionResponseDTO dto = questionService.findByNo(no);
        model.addAttribute("question", dto);
        return "qna/question-update";
    }

}
