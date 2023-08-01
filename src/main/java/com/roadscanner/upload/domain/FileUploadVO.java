package com.roadscanner.upload.domain;

import com.roadscanner.cmn.DTO;

public class FileUploadVO extends DTO {
	private int uIdx; // 이미지 ID
	private String id; // 사용자 ID
	private int uDiv; // 구분 : 기본(10), 좋아요(20), 싫어요(30), 문의사항(40)
	private String uDate; // 등록일
	private String uName; // 저장파일명 : YYMMDDHH24MISS_원본파일명
	private String uUrl; // URL : S3 저장 링크
	private int uSize; // 파일크기 (kb로 저장)
	private int u1; // 싫어요 이유1
	private int u2; // 싫어요 이유2
	private int uCheck; // 검토완료
	
	// Default 생성자
	public FileUploadVO() {
	}

	// 모든 인자 있는 생성자
	public FileUploadVO(int uIdx, String id, int uDiv, String uDate, String uName, String uUrl, int uSize, int u1,
			int u2, int uCheck) {
		super();
		this.uIdx = uIdx;
		this.id = id;
		this.uDiv = uDiv;
		this.uDate = uDate;
		this.uName = uName;
		this.uUrl = uUrl;
		this.uSize = uSize;
		this.u1 = u1;
		this.u2 = u2;
		this.uCheck = uCheck;
	}
	
	// Not Null인 인자만 있는 생성자
	public FileUploadVO(int uIdx, String id, int uDiv, String uDate, String uName, String uUrl, int uSize, int uCheck) {
		super();
		this.uIdx = uIdx;
		this.id = id;
		this.uDiv = uDiv;
		this.uDate = uDate;
		this.uName = uName;
		this.uUrl = uUrl;
		this.uSize = uSize;
		this.uCheck = uCheck;
	}
	
	// getter, setter
	public int getuIdx() {
		return uIdx;
	}

	public void setuIdx(int uIdx) {
		this.uIdx = uIdx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getuDiv() {
		return uDiv;
	}

	public void setuDiv(int uDiv) {
		this.uDiv = uDiv;
	}

	public String getuDate() {
		return uDate;
	}

	public void setuDate(String uDate) {
		this.uDate = uDate;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	public String getuUrl() {
		return uUrl;
	}

	public void setuUrl(String uUrl) {
		this.uUrl = uUrl;
	}

	public int getuSize() {
		return uSize;
	}

	public void setuSize(int uSize) {
		this.uSize = uSize;
	}

	public int getU1() {
		return u1;
	}

	public void setU1(int u1) {
		this.u1 = u1;
	}

	public int getU2() {
		return u2;
	}

	public void setU2(int u2) {
		this.u2 = u2;
	}

	public int getuCheck() {
		return uCheck;
	}

	public void setuCheck(int uCheck) {
		this.uCheck = uCheck;
	}
	
	// toString()
	@Override
	public String toString() {
		return "FileUploadVO [uIdx=" + uIdx + ", id=" + id + ", uDiv=" + uDiv + ", uDate=" + uDate + ", uName=" + uName
				+ ", uUrl=" + uUrl + ", uSize=" + uSize + ", u1=" + u1 + ", u2=" + u2 + ", uCheck=" + uCheck
				+ ", toString()=" + super.toString() + "]";
	}

}
