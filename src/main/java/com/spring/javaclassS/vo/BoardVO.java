package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private int readNum;
	private String hostIp;
	private String openSw;
	private String wDate;
	private int good;
	private String complain; // 신고글 공개여부 확인
	
	
	private int hour_diff; // 게시글 작성시간으로부터 24시간 경과여부 확인
	private int date_diff; // 게시글 작성일로부터 1일 경과여부 확인
	private int replyCount; // 게시글에 달린 댓글수 저장	

	
	private int d; // 게시글에 달린 댓글수 저장	
	private int a; // 게시글에 달린 댓글수 저장	
		
}