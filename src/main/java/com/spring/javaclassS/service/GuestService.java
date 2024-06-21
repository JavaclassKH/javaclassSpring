package com.spring.javaclassS.service;

import java.util.List;

import com.spring.javaclassS.vo.GuestVO;

public interface GuestService {

	public List<GuestVO> getGuestList(int startIndexNo, int pageSize);

	public int setGuestInput(GuestVO vo);

	public int getTotRecCnt();

}
