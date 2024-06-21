package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public List<UserVO> getMemberNameList();

	public int getMemberAge(String name);

	public List<UserVO> getMemberInfosName(String name);

	public List<UserVO> getMemberInfosByAge(int age);

	public List<UserVO> getMemberInfosByAddress(String address);

	public UserVO getUserMidSearch(String mid);

	public List<UserVO> getUserMidList(String mid);

	public void setSaveCrimeData(CrimeVO vo);



}
