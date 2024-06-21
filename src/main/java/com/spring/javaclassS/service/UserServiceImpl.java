package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.UserDAO;
import com.spring.javaclassS.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;

	@Override
	public List<UserVO> getUserList() {
		return userDAO.getUserList(); // 호출하자마자 DB로 가서 바로 가져온 뒤 return한다!
	}

	@Override
	public int setUserDelete(int idx) {
		return userDAO.setUserDelete(idx);
	}

	@Override
	public int setUserInputOk(UserVO vo) {
		return userDAO.setUserInputOk(vo);
	}

	@Override
	public UserVO getUserSearch(String mid) {
		return userDAO.getUserSearch(mid);
	}

	@Override
	public int setUserInfoUpdate(UserVO vo) {
		return userDAO.setUserInfoUpdate(vo);
	}


	
	
	
	
}
