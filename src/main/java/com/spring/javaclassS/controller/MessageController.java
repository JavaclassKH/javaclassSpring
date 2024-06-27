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
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize
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
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인하셨습니다");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인에 실패하였습니다\n입력하신 정보를 확인해주세요");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+" 님 로그아웃 되었습니다!");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "Upload Success");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "Upload Failure");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileDeleteAllOk")) {
			model.addAttribute("msg", "Delete All files Success");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "Only Administer can use this functions");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "Only Member can use this functions\njoin us First");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLevelNo")) {
			model.addAttribute("msg", "Only V.I.P can use this functions");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "Content upload success");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "Content upload failure");
			model.addAttribute("url", "/board/boardInput");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "Content update success");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "Content update failure");
			model.addAttribute("url", "/board/boardUpdate?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "Content delete success");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "Content delete failure");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("multiFileUploadOk")) {
			model.addAttribute("msg", "File Upload success");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("multiFileUploadNo")) {
			model.addAttribute("msg", "File Upload failure");
			model.addAttribute("url", "study/fileUpload/multiFile");
		}
		else if(msgFlag.equals("pdsUploadOk")) {
			model.addAttribute("msg", "Pds insert success");
			model.addAttribute("url", "pds/pdsList");
		}
		else if(msgFlag.equals("pdsUploadNo")) {
			model.addAttribute("msg", "Pds insert failure");
			model.addAttribute("url", "pds/pdsInput");
		}

		
		return "include/message";
	}
	
}
