package com.spring.javaclassS.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.MemberDAO;
import com.spring.javaclassS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) { return memberDAO.getMemberIdCheck(mid); }

	@Override
	public MemberVO getMemberNickCheck(String nickName) { return memberDAO.getMemberNickCheck(nickName);}

	@Override
	public int setMemberJoinOk(MemberVO vo) { 
	
		// 사진처리
		vo.setPhoto("noimage.jpg");
		
		return memberDAO.setMemberJoinOk(vo); 
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String imsiPwd) {
		memberDAO.setMemberPasswordUpdate(mid, imsiPwd);
	}

	@Override
	public void setMemberInfoUpdate(String mid, int point) {
		memberDAO.setMemberInfoUpdate(mid, point);
	}

	@Override
	public int setPwdChangeOk(String mid, String pwd) {
		return memberDAO.setPwdChangeOk(mid, pwd);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int level) {
		return memberDAO.getMemberList(level);
	}
	
	
	
}
