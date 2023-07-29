package com.roadscanner.dao;

import com.roadscanner.dto.BoardDTO;

import java.util.List;

public interface BoardMapper {
    List<BoardDTO> selectAllPost();

    BoardDTO selectBoardById(Long qIdx);

    void insertBoard(BoardDTO post);

    void updateBoard(BoardDTO post);

    void deleteBoard(Long qIdx);
}
