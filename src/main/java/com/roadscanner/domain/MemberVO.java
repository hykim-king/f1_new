package com.roadscanner.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@ToString

public class MemberVO {
	private String rid; // 회원 아이디
	private String rpassword; // 회원 비밀번호
	private String remail; // 회원 이메일
	private int rgrade;// 회원 등급
	private String rdate;	// 가입일
	private int rnumber;	//회원 번호(시퀀스)
	
	public MemberVO() {	}

	public MemberVO(String rid, String rpassword) {
		super();
		this.rid = rid;
		this.rpassword = rpassword;
		
	}
	
}