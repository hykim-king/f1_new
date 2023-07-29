package com.roadscanner.domain;

//VO(Value Object)
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

	public String getRid() {
		return rid;
	}

	public String getRpassword() {
		return rpassword;
	}

	public String getRemail() {
		return remail;
	}

	public int getRgrade() {
		return rgrade;
	}

	public String getRdate() {
		return rdate;
	}

	public int getRnumber() {
		return rnumber;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public void setRpassword(String rpassword) {
		this.rpassword = rpassword;
	}

	public void setRemail(String remail) {
		this.remail = remail;
	}

	public void setRgrade(int rgrade) {
		this.rgrade = rgrade;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public void setRnumber(int rnumber) {
		this.rnumber = rnumber;
	}

	@Override
	public String toString() {
		return "MemberVO [rid=" + rid + ", rpassword=" + rpassword + ", remail=" + remail + ", rgrade=" + rgrade
				+ ", rdate=" + rdate + ", rnumber=" + rnumber + ", toString()=" + super.toString() + "]";
	}	
	
}