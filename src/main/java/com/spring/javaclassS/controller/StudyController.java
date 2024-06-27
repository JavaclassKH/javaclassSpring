package com.spring.javaclassS.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

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
	
	// ���� �����ϱ�
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailformPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// ���������� ���� ��ü 2���� : MimeMessage() , MimeMessageHelper();
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// ���� �����Կ� �ۼ��� �޽������� ������ ��� �����Ų �� �۾��ϱ�
		messageHelper.setTo(toMail);       // �޴� ��� �����ּ�
		messageHelper.setSubject(title);   // ���� ����
		messageHelper.setText(content);    // ���� ����
		
		// �������� ����(content)�� �߽����� �ʿ��� ������ �߷� ��Ƽ� ����ó���Ѵ�
		content = content.replace("\n", "<br>");
		content += "<br><hr/><h3>Send to you from javaclass</h3>";
		content += "<p><img src=\"cid:Main.png\" width='1200px'></p>";
		content += "<p>�� �� �� �� : <a href='http://49.142.157.251:9090/javaclassJ11/Lobby'>javaclass</a></p>";
		content += "<hr>";
		content += "<strong>��</strong>";
		messageHelper.setText(content, true);
		
		// ���Ͽ� ÷���� �׸����� ��θ� ������ ǥ���� �� �ٽ� �����Կ� ����!
		String path = request.getSession().getServletContext().getRealPath("/resources/images/Main.png");
		FileSystemResource fi = new FileSystemResource(path);
		messageHelper.addInline("Main.png", fi);	
		
		// ÷������ ������
		//fi = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/paris.jpg"));
		//messageHelper.addAttachment("paris.jpg", fi);
		
		// �������� ������
		//fi = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/citys.zip"));
		//messageHelper.addAttachment("citys.zip", fi);
		
		// ���� �����ϱ�
		mailSender.send(message);		
		
		
		
		return "redirect:/message/mailSendOk";
	}
	
	// 파일 업로드 연습
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.GET)
	public String fileUploadGet(Model model, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		model.addAttribute("fileCount", files.length);
		
		return "study/fileUpload/fileUpload";
	}
	
	// 파일 업로드 연습
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName, String mid) {
		int res = studyService.fileUpload(fName, mid);
		
		if(res != 0) return "redirect:/message/fileUploadOk";			
		else return "redirect:/message/fileUploadNo";			
		
	}
	
	// 파일 개별삭제 연습
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDelete", method = RequestMethod.POST)
	public String fileDeletePost(String file, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		
		File fName = new File(realPath + file);
		String res = "0";
		if(fName.exists() == true) {
			fName.delete();
			res = "1";
		}		
		return res;			
	}
	
	
	// 파일 전체삭제 연습
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDeleteAll", method = RequestMethod.POST)
	public String fileDeleteAllPost(String file, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload");
		String res = "0";
		
		File targetFolder = new File(realPath);
		
		if(!targetFolder.exists()) return "0";
		
		File[] files = targetFolder.listFiles();

		if(files.length != 0) {
			for(File f : files) {
				if(!f.isDirectory()) f.delete();
			}
			res = "1";
		}
				
		
		return res;			
	}
	
	
	
	@RequestMapping(value = "/fileUpload/multiFile", method = RequestMethod.GET)
	public String multiFileGet() { return "study/fileUpload/multiFile"; }
	
	// , HttpServletRequest request
	
	
	@RequestMapping(value = "/fileUpload/multiFile", method = RequestMethod.POST)
	public String multiFilePost(MultipartHttpServletRequest mFile) {
		
		int res = studyService.multiFileUpload(mFile);
		
		if(res != 0) return "redirect:/message/multiFileUploadOk";
		else return "redirect:/message/multiFileUploadNo";
	}
	
	
	@RequestMapping(value = "/fileUpload/multiFile2", method = RequestMethod.GET)
	public String multiFile2Get() {
		
		return "study/fileUpload/multiFile2";
	}
	
	@RequestMapping(value = "/fileUpload/multiFile2", method = RequestMethod.POST)
	public String multiFile2Post(MultipartHttpServletRequest mFile, HttpServletRequest request, String imgNames) {
		//String[] imgNames = request.getParameter("imgNames").split("/");
		
		int res = studyService.multiFileUpload(mFile);
		
		
		return "study/fileUpload/multiFile"; 
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
}
