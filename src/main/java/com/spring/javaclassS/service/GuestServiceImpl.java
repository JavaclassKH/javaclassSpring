package com.spring.javaclassS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.GuestDAO;
import com.spring.javaclassS.vo.GuestVO;

@Service
public class GuestServiceImpl implements GuestService {

	@Autowired
	GuestDAO guestDAO;
	@Override
	public int setGuestInput(GuestVO vo) {
		return guestDAO.setGuestInput(vo);
	}

	@Override
	public int getTotRecCnt() {
		return guestDAO.getTotRecCnt();
	}

	@Override
	public List<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		return guestDAO.getGuestList(startIndexNo, pageSize);
	}
	
	
}
