package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS.service.DbtestService;
import com.spring.javaclassS.service.UserService;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/dbtest")
public class DbtestController {
	
	@Autowired
	DbtestService dbtestService;
	
	// ȸ������ �ҷ�����
	@RequestMapping(value = "/dbtestList", method = RequestMethod.GET)
	public String dbtestListGet(Model model) {
		
		ArrayList<UserVO> vos = dbtestService.getDbtestList(); 
		model.addAttribute("vos", vos);
		
		return "user/dbtestList";		
	}
	
	// ȸ������ �˻�
	@RequestMapping(value = "/dbtestSearch/{mid}", method = RequestMethod.GET)
	public String dbtestSearchGet(Model model, @PathVariable String mid) {
		
		ArrayList<UserVO> vos = dbtestService.getDbtestList(); 
		ArrayList<UserVO> searchVos = dbtestService.getDbtestSearch(mid); 
		model.addAttribute("vos", vos);
		model.addAttribute("searchVos", searchVos);
		
		return "user/dbtestList";		
	}
	
	// ȸ������ ����
	@RequestMapping(value = "/dbtestDelete", method = RequestMethod.GET)
	public String dbtestDeleteGet(@RequestParam int idx, 
		@RequestParam(name = "tempFlag", defaultValue = "", required = false) String tempFlag) {
		int res = dbtestService.setDbtestDelete(idx); 
		
		if(res != 0) return "redirect:/message/dbtestDeleteOk?tempFlag="+tempFlag;		
		else return "redirect:/message/dbtestDeleteNo";		

	}
	
	// ȸ������ �Է�(ȸ������)
	@RequestMapping(value = "/dbtestInputOk", method = RequestMethod.POST)
	public String dbtestInputOkPost(UserVO vo) {
		
		String mid = vo.getMid();
		
		int res = dbtestService.setDbtestInputOk(vo); 
		
		if(res != 0) return "redirect:/message/dbtestInputOk";		
		else return "redirect:/message/dbtestInputNo";		
		
	}
	
	// ȸ������ ����
	@RequestMapping(value = "/dbtestUpdateOk", method = RequestMethod.POST)
	public String dbtestUpdateOkPost(UserVO vo) {
		int res = dbtestService.setdbtestUpdateOk(vo); 
		
		if(res != 0) return "redirect:/message/dbtestUpdateOk";		
		else return "redirect:/message/dbtestUpdateNo";		
		
	}
	
	// ���̵� �ߺ�üũ
	@RequestMapping(value = "/dbtestIdCheck", method = RequestMethod.GET)
	public String getdbtestIdCheckPost(Model model, @RequestParam String mid) {
		UserVO vo = dbtestService.getDbtestIdCheck(mid);

		String idCheck = "";
		if(vo != null) idCheck = "NO";
		else idCheck = "OK";
		model.addAttribute("idCheck", idCheck);		
		model.addAttribute("mid", mid);		
		
		return "user/dbtestWindow";		
	}
	

	
	
	
}










