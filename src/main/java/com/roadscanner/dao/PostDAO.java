package com.roadscanner.dao;

import com.roadscanner.dto.Posts;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostDAO {

    List<Posts> getAllPosts();

    int createPost(Posts post);

    Posts getPostById(Long id);

    void deletePost(Long id);

    int updatePost(Posts post);

    // 조회수 증가
    void incrementViewCount(Long id);

}
