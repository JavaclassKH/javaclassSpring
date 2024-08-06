package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QrCodeVO {
	
	// 개인정보 담을 필드
	private String mid;
	private String name;
	private String email;	
	
	// 소개하고픈 사이트주소 필드
	private String moveUrl;	
	
	// 영화티켓정보를 담는 필드
	private String movieName;	
	private String movieDate;	
	private String movieTime;	
	private String movieAdult;	
	private String movieChild;	

	private String publishDate;	
	private String qrCodeName;	
}
