package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.UserVO;
// �򰥸��� �ʰ� @Param ������̼��� ���� ����ϴ� ���� ����
public interface DbtestDAO {

	public ArrayList<UserVO> getDbtestList();
	
	public ArrayList<UserVO> getDbtestSearch(@Param("mid") String mid);

	public int setDbtestDelete(@Param("idx") int idx);

	public int setDbtestInputOk(@Param("vo") UserVO vo);

	public int setdbtestUpdateOk(@Param("vo") UserVO vo);

	public UserVO getDbtestIdCheck(@Param("mid") String mid);

	public List<UserVO> getMemberNameList();

	public int getMemberAge(@Param("name") String name);

	public List<UserVO> getMemberInfosName(@Param("name") String name);

	public List<UserVO> getMemberInfosByAge(@Param("age") int age);

	public List<UserVO> getMemberInfosByAddress(@Param("address") String address);

	
	
}
