package com.roadscanner.dao.qna;

import com.roadscanner.domain.qna.QuestionVO;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.roadscanner.dao.qna.AnswerDAO;
import com.roadscanner.domain.qna.AnswerVO;
import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations =
        {
                "file:src/main/webapp/WEB-INF/root-context.xml",
                "file:src/main/resources/mybatis-config.xml"
        })
public class AnswerDAOTest {

    @Autowired
    private AnswerDAO dao;

    AnswerVO answer;
    private Long no;

    @Before
    public void setUp() throws Exception {

        no = 101L;
        answer = new AnswerVO(no, "tester01", "답변 등록 테스트");

        // 등록
        dao.save(answer);

    } // add()

//    @After
//    public void tearDown() throws Exception {
//
//        no = answer.getNo();
//
//        // 삭제
//        dao.delete(no);
//
//        // 삭제 후 확인
//        AnswerVO deletedAnswer = dao.findByNo(no);
//
//    } // delete()

    @Test
    //@Ignore
    public void update() {

        no = answer.getNo();

        // 등록 데이터 조회
        AnswerVO getVO = dao.findByNo(no);

        // 데이터 비교
        isSameData(getVO, answer);

        // 데이터 수정
        String updateStr = "_New";
        getVO.setContent(answer.getContent() + updateStr);

        dao.update(getVO);

//        // 다시 조회해서 비교
//        AnswerVO resultVO = dao.findByNo(no);
//
//        // 수정된 데이터 비교
//        isSameData(getVO, resultVO);

    } // update()


    @Test
    @Ignore
    public void findByNo() throws Exception {

        // 조회
        no = answer.getNo();
        AnswerVO outVO = dao.findByNo(no);

        // 조회 데이터 비교
        isSameData(outVO, answer);

    } // findByNo()


    // 조회된 데이터와 동일한지 비교하는 메서드
    public void isSameData(AnswerVO outVO, AnswerVO answer) {

        assertEquals(outVO.getId(), answer.getId());
        assertEquals(outVO.getContent(), answer.getContent());

    } // isSameData()

    @Test
    @Ignore
    public void bean() {
        assertNotNull(dao);
    } // bean()

} // class end
