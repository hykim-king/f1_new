package com.roadscanner.dao;

import com.roadscanner.config.DatabaseConfig;
import com.roadscanner.config.MyBatisConfig;
import com.roadscanner.dto.PostDTO;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringJUnitConfig(classes = {DatabaseConfig.class, MyBatisConfig.class})
class PostDAOTest {

    @Autowired
    PostDAO postDAO;

    @AfterEach
    void cleanup() {
        List<PostDTO> allPosts = postDAO.getAllPosts();
        for (PostDTO post : allPosts) {
            postDAO.deletePost(post.getId());
        }
    }

    @DisplayName("게시글 저장_불러오기")
    @Test
    void createAndRead() {

        // given
        PostDTO postDTO = createPost();
        postDAO.createPost(postDTO); // 글 작성

        // when
        List<PostDTO> postList = postDAO.getAllPosts();

        // then
        PostDTO posts = postList.get(0);
        assertThat(posts.getTitle()).isEqualTo("테스트 게시글");
        assertThat(posts.getContent()).isEqualTo("테스트 본문");
    }

    private PostDTO createPost() {
        return PostDTO.builder()
                .title("테스트 게시글")
                .category("답변 완료")
                .content("테스트 본문")
                .author("admin")
                .build();
    }
}