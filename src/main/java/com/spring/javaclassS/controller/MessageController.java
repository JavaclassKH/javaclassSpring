package com.spring.javaclassS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
			) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "ȸ�� �ڷᰡ �����Ǿ����ϴ�!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "ȸ�� �ڷ� ���� ����!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userInputOk")) {
			model.addAttribute("msg", "ȸ�� �ڷ� ��� ����!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("msg", "ȸ�� �ڷ� ��� ����!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("updateOk")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("updateNo")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("dbtestDeleteOk")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestDeleteNo")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestInputOk")) {
			model.addAttribute("msg", "ȸ�� ���� �Է� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestInputNo")) {
			model.addAttribute("msg", "ȸ�� ���� �Է� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestUpdateOk")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestUpdateNo")) {
			model.addAttribute("msg", "ȸ�� ���� ���� ����!");
			model.addAttribute("url", "/dbtest/dbtestList");
		}
		else if(msgFlag.equals("dbtestIdCheckOk")) {
			model.addAttribute("msg", "�̹� ������� ���̵��Դϴ�.");
			model.addAttribute("flag", "OK");
			model.addAttribute("url", "/dbtest/dbtestWindow");
		}
		else if(msgFlag.equals("dbtestIdCheckNo")) {
			model.addAttribute("msg", "��� ������ ���̵��Դϴ�");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "/dbtest/dbtestWindow");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "���� ���ۿ� �����߽��ϴ�!");
			model.addAttribute("flag", "OK");
			model.addAttribute("url", "/study/mail/mailForm");
		}
		else if(msgFlag.equals("mailSendNo")) {
			model.addAttribute("msg", "���� ���ۿ� �����߽��ϴ�");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "/dbtest/dbtestWindow");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글 등록이 완료되었습니다");
			model.addAttribute("flag", "OK");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록에 글 등록이 실패하였습니다");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "guest/guestInput");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입되었습니다. 로그인해주세요.");
			model.addAttribute("flag", "OK");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입되지 않았습니다. 다시 시도해주세요.");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("midCheckNo")) {
			model.addAttribute("msg", "사용중인 아이디입니다");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "사용중인 닉네임입니다");
			model.addAttribute("flag", "NO");
			model.addAttribute("url", "member/memberJoin");
		}

		
		return "include/message";
	}
	
}
