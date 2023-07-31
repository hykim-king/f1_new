package com.roadscanner.dao;

import com.roadscanner.dto.PostDTO;

import java.util.List;

public interface PostDAO {

    // 전체 게시굴 찾기
    List<PostDTO> getAllPosts();

    // 게시글 읽기
    PostDTO getPostById(Long id);

    // 게시글 작성
    void createPost(PostDTO postDTO);

    // 게시글 업데이트
    void updatePost(PostDTO postDTO);

    // 게시글 삭제
    void deletePost(Long id);

}
