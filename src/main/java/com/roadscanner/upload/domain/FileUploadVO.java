package com.roadscanner.upload.domain;

import com.roadscanner.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode
@NoArgsConstructor // Default생성자
@AllArgsConstructor // 모든 인자를 가진 생성자
public class FileUploadVO extends DTO {
	private int uIdx; // 이미지 ID
	private String uId; // 사용자 ID
	private int uDiv; // 구분 : 기본(10), 좋아요(20), 싫어요(30), 문의사항(40)
	private String uDate; // 등록일
	private String uName; // 저장파일명 : YYMMDDHH24MISS_원본파일명
	private String uUrl; // URL : S3 저장 링크
	private int uSize; // 파일크기 (kb로 저장)
	private int u1; // 싫어요 이유1
	private int u2; // 싫어요 이유2
	private int uCheck; // 검토완료

	// Not Null인 인자만 있는 생성자
	public FileUploadVO(int uIdx, String uId, int uDiv, String uDate, String uName, String uUrl, int uSize,
			int uCheck) {
		super();
		this.uIdx = uIdx;
		this.uId = uId;
		this.uDiv = uDiv;
		this.uDate = uDate;
		this.uName = uName;
		this.uUrl = uUrl;
		this.uSize = uSize;
		this.uCheck = uCheck;
	}

}
