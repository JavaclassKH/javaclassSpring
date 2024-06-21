package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS.service.DbtestService;
import com.spring.javaclassS.service.StudyService;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.MailVO;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	DbtestService dbtestService;
	
	@Autowired
	JavaMailSender mailSender;
	

	@RequestMapping(value = "ajax/ajaxForm", method = RequestMethod.GET)
	public String ajaxFormGet() {
		
		return "study/ajax/ajaxForm";	
	}
	
	@ResponseBody
	@RequestMapping(value = "ajax/ajaxTest1", method = RequestMethod.POST)
	public String ajaxTest1Post(int idx) {
		
		return idx + "";	
	}
	
	@ResponseBody
	@RequestMapping(value = "ajax/ajaxTest2", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String ajaxTest2Post(String str) {
		
		return str;	
	}
	
	@RequestMapping(value = "ajax/ajaxTest3_1", method = RequestMethod.GET)
	public String ajaxTest3_1Get() {
		
		return "study/ajax/ajaxTest3_1";	
	}
	
	@ResponseBody
	@RequestMapping(value = "ajax/ajaxTest3_1", method = RequestMethod.POST)
	public String[] ajaxTest3_1Post(String dodo) {
		
		return studyService.getCityStringArray(dodo);	
	}
	
	@RequestMapping(value = "ajax/ajaxTest3_2", method = RequestMethod.GET)
	public String ajaxTest3_2Get() {
		
		return "study/ajax/ajaxTest3_2";	
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest3_2Post(String dodo) {
		
		return studyService.getCityArrayList(dodo);	
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3_3", method = RequestMethod.GET)
	public String ajaxTest3_3Get() {
		
		return "study/ajax/ajaxTest3_3";	
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest3_3Post(String dodo) {
		
		ArrayList<String> vos = studyService.getCityArrayList(dodo);	
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		//return studyService.getCityHashMap(dodo);	
		return map;
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3_4", method = RequestMethod.GET)
	public String ajaxTest3_4Get(Model model) {
		
		List<UserVO> vos = studyService.getMemberNameList();		
		model.addAttribute("vos", vos);
		
		return "study/ajax/ajaxTest3_4";	
	}

	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_4", method = RequestMethod.POST)
	public List<UserVO> ajaxTest3_4Post(String what, String flag) {
		List<UserVO> vos = null; 
		if(flag.equals("na")) {
			String name = what; 
			return studyService.getMemberInfosName(name);
		}
		else if(flag.equals("ag")) {
			int age = Integer.parseInt(what); 
			return studyService.getMemberInfosByAge(age);
		}
		else if(flag.equals("ad")) {
			String address = what; 
			return studyService.getMemberInfosByAddress(address);
		}
		return vos;
	}
	
	/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
	/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
	/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest4-1", method = RequestMethod.POST)
	public UserVO ajaxTest4_1Post(String mid) {				
		return studyService.getUserMidSearch(mid);	
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest4-2", method = RequestMethod.POST)
	public List<UserVO> ajaxTest4_2Post(String mid) {		
		return studyService.getUserMidList(mid);	
	}
	
	@RequestMapping(value = "/restapi/restapi", method = RequestMethod.GET)
	public String restapiGet(String mid) {		
		
		return "study/restapi/restapi";	
	}
	
	@RequestMapping(value = "/restapi/restapiTest1/{str}", method = RequestMethod.GET)
	public String restapiTest1Get(@PathVariable String str) {		
		
		System.out.println(str);
		
		
		
		return "str : " + str;	
	}
	
	
	@RequestMapping(value = "/restapi/restapiTest4", method = RequestMethod.GET)
	public String RestapiTest4Get() {
		
		
		return "study/restapi/restapiTest4";
	}
	
	@ResponseBody
	@RequestMapping(value = "/restapi/saveCrimeData", method = RequestMethod.POST)
	public void saveCrimeDataPost(CrimeVO vo) {
		studyService.setSaveCrimeData(vo);
	}
	
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailformGet() {
		
		return "study/mail/mailForm";
	}
	
	// 메일 전송하기
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailformPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일전송을 위한 객체 2가지 : MimeMessage() , MimeMessageHelper();
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일 보관함에 작성한 메시지들의 정보를 모두 저장시킨 후 작업하기
		messageHelper.setTo(toMail);       // 받는 사람 메일주소
		messageHelper.setSubject(title);   // 메일 제목
		messageHelper.setText(content);    // 메일 내용
		
		// 보관함의 내용(content)에 발신자의 필요한 정보를 추로 담아서 전송처리한다
		content = content.replace("\n", "<br>");
		content += "<br><hr/><h3>Send to you from javaclass</h3>";
		content += "<p><img src=\"cid:Main.png\" width='1200px'></p>";
		content += "<p>방 문 하 기 : <a href='http://49.142.157.251:9090/javaclassJ11/Lobby'>javaclass</a></p>";
		content += "<hr>";
		content += "<strong>끝</strong>";
		messageHelper.setText(content, true);
		
		// 메일에 첨부할 그림파일 경로를 별도로 표시한 뒤 다시 보관함에 저장!
		String path = request.getSession().getServletContext().getRealPath("/resources/images/Main.png");
		FileSystemResource fi = new FileSystemResource(path);
		messageHelper.addInline("Main.png", fi);	
		
		// 첨부파일 보내기
		//fi = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/paris.jpg"));
		//messageHelper.addAttachment("paris.jpg", fi);
		
		// 압축파일 보내기
		//fi = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/citys.zip"));
		//messageHelper.addAttachment("citys.zip", fi);
		
		// 메일 전송하기
		mailSender.send(message);		
		
		
		
		return "redirect:/message/mailSendOk";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
