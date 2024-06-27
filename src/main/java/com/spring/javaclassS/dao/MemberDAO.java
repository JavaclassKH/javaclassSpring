package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemberPasswordUpdate(@Param("mid") String mid,@Param("imsiPwd") String imsiPwd);

	public void setMemberInfoUpdate(@Param("mid") String mid,@Param("point") int point);

	public int setPwdChangeOk(@Param("mid") String mid,@Param("pwd") String pwd);

	public ArrayList<MemberVO> getMemberList(@Param("level") int level);

}
