package com.roadscanner.dao;

import com.roadscanner.dto.Posts;

import java.util.List;

public interface PostDAO {

    List<Posts> getAllPosts();

    int createPost(Posts post);

    Posts getPostById(Long id);

    void deletePost(Long id);

    int updatePost(Posts post);

    // 조회수 증가
    void incrementViewCount(Long id);

}
