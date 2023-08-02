package com.roadscanner.dao;

import com.roadscanner.dto.Posts;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.roadscanner.config.DatabaseConfig.class, com.roadscanner.config.MyBatisConfig.class})
public class PostDAOTest {

    @Autowired
    private PostDAO postDAO;

    private Long id;  // 데이터베이스에 ID는 자동생성 따라서 새로 만들어줌.

    @Before
    public void 게시글_작성() {
        Posts posts = Posts.builder()
                .category("공지")
                .title("테스트 제목")
                .content("테스트 내용")
                .author("admin")
                .createdDate(LocalDateTime.now())
                .updatedDate(LocalDateTime.now())
                .views(0)
                .build();

        postDAO.createPost(posts);
        id = posts.getId();
    }


    @After
    public void 게시글_삭제() {
        postDAO.deletePost(id);
    }

    @Test
    public void 전체게시글_확인() {
        // Given

        // When
        List<Posts> actualPosts = postDAO.getAllPosts();

        // Then
        assertEquals(1, actualPosts.size());
        assertEquals("공지", actualPosts.get(0).getCategory());
        assertEquals("테스트 제목", actualPosts.get(0).getTitle());
        assertEquals("테스트 내용", actualPosts.get(0).getContent());
    }

    @Test
    public void 게시글_읽기() {
        // Given

        // When
        Posts actualPost = postDAO.getPostById(id);  // Use the generated id

        // Then
        assertEquals("공지", actualPost.getCategory());
        assertEquals("테스트 제목", actualPost.getTitle());
        assertEquals("테스트 내용", actualPost.getContent());
    }

    @Test
    public void 게시글_수정() {
        // Given
        Posts originalPost = postDAO.getPostById(id);

        Posts updatedPost = Posts.builder()
                .id(originalPost.getId())
                .category("공지")
                .title("테스트 제목 - 수정됨")
                .content("테스트 내용 - 수정됨")
                .author(originalPost.getAuthor())
                .createdDate(originalPost.getCreatedDate())
                .updatedDate(LocalDateTime.now())
                .views(originalPost.getViews())
                .build();

        // When
        int updateOK = postDAO.updatePost(updatedPost);

        // Then
        assertEquals(1, updateOK);
        Posts updatePost = postDAO.getPostById(id);
        assertEquals("테스트 제목 - 수정됨", updatePost.getTitle());
        assertEquals("테스트 내용 - 수정됨", updatePost.getContent());
    }
}
