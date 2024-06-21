package com.spring.javaclassS.dao;

import java.util.List;

import com.spring.javaclassS.vo.UserVO;

public interface UserDAO {
	
	public List<UserVO> getUserList();

	public int setUserDelete(int idx);

	public int setUserInputOk(UserVO vo);

	public UserVO getUserSearch(String mid);

	public int setUserInfoUpdate(UserVO vo);





}