package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String imsiPwd);

	public void setMemberInfoUpdate(String mid, int point);

	public int setPwdChangeOk(String mid, String pwd);

	public ArrayList<MemberVO> getMemberList(int level);

	
	
}
