package com.roadscanner.dao;

import com.roadscanner.dto.Posts;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("게시판 API V1 CRUD")
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {com.roadscanner.config.DatabaseConfig.class, com.roadscanner.config.MyBatisConfig.class})
public class PostDAOTest {

    @Autowired
    private PostDAO postDAO;

    private Long id;  // Created post's id

    @DisplayName("게시물 작성")
    @BeforeEach
    void setUp() {

        Posts posts = Posts.builder()
                .category("공지")
                .title("테스트 제목")
                .content("테스트 내용")
                .author("admin")
                .createdDate(LocalDateTime.now())
                .updatedDate(LocalDateTime.now())
                .build();
        postDAO.createPost(posts);

        id = posts.getId(); // Get the generated id
    }

    @DisplayName("게시물 삭제")
    @AfterEach
    void tearDown() {
        // Clear table after each test
        postDAO.deletePost(id);  // Use the generated id
    }

    @DisplayName("게시물 전체 확인")
    @Test
    public void getAllPosts() {
        // Given

        // When
        List<Posts> actualPosts = postDAO.getAllPosts();

        // Then
        assertEquals(1, actualPosts.size());
        assertEquals("공지", actualPosts.get(0).getCategory());
        assertEquals("테스트 제목", actualPosts.get(0).getTitle());
        assertEquals("테스트 내용", actualPosts.get(0).getContent());
        assertEquals("admin", actualPosts.get(0).getAuthor());
    }

    @DisplayName("게시물 읽기")
    @Test
    public void getPostById() {
        // Given

        // When
        Posts actualPost = postDAO.getPostById(id);  // Use the generated id

        // Then
        assertEquals("공지", actualPost.getCategory());
        assertEquals("테스트 제목", actualPost.getTitle());
        assertEquals("테스트 내용", actualPost.getContent());
        assertEquals("admin", actualPost.getAuthor());
    }

    @DisplayName("게시물 업데이트")
    @Test
    public void updatePost() {
        // Given
        Posts originalPost = postDAO.getPostById(id);

        Posts updatedPost = Posts.builder()
                .id(originalPost.getId())
                .category("공지")
                .title("테스트 제목 - 수정됨")
                .content("테스트 내용 - 수정됨")
                .author("admin")
                .createdDate(originalPost.getCreatedDate())
                .updatedDate(LocalDateTime.now())
                .build();

        // When
        int updateOK = postDAO.updatePost(updatedPost);

        // Then
        assertEquals(1, updateOK);
        Posts updatePost = postDAO.getPostById(id);
        assertEquals("테스트 제목 - 수정됨", updatePost.getTitle());
        assertEquals("테스트 내용 - 수정됨", updatePost.getContent());
    }

    @DisplayName("게시판 조회수 증가")
    @Test
    void incrementViewCount() {
        // Given
        Posts originalPost = postDAO.getPostById(id);

        // When
        postDAO.incrementViewCount(id);

        // Then
        Posts updatePost = postDAO.getPostById(id);
        assertEquals(originalPost.getViews()+ 1, updatePost.getViews());
    }
}