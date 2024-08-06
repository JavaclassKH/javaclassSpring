package com.spring.javaclassS.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

/*
	- cron 사용 예
	매달 10일 14시에 실행! : cron = "0 0 14 10 * ?"
	
	매달 10일과 20일 14시에 실행 cron = "0 0 14 10,20 * ?"
	
	매달 마지막 날 23시에 실행 cron = "0 0 23 L * ?"

	매달 09:00~09:55, 18:00~18:55분에 5분 간격으로 실행(작업)
	cron = "0 0/5 9,18 * * *"
	
	매달 09:00~18:00에 5분 간격으로 실행(작업)
	cron = "0 0/5 9-18 * * *"
	
	매년 7월달 내 월~금 10시 30분에 실행 (월~일 == 1~7)
	cron = "0 30 10 ? 7 1-5"
	
	매달 마지막 토요일 10시 30분에 실행
	cron = "0 30 10 ? * 6L"
	
*/
@Service
@EnableScheduling
public class JavaclassScheduler {
	
	@Autowired
	JavaMailSender mailSender;
	
	/** 정해진 시간에 자동으로 실행(cron = 초 분 시 일 월 요일) [기본값으로 '*'을 입력해준다] */
	//@Scheduled(cron = "0/5 0 0 * * *") // 5초에 한번씩 자동 실행
	//@Scheduled(cron = "0/10 * * * * *") // 5초에 한번씩 자동 실행
	/*
	 * public void scheduleRun1() { Date today = new Date(); SimpleDateFormat sdf =
	 * new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초"); String strToday =
	 * sdf.format(today); System.out.println("10초에 한번씩 메세지가 출력됩니다 " + strToday); }
	 */
	
	//@Scheduled(cron = "0 0/1 * * * *") // 1분에 한번씩 자동 실행
	/*
	 * public void scheduleRun2() { Date today = new Date(); SimpleDateFormat sdf =
	 * new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초"); String strToday =
	 * sdf.format(today); System.out.println("1분에 한번씩 메세지가 출력됩니다 " + strToday); }
	 */
	
	//@Scheduled(cron = "5 * * * * *") // 1분에 한번씩 자동 실행
	/*
	 * public void scheduleRun3() { Date today = new Date(); SimpleDateFormat sdf =
	 * new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초"); String strToday =
	 * sdf.format(today);
	 * System.out.println("매 분의 5초에 한번씩 메세지가 출력됩니다[ex) 10:05 , 11:05] " + strToday);
	 * }
	 */
	
	/*
	 * @Scheduled(cron = "0 44 10 * * *") // 매일 10시 44분에 자동 실행 public void
	 * scheduleRun4() { Date today = new Date(); SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초"); String strToday =
	 * sdf.format(today); System.out.println("매일 10시 14분에 자동 실행 " + strToday); }
	 */
	
	/*
	@Scheduled(cron = "0 45 10 * * *") // 매일 10시 45분에 메일을 전송 
	public void scheduleRun5() throws MessagingException {
		System.out.println("매일 10시 23분에 메일 자동 발송");		
		
		String email = "forjustgood@gmail.com";
		String title = "광고성 메일 수신 동의";
		String content = "저기 여봐라 바텐더 Cocktail on th rainbow easy an ice tho easy an ice tho";
		content += "to keep ma tempo 지금 내 기분 ice tho";
		
		// HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 작성한 메세지들의 정보를 모두 저장시킨후 작업처리...
		messageHelper.setTo(email);			// 받는 사람 메일 주소
		messageHelper.setSubject(title);	// 메일 제목
		messageHelper.setText(content);		// 메일 내용
		
		// 메세지 보관함의 내용(content)에 , 발신자의 필요한 정보를 추가로 담아서 전송처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3> 내용 : "+content+"</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런후 다시 보관함에 저장한다.
		//FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/Main.png"));
		FileSystemResource file = new FileSystemResource("D:\\javaclass\\SpringFramework\\works\\javaclassS\\src\\main\\webapp\\resources\\images\\Main.png");
		messageHelper.addInline("Main.png", file);
		
		// 메일 전송하기
		mailSender.send(message);
		
	}
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}







