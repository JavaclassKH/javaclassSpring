package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.UserVO;

public interface DbtestService {

	public ArrayList<UserVO> getDbtestList();

	public ArrayList<UserVO> getDbtestSearch(String mid);

	public int setDbtestDelete(int idx);

	public int setDbtestInputOk(UserVO vo);

	public int setdbtestUpdateOk(UserVO vo);

	public UserVO getDbtestIdCheck(String mid);

}
