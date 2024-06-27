package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.common.JavaclassProvide;
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
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		model.addAttribute("mVo", mVo);
		
		return "member/memberMain";
	}
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
		
		@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
		public String memberLogoutGet(HttpSession session) {
			String mid = (String)session.getAttribute("sMid");
			session.invalidate();
			
			return "redirect:/message/memberLogout?mid="+mid;
		}
		
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "mid", defaultValue = "hkd1234", required = false) String mid,
			@RequestParam(name = "pwd", defaultValue = "1234", required = false) String pwd,			
			@RequestParam(name = "idSave", defaultValue = "NO", required = false) String idSave		
		) {
		// 로그인 인증처리(비밀번호)
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 로그인 인증 완료(session처리, cookie처리, 기타 설정값)
			
			// 1) session처리
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 2) cookie 처리
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				cookieMid.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			// 3) 기타 처리(주로 DB에 처리할 것들[방문카운트, 포인트 등])
			int point = 10;
			
			// 방문카운트 
			memberService.setMemberInfoUpdate(mid, point);
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";			
		}
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
		UUID uid = UUID.randomUUID();
		String oFileName = vo.getPhoto();
		String sFileName = vo.getMid() + "_" + uid.toString().substring(0, 8) + "_" + oFileName;
		
		//javaclassProvide.writeFile(fName, sFileName, "member");
		
		// 회원가입처리
		int res = 0;
		res = memberService.setMemberJoinOk(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/memberNewPassword", method = RequestMethod.POST)
	public String memberNewPasswordPost(String mid, String email, HttpSession session) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
				
		
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보 확인 후 정보가 맞다면 비밀번호를 임시로 발급후 비밀번호를 업데이트하고 메일로 전송한다
			String imsiPwd = UUID.randomUUID().toString().substring(0,8);			
			
			memberService.setMemberPasswordUpdate(mid, passwordEncoder.encode(imsiPwd));
			
			// 발급된 임시비밀번호를 사용자의 메일로 전송한다!
			String title = "임시비밀번호를 안내합니다";
			String mailFlag = "발급된 임시비밀번호는 : " + imsiPwd + " 입니다";
			
			String res = mailSend(email, title, mailFlag);
			
			// 새 비밀번호 발급시 sLogin이라는 세션은 발생시킨 후 2분안에 로그인할 수 있게 처리
			// 
			
			session.setAttribute("sLogin", "OK");
			
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
	
	
	@RequestMapping(value = "/memberPwdCheck/{pwdFlag}", method = RequestMethod.GET)
	public String memberPwdCheckGet(@PathVariable String pwdFlag, Model model) {
		
		
		model.addAttribute("pwdFlag", pwdFlag);
		
		return "member/memberPwdCheck";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberPwdChangeOk", method = RequestMethod.POST)
	public String memberPwdChangeOkPost(String mid, String pwd) {				
		return memberService.setPwdChangeOk(mid, passwordEncoder.encode(pwd)) + "";
	}
	
	
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model, HttpSession session) {
		int level = session.getAttribute("sLevel") == null ? 0 : (int) session.getAttribute("sLevel");
		ArrayList<MemberVO> vos = memberService.getMemberList(level);
		model.addAttribute("vos", vos);
		
		return "member/memberList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}




























