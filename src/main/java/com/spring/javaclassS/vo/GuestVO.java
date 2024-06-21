package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GuestVO {

	private int idx;
	private String name;
	private String content;
	private String email;
	private String homePage;
	private String visitDate;
	private String datetime;
	private String hostIp;
	
}