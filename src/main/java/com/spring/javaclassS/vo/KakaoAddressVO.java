package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoAddressVO {
	private String address;
	private double latitude;
	private double longitude;
}
