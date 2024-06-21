package com.spring.javaclassS.controller;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet() {
		
		return "member/memberMain";
	}
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet() {
		
		return "member/memberLogin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		
		return "member/memberJoin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
	public String memberIdCheckGet(String mid) {
		MemberVO vo  = memberService.getMemberIdCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.GET)
	public String memberNickCheckGet(String nickName) {
		MemberVO vo  = memberService.getMemberNickCheck(nickName);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 아이디, 닉네임 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/midCheckNo";
		else if(memberService.getMemberNickCheck(vo.getNickName()) != null) return "redirect:/message/nickCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원사진저장(서비스 객체에서 처리후 저장)

		// 회원가입처리
		int res = 0;
		res = memberService.setMemberJoinOk(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/memberNewPassword", method = RequestMethod.POST)
	public String memberNewPasswordPost(String mid, String email) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
				
		
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보 확인 후 정보가 맞다면 비밀번호를 임시로 발급후 비밀번호를 업데이트하고 메일로 전송한다
			String imsiPwd = UUID.randomUUID().toString().substring(0,8);			
			
			memberService.setMemberPasswordUpdate(mid, passwordEncoder.encode(imsiPwd));
			
			// 발급된 임시비밀번호를 사용자의 메일로 전송한다!
			String title = "임시비밀번호를 안내합니다";
			String mailFlag = "발급된 임시비밀번호는 : " + imsiPwd + " 입니다";
			
			String res = mailSend(email, title, mailFlag);
			
			if(res.equals("1")) return "1";
			
			
			
			
		}
		else {

		}
		
		
		
		return "0";
	}

	
	
	// 메일로 전송하기(아이디찾기, 비밀번호찾기)
	private String mailSend(String toMail, String title, String content) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	
		
		
		
		
		
		// ���������� ���� ��ü 2���� : MimeMessage() , MimeMessageHelper();
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// ���� �����Կ� �ۼ��� �޽������� ������ ��� �����Ų �� �۾��ϱ�
		messageHelper.setTo(toMail);       // �޴� ��� �����ּ�
		messageHelper.setSubject(title);   // ���� ����
		messageHelper.setText(content);    // ���� ����
		
		// �������� ����(content)�� �߽����� �ʿ��� ������ �߷� ��Ƽ� ����ó���Ѵ�
		content = content.replace("\n", "<br>");
		content += "<br><hr/><h3>"+content+"</h3>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// ���� �����ϱ�
		mailSender.send(message);		
		
		
		
		return "1";
	}
	
}




























