package com.spring.javaclassS.vo;


import org.hibernate.validator.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings({ "deprecation", "unused" })
@Getter
@Setter
@ToString
public class TransactionVO {
	
	private int idx;
	
	@NotEmpty
	private String mid;
	
	private String name;
	private int age;
	private String address;
	
	// user2 테이블의 필드 추가
	private String job;
	
}

