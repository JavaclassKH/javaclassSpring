package com.spring.javaclassS.controller;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kennycason.kumo.CollisionMode;
import com.kennycason.kumo.WordCloud;
import com.kennycason.kumo.WordFrequency;
import com.kennycason.kumo.bg.CircleBackground;
import com.kennycason.kumo.font.KumoFont;
import com.kennycason.kumo.font.scale.LinearFontScalar;
import com.kennycason.kumo.nlp.FrequencyAnalyzer;
import com.kennycason.kumo.nlp.tokenizer.WhiteSpaceWordTokenizer;
import com.kennycason.kumo.palette.ColorPalette;
import com.spring.javaclassS.common.ARIAUtil;
import com.spring.javaclassS.common.SecurityUtil;
import com.spring.javaclassS.service.DbtestService;
import com.spring.javaclassS.service.StudyService;
import com.spring.javaclassS.vo.CrawlingVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.DbPayMentVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.MailVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
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
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;


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
		if(files.length != 0) model.addAttribute("fileCount", files.length);			
		else model.addAttribute("fileCount", 0);			
		
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
		
		@SuppressWarnings("unused")
		int res = studyService.multiFileUpload(mFile);
		
		
		return "study/fileUpload/multiFile"; 
	}
	
	@RequestMapping(value = "/crawling/jsoup", method = RequestMethod.GET)
	public String crawlingjSoupGet() { return "study/crawling/jsoup"; }
	
	/*
	// 크롤링연습 처리(jsoup)
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String crawlingjSoupPost(String url, String selector) throws IOException { 
		Connection conn = Jsoup.connect(url);
		Document document = conn.get();
		//System.out.println(document);

		Elements selects = document.select(selector);
		//System.out.println(selects);
		//System.out.println(selects.text());
		String str = "";
		int i = 0;
		for(Element select : selects) {
			i++;
			//System.out.println(i + " : " + select);
			System.out.println(i + ". " + select.text());
			str += i + ". " + select + "<br/>";
		}
		return str; 
	}
	*/
	
	// 크롤링연습 객체 처리(jsoup)
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup", method = RequestMethod.POST)
	public List<String> crawlingjSoupPost(String url, String selector) throws IOException { 
		Connection conn = Jsoup.connect(url);
		Document document = conn.get();
		
		Elements selects = document.select(selector);
		List<String> vos = new ArrayList<String>();
		int i = 0;
		for(Element select : selects) {
			i++;
			System.out.println(i + " : " + select);
			vos.add(i+ ". " + select.html().replace("data-onshow-src", "src"));
		}
		return vos; 
	}
	
	// 크롤링연습 객체 처리(jsoup) / 네이버뉴스
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup2", method = RequestMethod.POST)
	public List<CrawlingVO> crawlingjSoup2Post() throws IOException { 
		Connection conn = Jsoup.connect("https://news.naver.com/");
		
		Document document = conn.get();
		
		Elements selects = null;

		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("div.cjs_t");
		for(Element select : selects) {
			System.out.println("제목 : " + select.html() + "\n");
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("div.cjs_news_mw");
		for(Element select : selects) {
			System.out.println("이미지 : " + select.html() + "\n");
			imageVos.add(select.html().replace("data-onshow-",""));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("h4.channel");
		for(Element select : selects) {
			System.out.println("언론사 : " + select.html() + "\n");
			broadcastVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<titleVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			vos.add(vo);
		}
		
		return vos;
	}
	
	// 크롤링연습 객체 처리(jsoup) / 다음뉴스
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup3", method = RequestMethod.POST)
	public List<CrawlingVO> crawlingjSoup3Post() throws IOException { 
		Connection conn = Jsoup.connect("https://entertain.daum.net/");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("a.link_txt");
		for(Element select : selects) {
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("a.link_thumb");
		for(Element select : selects) {
			imageVos.add(select.html());  
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("span.info_thumb");
		for(Element select : selects) {
			broadcastVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		
		for(int i=0; i<broadcastVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			
			vos.add(vo);
		}
		
		return vos;
	}
	
	// 네이버 검색어를 이용한 검색처리
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup4", method = RequestMethod.POST)
	public ArrayList<String> jsoup4Post(String search, String searchSelector) throws IOException {
		Connection conn = Jsoup.connect(search);
		
		Document document = conn.get();
		
		Elements selects = document.select(searchSelector);
		
		ArrayList<String> vos = new ArrayList<String>();
		
		int i = 0;
		for(Element select : selects) {
			i++;
			System.out.println(i + " : " + select.html());
			vos.add(i + ". " + select.html().replace("data-lazysrc", "src"));
		}
		return vos;
	}
	
	@RequestMapping(value = "/crawling/selenium", method = RequestMethod.GET)
	public String seleniumGet() {	return "study/crawling/selenium"; }
	
	// 크롤링연습(selenium) - CGV
	@ResponseBody
	@RequestMapping(value = "/crawling/selenium", method = RequestMethod.POST)
	public List<HashMap<String, Object>> seleniumPost(HttpServletRequest request) {	
		List<HashMap<String, Object>> vos = new ArrayList<HashMap<String,Object>>();
		
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("http://www.cgv.co.kr/movies/");
			
			// 현재상영작만 보기  chk_nowshow link-more
			WebElement btnMore = driver.findElement(By.id("chk_nowshow"));
			btnMore.click();
			
			// 더보기 버튼을 클릭
			btnMore = driver.findElement(By.className("link-more"));
			btnMore.click();
			
			// 더보기를 전부 눌러 화면이 다 눌릴때까지 시간을 지연시켜준다
		  try {	Thread.sleep(3000); } catch (Exception e) {}
			
		  // 개별 vos객체(elements)를 HaspMap에 등록 후 List객체로 처리하여 프론트로 넘겨준다)
		  List<WebElement> elements = driver.findElements(By.cssSelector("div.sect-movie-chart ol li"));
		  for(WebElement element : elements) {
		  	HashMap<String, Object> map = new HashMap<String, Object>();
		  	String image = "<img src='"+ element.findElement(By.tagName("img")).getAttribute("src") +"' width='240px' height='180px' />";
		  	String link = element.findElement(By.tagName("a")).getAttribute("href"); 
		  	String title = "<a href='"+link+"' class='btn btn-danger' target='_blank'><b>" + element.findElement(By.className("title")).getText() + "</b></a>"; 
		  	String percent = element.findElement(By.className("percent")).getText();
		  	
		  	map.put("image", image);
		  	map.put("link", link);
		  	map.put("title", title);
		  	map.put("percent", percent);
		  	vos.add(map);
		  }
		  driver.close(); 
		} catch (Exception e) {
			System.out.println("selenium 크롤링연습오류 : " + e.getMessage());
		}
		//System.out.println("vos => " + vos);
		return vos; 
	}
	
	
	// Super Rapid Train 시간표 조회
	@ResponseBody
	@RequestMapping(value = "/crawling/train", method = RequestMethod.POST)
	public List<HashMap<String, Object>> trainPost(HttpServletRequest request, String stationStart, String stationStop) {	
		List<HashMap<String, Object>> array = new ArrayList<HashMap<String,Object>>();
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
			System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
			
			WebDriver driver = new ChromeDriver();
			driver.get("http://srtplay.com/train/schedule");
			
			WebElement btnMore = driver.findElement(By.xpath("//*[@id=\"station-start\"]/span"));
			btnMore.click();
			try { Thread.sleep(2000);} catch (InterruptedException e) {}

			btnMore = driver.findElement(By.xpath("//*[@id=\"station-pos-input\"]"));
      btnMore.sendKeys(stationStart);
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
      btnMore.click();
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
      btnMore.click();
      try { Thread.sleep(1500);} catch (InterruptedException e) {}
      
      btnMore = driver.findElement(By.xpath("//*[@id=\"station-arrive\"]/span"));
      btnMore.click();
      try { Thread.sleep(1500);} catch (InterruptedException e) {}
      
      btnMore = driver.findElement(By.id("station-pos-input"));
      btnMore.sendKeys(stationStop);
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationListArea\"]/li/label/div/div[2]"));
      btnMore.click();
      btnMore = driver.findElement(By.xpath("//*[@id=\"stationDiv\"]/div/div[3]/div/button"));
      btnMore.click();
      try { Thread.sleep(1500);} catch (InterruptedException e) {}
      
      btnMore = driver.findElement(By.xpath("//*[@id=\"sr-train-schedule-btn\"]/div/button"));
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
      
      List<WebElement> timeElements = driver.findElements(By.cssSelector(".table-body ul.time-list li"));
 			
      HashMap<String, Object> map = null;
      
      for(WebElement element : timeElements) {
				map = new HashMap<String, Object>();
				String train=element.findElement(By.className("train")).getText();
				String start=element.findElement(By.className("start")).getText();
				String arrive=element.findElement(By.className("arrive")).getText();
				String time=element.findElement(By.className("time")).getText();
				String price=element.findElement(By.className("price")).getText();
				map.put("train", train);
				map.put("start", start);
				map.put("arrive", arrive);
				map.put("time", time);
				map.put("price", price);
				array.add(map);
			}      
      
      /*
      // 요금조회하기 버튼을 클릭한다.(처리 안됨 - 스크린샷으로 대체)
      btnMore = driver.findElement(By.xpath("//*[@id=\"scheduleDiv\"]/div[2]/div/ul/li[1]/div/div[5]/button"));
      //System.out.println("요금 조회버튼클릭");
      btnMore.click();
      try { Thread.sleep(2000);} catch (InterruptedException e) {}
			*/
      
      // 지정경로에 브라우저 화면 스크린샷 저장처리
  		realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
      File scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
      FileUtils.copyFile(scrFile, new File(realPath + "screenshot.png"));
      
      driver.close(); 
		} catch (Exception e) {	e.printStackTrace(); }
		
		return array;
	}
	
	
	@RequestMapping(value = "/password/password", method = RequestMethod.GET)
	public String passwordGet() {
		return "study/password/password";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/password/sha256", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String sha256Post(String pwd) {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		String encPwd = security.encryptSHA256(salt + pwd);
		
		pwd = "salt키 : " + salt + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	@ResponseBody
	@RequestMapping(value = "/password/aria", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String ariaPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		String encPwd = "";
		String decPwd = "";
		
		encPwd = ARIAUtil.ariaEncrypt(salt + pwd);
		decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		pwd = "salt키 : " + salt + " / 암호화된 비밀번호 : " + encPwd + " / 복호화된 비밀번호 : " + decPwd.substring(8);
		
		return pwd;
	}
	
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd);
		
		pwd = "암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	@RequestMapping(value = "/wordcloud/wordcloudForm", method = RequestMethod.GET)
	public String wordcloudFormGet() {		
		return "study/wordcloud/wordcloudForm";
	}
	
	// wordcloud연습1
	@ResponseBody
	@RequestMapping(value = "/wordcloud/analyzer1", method = RequestMethod.POST)
	public Map<String, Integer> analyzer1Post(String content) {				
		return studyService.analyzer1(content);
	}
	
	// wordcloud연습2
	@ResponseBody
	@RequestMapping(value = "/wordcloud/analyzer2", method = RequestMethod.POST)
	public Map<String, Integer> analyzer2Post(Model model, HttpServletRequest request) throws IOException {			
		String content = "";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/sample.txt");
		String url = "";
		String selector = "";
		Connection conn = Jsoup.connect(url);
		Document document = conn.get(); 
		
		Elements selects = document.select(selector);
		int i = 0;
		String str = "";
		for(Element select : selects) {
			System.out.println(i + ". " + select.html());
			str += select.html() + "\n";
		}
		
		try(FileWriter fw = new FileWriter(realPath)) {
			fw.write(str);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return studyService.analyzer1(content);
	}
	
	
	// wordcloud연습2
	@ResponseBody
	@RequestMapping(value = "/wordcloud/analyzer3", method = RequestMethod.POST)
	public Map<String, Integer> analyzer3Post(HttpServletRequest request, String url, String selector) throws IOException {			
		Connection conn = Jsoup.connect(url);
		Document document = conn.get(); 
		
		Elements selects = document.select(selector);
		int i = 0;
		String str = "";
		for(Element select : selects) {
			System.out.println(i + ". " + select.html());
			str += select.html() + "\n";
		}
		
		
		
		
		
		
		
		/*
		String content = "";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/sample.txt");
		
		try(BufferedReader br = new BufferedReader(new FileReader(realPath))) {
			String line = "";
			while((line = br.readLine()) != null) {
				System.out.println(line);
				content += line + "  ";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		
		
		return studyService.analyzer1(str);
	}
	
	// wordCloud 생성하여 이미지로 보관하기이 
	@RequestMapping(value = "/wordcloud/wordcloudShow", method = RequestMethod.GET)
	public String wordcloudShowGet(HttpServletRequest request, Model model) throws IOException, FontFormatException {
		String realPath = request.getSession().getServletContext().getRealPath("resources/data/study/wordcloud.png");
		FrequencyAnalyzer analyzer = new FrequencyAnalyzer();
		analyzer.setWordFrequenciesToReturn(300);
		analyzer.setMinWordLength(2);
		analyzer.setWordTokenizer(new WhiteSpaceWordTokenizer());
		
		List<WordFrequency> wfs = analyzer.load(getInputStream(realPath));
		
		Dimension dimension = new Dimension(505, 505);
		WordCloud wordCloud = new WordCloud(dimension, CollisionMode.PIXEL_PERFECT);
		wordCloud.setPadding(1);
		wordCloud.setBackground(new CircleBackground(250));  // wordCloud의 배경모양 
		wordCloud.setColorPalette(new ColorPalette(new Color(0x4055F1),new Color(0x4097C4),new Color(0x4578F1),new Color(0x401E58),new Color(0x4011E1),new Color(0xE11E59),new Color(0x4029F1),new Color(0x2143B7)));
		wordCloud.setFontScalar(new LinearFontScalar(12, 58));
		
		// 한글폰트설정
		Font font = Font.createFont(Font.TRUETYPE_FONT, this.getClass().getClassLoader().getResourceAsStream("fonts/NanumGothic-Bold.ttf"));
		wordCloud.setKumoFont(new KumoFont(font));
		
		wordCloud.build(wfs);
		wordCloud.writeToFile(realPath);
				
		model.addAttribute("imagePath", "resources/data/study/wordcloud.png");
		return "study/wordcloud/wordcloudShow";
	}
	
	private InputStream getInputStream(String path) throws IOException { return new FileInputStream(new File(path)); }
	
	// randomNumeric : 숫자를 랜덤하게 발생시켜 처리
	@RequestMapping(value = "/random/randomForm", method = RequestMethod.GET)
	public String randomNumericGet() {
		return "study/random/randomForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/random/randomNumeric", method = RequestMethod.POST)
	public String randomNumericPost() {
		// 공식!    (int)(Math.random() * 최대수 - 시작수 + 1) + 시작수;
		// 공식!    (int)(Math.random() * 최대값 - 최소값 + 1) + 최소값;
		int su1 = (int)((Math.random() * 99999999) - 100000000 + 1) + 10000000;
		
		return su1+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/random/randomUUID", method = RequestMethod.POST)
	public String randomUUIDPost() {
		return (UUID.randomUUID()) + "";
	}
	
	// 숫자와 문자를 대/소문자 섞어서 랜덤발생 (일반 영문,숫자 xx자리)
	@ResponseBody
	@RequestMapping(value = "/random/randomAlphaNumeric", method = RequestMethod.POST)
	public String randomAlphaNumericPost() {
		// String res = RandomStringUtils.randomAlphanumeric(64);
		return RandomStringUtils.randomAlphanumeric(64);
	}
	
	@RequestMapping(value = "/kakao/kakaomap", method = RequestMethod.GET)
	public String kakaomapGet() {
		return "study/kakao/kakaomap";
	}
	
	@RequestMapping(value = "/kakao/kakaoEx1", method = RequestMethod.GET)
	public String kakaoEx1Get() {	
		return "study/kakao/kakaoEx1"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/kakao/kakaoEx1", method = RequestMethod.POST)
	public String kakaoEx1Post(KakaoAddressVO vo) {	
		KakaoAddressVO searchVo = studyService.getKakaoAddressSearch(vo.getAddress());
		if(searchVo != null) return "0";
		
		studyService.setKakaoAddressInput(vo);
		
		return "1"; 
	}
	
	@RequestMapping(value = "/kakao/kakaoEx2", method = RequestMethod.GET)
	public String kakaoEx2Get(Model model,
			@RequestParam(value = "address", defaultValue = "", required = false) String address
			) {	
		
		KakaoAddressVO vo = new KakaoAddressVO();
		ArrayList<KakaoAddressVO> vos = studyService.getKakaoAddressList();
		
		if(address.equals("")) {
			vo.setAddress("그린컴퓨터아트학원 청주캠퍼스");
			vo.setLatitude(36.63510859972897);
			vo.setLongitude(127.45950443649697);
		}
		else {			
			vo = studyService.getKakaoAddressSearch(address);
		}
		
		model.addAttribute("addressVos", vos);
		model.addAttribute("vo", vo);
		return "study/kakao/kakaoEx2"; 
	}
	
	// 내 데이터베이스에 저장된 검색위치 삭제하기
	@ResponseBody
	@RequestMapping(value = "/kakao/kakaoAddressDelete", method = RequestMethod.POST)
	public String kakaoAddressDeletePost(String address) {	
		return studyService.setKakaoAddressDelete(address) + ""; 
	}
	
	
	
	//KakaoDB에 저장된 키워드 검색 후 내 데이터베이스에 저장하기 ♥
	@RequestMapping(value = "/kakao/kakaoEx3", method = RequestMethod.GET)
	public String kakaoEx3Get(Model model,
		@RequestParam(value = "address", defaultValue = "", required = false) String address) {	
		
		model.addAttribute("address", address);
			
		
		
		
		
		return "study/kakao/kakaoEx3"; 
	}
	
	
	
	
	@RequestMapping(value = "/weather/weatherForm", method = RequestMethod.GET)
	public String weatherFormGet(Model model) {
		List<KakaoAddressVO> jiyukVos = studyService.getKakaoAddressList();
		model.addAttribute("jiyukVos", jiyukVos);
		return "study/weather/weatherForm";	
	}
	
	// 캡챠 연습 폼
	@RequestMapping(value = "/captcha/captchaForm", method = RequestMethod.GET)
	public String captchaFormGet() {
		return "redirect:/study/captcha/captchaImage";	
	}

	// 캡챠 연습 처리
	@RequestMapping(value = "/captcha/captchaImage", method = RequestMethod.GET)
	public String captchaImageGet(HttpServletRequest request ,Model model) {
		// 시스템에 있는 폰트 출력해보기
		@SuppressWarnings("unused")
		Font[] fontList = GraphicsEnvironment.getLocalGraphicsEnvironment().getAllFonts();
		
//		System.out.println();
//		for(Font f : fontList) {
//			System.out.println("f : " + f.getName());
//		}
		
		try {
			// 알파뉴메릭문자 n개를 가져온다
			String randomString = RandomStringUtils.randomAlphanumeric(5);
			System.out.println("\\ " +randomString + " /");
			HttpSession session = request.getSession();
			session.setAttribute("sCaptcha", randomString);
			
			Font font = new Font("Jokerman", Font.ITALIC, 33);
		  FontRenderContext frc = new FontRenderContext(null, true, true);
			Rectangle2D bounds = font.getStringBounds(randomString, frc);
			int w = (int)bounds.getWidth(); 
			int h = (int)bounds.getHeight(); 
			
			// 이미지 생성하기 
			BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = image.createGraphics();
			
			g.fillRect(0, 0, w, h);
			g.setColor(new Color(3, 166, 243));
			g.setFont(font);
			// 각종 렌더링 명령어에 의한 Captcha 문자 작업
			g.drawString(randomString, (float)bounds.getX(), (float)-bounds.getY());
			g.dispose();
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
			int temp = (int)(Math.random() * 5) + 1;
			String captchaImage = "captcha" + temp + ".png";
			ImageIO.write(image, "png", new File(realPath + captchaImage));
			
			model.addAttribute("captchaImage", captchaImage);
			
		} catch (Exception e) {	e.printStackTrace(); }
		
		return "study/captcha/captchaForm";	
	}
	
	
	// 캡챠 문자 확인하기
	@ResponseBody
	@RequestMapping(value = "/captcha/captcha", method = RequestMethod.POST)
	public String captchaPost(HttpSession session, String strCaptcha) {
		
		if(strCaptcha.equals((String)session.getAttribute("sCaptcha"))) return "1";	
		else return "0";
	}
	
	// QR코드 생성하기
	@RequestMapping(value = "/qrCode/qrCodeForm", method = RequestMethod.GET)
	public String qrCodeFormGet() {
		return "study/qrCode/qrCodeForm";
	}
	
	
	// QR코드 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeCreate", method = RequestMethod.POST)
	public String qrCodeCreatePost(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		return studyService.setQrCodeCreate(realPath);
	}
	
	
	// 개인정보 QR코드로 생성하기
	@RequestMapping(value = "/qrCode/qrCodeEx1", method = RequestMethod.GET)
	public String qrCodeEx1Get() {
		return "study/qrCode/qrCodeEx1";
	}
		
	
	// QR코드 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeCreate1", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String qrCodeCreate1Post(HttpServletRequest request, QrCodeVO vo) {
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		return studyService.setQrCodeCreate1(realPath, vo);
	}
	
	// QR코드로 소개할 사이트 주소 생성하기 
	@RequestMapping(value = "/qrCode/qrCodeEx2", method = RequestMethod.GET)
	public String qrCodeEx2Get() {
		return "study/qrCode/qrCodeEx2";
	}
	
	// QR코드 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeCreate2", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String qrCodeCreate2Post(HttpServletRequest request, QrCodeVO vo) {
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		return studyService.setQrCodeCreate2(realPath, vo);
	}
	
	
	
	// QR코드로 티켓예매
	@RequestMapping(value = "/qrCode/qrCodeEx3", method = RequestMethod.GET)
	public String qrCodeEx3Get() {
		return "study/qrCode/qrCodeEx3";
	}
	
	// QR코드 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeCreate3", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String qrCodeCreate3Post(HttpServletRequest request, QrCodeVO vo) {
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		return studyService.setQrCodeCreate3(realPath, vo);
	}
	
	// QR코드 영화예매정보 DB저장 
	@RequestMapping(value = "/qrCode/qrCodeEx4", method = RequestMethod.GET)
	public String qrCodeEx4Get() {
		return "study/qrCode/qrCodeEx4";
	}
	
	// QR코드 생성하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeCreate4", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String qrCodeCreate4Post(HttpServletRequest request, QrCodeVO vo) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		return studyService.setQrCodeCreate4(realPath, vo);
	}
	
	
	// QR코드명으로 검색하기
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeSearch", method = RequestMethod.POST)
	public QrCodeVO qrCodeSearchPost(String qrCode) {	
		
		return studyService.getQrCodeSearch(qrCode); 
	}
	
	@RequestMapping(value = "/thumbnail/thumbnailForm", method = RequestMethod.GET)
	public String thumbnailFormGet() {
		
		return "study/thumbnail/thumbnailForm";	
	}
	
	@RequestMapping(value = "/chart/chartForm", method = RequestMethod.GET)
	public String chartFormGet(Model model,
		@RequestParam(name="part", defaultValue = "barVChart", required = false) String part){
		
		if(part.equals("CheekyIcyThang")) part = "gant";
		model.addAttribute("part", part);		
		return "study/chart/chartForm";	
	}
	
	@RequestMapping(value = "/chart2/chart2Form", method = RequestMethod.GET)
	public String chart2FormGet(Model model,
		@RequestParam(name="part", defaultValue = "barVChart", required = false) String part){
		
		model.addAttribute("part", part);		
		return "study/chart2/chart2Form";	
	}

	// BackEnd 체크를 위한 Validator연습 폼 
	@RequestMapping(value = "/validator/validatorForm", method = RequestMethod.GET)
	public String validatorFormGet(Model model) {
		ArrayList<TransactionVO> vos = studyService.getTransactionList();
		
		model.addAttribute("vos", vos);
		return "study/validator/validatorForm";	
	}
	
	// BackEnd 체크를 위한 Validator연습 폼 
	@RequestMapping(value = "/validator/validatorForm", method = RequestMethod.POST)
	public String validatorFormPost(Model model, TransactionVO vo) {
		int res = studyService.setTransactionUserInput(vo);
		
		if(res != 0) return "redirect:/message/transactionUserInputOk?tempFlag=validator";	
		else return "redirect:/message/transactionUserInputNo";	
	}
	
	@RequestMapping(value = "/transaction/transactionForm", method = RequestMethod.GET)
	public String transactionFormGet(Model model) {
		ArrayList<TransactionVO> vos = studyService.getTransactionList();
		ArrayList<TransactionVO> vos2 = studyService.getTransactionList2();
		
		model.addAttribute("vos", vos);
		model.addAttribute("vos2", vos2);
		return "study/transaction/transactionForm";	
	}
	
	@Transactional
	@RequestMapping(value = "/transaction/transactionForm", method = RequestMethod.POST)
	public String transactionFormPost(TransactionVO vo) {
		
		studyService.setTransactionUser1Input(vo);
		studyService.setTransactionUser2Input(vo);
		
		return "redirect:/message/transactionForm?transactionUserInputOk?tempFlag=transaction";	
	}
	
	@ResponseBody
	@RequestMapping(value = "/transaction/transaction2", method = RequestMethod.POST)
	public String transaction2Post(TransactionVO vo) {
		
		studyService.setTransactionUserTotalInput(vo);
		
		return "1";	
	}
	
	// 결제처리 연습하기 폼..
  @RequestMapping(value = "/payment/payment", method = RequestMethod.GET)
  public String paymentGet() {
  	return "study/payment/payment";
  }
  
  // 결제처리 연습하기 폼..처리
  @RequestMapping(value = "/payment/payment", method = RequestMethod.POST)
  public String paymentPost(Model model, HttpSession session, DbPayMentVO vo) {
  	session.setAttribute("sPayMentVO", vo);
  	model.addAttribute("vo", vo);
  	return "study/payment/sample";
  }
  
  // 결제처리완료후 확인하는 폼...
  @RequestMapping(value = "/payment/paymentOk", method = RequestMethod.GET)
  public String paymentOkGet(Model model, HttpSession session) {
  	DbPayMentVO vo = (DbPayMentVO) session.getAttribute("sPayMentVO");
  	model.addAttribute("vo", vo);
  	
  	session.removeAttribute("sPayMentVO");
  	
  	return "study/payment/paymentOk";
  }
	
	
	
	
	
	
	
	
	
	
	
}
