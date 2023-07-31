package com.roadscanner.dao;

import com.roadscanner.dto.Posts;

import java.util.List;

public interface PostDAO {

    List<Posts> getAllPosts();

    void createPost(Posts post);

    Posts getPostById(Long id);
}
