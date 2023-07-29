package com.roadscanner.user.dao;

import java.sql.SQLException;

import com.roadscanner.domain.MemberVO;



public interface UserDao {
	
    /**
     * 회원 탈퇴 처리
     * @param user 회원 정보 (아이디와 회원 탈퇴 시 입력한 비밀번호가 담긴 객체)
     * @return 1: 탈퇴 성공, 0: 비밀번호가 일치하지 않아 탈퇴 실패
     * @throws SQLException
     */
    public int withdraw(MemberVO user) throws SQLException;

	
	/**
	 * id를 사용하여 회원정보 출력
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	public MemberVO selectOne(MemberVO inVO) throws SQLException;
	
	public MemberVO  selectOneMypage(MemberVO inVO) throws SQLException;
	
	/**
	 * 아이디 여부  체크
	 * @param user
	 * @return 해당 id
	 * @throws SQLException
	 */
	public MemberVO searchId(MemberVO user) throws SQLException;

	
	/**
	 * 비밀번호 여부  체크
	 * @param user
	 * @return 해당 pw
	 * @throws SQLException
	 */
	public MemberVO searchPw(MemberVO user) throws SQLException;
	/**
	 * 아이디 존재 여부  체크
	 * @param user
	 * @return 해당 id
	 * @throws SQLException
	 */
	public int searchIdCheck(MemberVO user) throws SQLException;
	
	/**
	 * 패스워드 존재 여부  체크
	 * @param user
	 * @return 해당 id
	 * @throws SQLException
	 */
	public int searchPwCheck(MemberVO user) throws SQLException;
	
	/**
	 * 비밀번호 변경
	 * @param user
	 * @return 1: id 존재 , 0: id 없음 
	 * @throws SQLException
	 */
	public int updatePw(MemberVO user) throws SQLException;
	
	/**
	 * 비밀번호 체크
	 * @param user
	 * @return 1: id 존재 , 0: id 없음 
	 * @throws SQLException
	 */
	public int passCheck(MemberVO user) throws SQLException;
	
	/**
	 * 아이디 체크
	 * @param user
	 * @return 1: id 존재 , 0: id 없음 
	 * @throws SQLException
	 */
	public int idCheck(MemberVO user) throws SQLException;
	public int emailCheck(MemberVO user) throws SQLException;
	
	/**
	 * 회원가입
	 * @param user
	 * @return 1: 성공 , 0: 실패
	 * @throws SQLException
	 */
	public int addUser(MemberVO user) throws SQLException;

	/**
	 * 계정 단건 삭제
	 * @param user
	 * @return 1: 성공 , 0: 실패
	 * @throws SQLException
	 */
	public int deleteOne(MemberVO user) throws SQLException;
	
	/**
	 * 회원정보 변경
	 * @param user
	 * @return 1: 성공 , 0: 실패 
	 * @throws SQLException
	 */
	public int updateUser(MemberVO user) throws SQLException;
}