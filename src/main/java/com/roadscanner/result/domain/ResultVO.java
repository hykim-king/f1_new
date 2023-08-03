package com.roadscanner.result.domain;

public class ResultVO {
	private int no; // 표지판 번호
	private String name; // 표지판 이름
	private String content; // 표지판 내용
	private String url; // URL : S3 저장 링크
	
	public ResultVO() {
	}

	public ResultVO(int no, String name, String content, String url) {
		super();
		this.no = no;
		this.name = name;
		this.content = content;
		this.url = url;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "ResultVO [no=" + no + ", name=" + name + ", content=" + content + ", url=" + url + "]";
	}

	
}
