package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CrimeVO {
	private int idx;
	private int year;
	private String police;
	private int robbery;
	private int theft;
	private int murder;
	private int violence;
	
}
