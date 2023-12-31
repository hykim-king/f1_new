package com.roadscanner.dao.user;

import java.sql.SQLException;

import com.roadscanner.domain.user.MemberVO;

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
		
	/**
	 * 아이디 여부  체크
	 * @param user
	 * @return 해당 id
	 * @throws SQLException
	 */
	public MemberVO searchId(MemberVO user) throws SQLException;
	
	/**
	 * 회원 등급 검색
	 * @param user
	 * @return 1: 일반회원 / 2: 관리자 / 3: 정지회원
	 * @throws SQLException
	 */
	public MemberVO searchgrade(MemberVO user) throws SQLException;
	
	/**
	 * 비밀번호 여부  체크
	 * @param user
	 * @return 암호화(BCrypt)된 비밀번호
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
	 * @return 1: 중복 PW 존재 / 0: 중복 PW 없음
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
	 * @return 1: 수정 성공 / 2: 입력값 오류 > 수정 실패 / 3: 같은 비밀번호 > 수정 실패
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
	
	/**
	 * 이메일 중복체크
	 * @param user
	 * @return 1: 중복 이메일 존재 / 0: 중복 이메일 없음
	 * @throws SQLException
	 */
	public int emailCheck(MemberVO user) throws SQLException;
	
	/**
	 * 회원가입
	 * @param user
	 * @return 1: 성공 , 0: 실패
	 * @throws SQLException
	 */
	public int insertOne(MemberVO user) throws SQLException;

	/**
	 * 계정 단건 삭제
	 * @param user
	 * @return 1: 성공 , 0: 실패
	 * @throws SQLException
	 */
	public int deleteOne(MemberVO user) throws SQLException;
		
	/**
	 * 등급 변경
	 * @param user
	 * @return 등급 3으로 변경 -> 아이디 정지 
	 * @throws SQLException
	 */
	public int forbiddenGrade(MemberVO user) throws SQLException;
	
	/**
	 * 등급 변경
	 * @param user
	 * @return 등급 1로 변경 -> 정지 해제
	 * @throws SQLException
	 */
	public int clearGrade(MemberVO user) throws SQLException;
	
	/**
	 * 비밀번호 재설정 페이지 전용
	 * @param user
	 * @return 1: 성공, 0: 실패
	 * @throws SQLException
	 */
	public int changePw(MemberVO user) throws SQLException;
	
	/**
	 * ID찾기 페이지 아이디찾기 때 등급 반환
	 * @param user
	 * @return
	 * @throws SQLException
	 */
	public MemberVO findIdGrade(MemberVO user) throws SQLException;
	
	/**
	 * PW찾기 페이지 비밀번호 찾기 때 등급 반환
	 * @param user
	 * @return
	 * @throws SQLException
	 */
	public MemberVO findPwGrade(MemberVO user) throws SQLException;

}