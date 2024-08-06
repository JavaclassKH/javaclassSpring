package com.spring.javaclassS.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.dao.DbtestDAO;
import com.spring.javaclassS.dao.StudyDAO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	DbtestDAO dbtestDAO;
	
	@Autowired
	StudyDAO studyDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	

	@Override
	public void setSaveCrimeData(CrimeVO vo) {}

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[10];
		
		if(dodo.equals("����")) {
			strArray[0] = "�߱�";
			strArray[1] = "������";
			strArray[2] = "���ϱ�";
			strArray[3] = "������";
			strArray[4] = "������";
			strArray[5] = "���ʱ�";
			strArray[6] = "�����";
			strArray[7] = "���Ǳ�";
			strArray[8] = "���α�";
			strArray[9] = "��������";
		}	
		else if(dodo.equals("���")) {
			strArray[0] = "������";
			strArray[1] = "�����";
			strArray[2] = "�Ⱦ��";
			strArray[3] = "��õ��";
			strArray[4] = "�ȼ���";
			strArray[5] = "�����";
			strArray[6] = "���ý�";
			strArray[7] = "���ν�";
			strArray[8] = "������";
			strArray[9] = "�����";
		}
		else if(dodo.equals("���")) {
			strArray[0] = "û�ֽ�";
			strArray[1] = "����";
			strArray[2] = "��õ��";
			strArray[3] = "������";
			strArray[4] = "���ֽ�";
			strArray[5] = "��õ��";
			strArray[6] = "�ܾ籺";
			strArray[7] = "���걺";
			strArray[8] = "��õ��";
			strArray[9] = "����";
		}
		else if(dodo.equals("�泲")) {
			strArray[0] = "õ�Ƚ�";
			strArray[1] = "�ƻ��";
			strArray[2] = "����";
			strArray[3] = "������";
			strArray[4] = "�����";
			strArray[5] = "ȫ����";
			strArray[6] = "û�籺";
			strArray[7] = "����";
			strArray[8] = "���걺";
			strArray[9] = "���ɽ�";
		}
		
	
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>(); 
		
		if(dodo.equals("����")) {
			vos.add("�߱�");
			vos.add("������");
			vos.add("���ϱ�");
			vos.add("������");
			vos.add("������");
			vos.add("���ʱ�");
			vos.add("�����");
			vos.add("���Ǳ�");
			vos.add("���α�");
			vos.add("������");
		}	
		else if(dodo.equals("���")) {
			
			vos.add("������");
			vos.add("�����");
			vos.add("�Ⱦ��");
			vos.add("��õ��");
			vos.add("�ȼ���");
			vos.add("�����");
			vos.add("���ý�");
			vos.add("���ν�");
			vos.add("������");
			vos.add("�����");
		}
		else if(dodo.equals("���")) {
			vos.add("û�ֽ�");
			vos.add("����");
			vos.add("��õ��");
			vos.add("������");
			vos.add("���ֽ�");
			vos.add("��õ��");
			vos.add("�ܾ籺");
			vos.add("���걺");
			vos.add("��õ��");
			vos.add("����");
		}
		else if(dodo.equals("�泲")) {
			vos.add("õ�Ƚ�");
			vos.add("�ƻ��");
			vos.add("����");
			vos.add("������");
			vos.add("�����");
			vos.add("ȫ����");
			vos.add("û�籺");
			vos.add("����");
			vos.add("���걺");
			vos.add("���ɽ�");
		}
		
		return vos;
	}
	
	@Override
	public void setSaveCrimeDate(CrimeVO vo) {
		studyDAO.setSaveCrimeDate(vo);
	}

	@Override
	public List<UserVO> getMemberNameList() {
		
		return dbtestDAO.getMemberNameList();
	}

	@Override
	public int getMemberAge(String name) {
		return dbtestDAO.getMemberAge(name);
	}

	@Override
	public List<UserVO> getMemberInfosName(String name) {
		return dbtestDAO.getMemberInfosName(name);
	}

	@Override
	public List<UserVO> getMemberInfosByAge(int age) {
		return dbtestDAO.getMemberInfosByAge(age);
	}

	@Override
	public List<UserVO> getMemberInfosByAddress(String address) {
		return dbtestDAO.getMemberInfosByAddress(address);
	}

	@Override
	public UserVO getUserMidSearch(String mid) {
		return studyDAO.getUserMidSearch(mid);
	}

	@Override
	public List<UserVO> getUserMidList(String mid) {
		return studyDAO.getUserMidList(mid);
	}
	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		
		// 파일이름 중복처리를 위해 UUID객체 활용
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0, 8) + "_" + oFileName;
		
		// 서버에 파일 올리기
		try {
			writeFile(fName, sFileName);
			res = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		//fos.write(fName.getBytes());
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public int multiFileUpload(MultipartHttpServletRequest mFile) {
		int res = 0;
		try {		
			List<MultipartFile> fileList = mFile.getFiles("fName");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				//System.out.println("원본파일 : " + file.getOriginalFilename());
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				
				javaclassProvide.writeFile(file, sFileName, "fileUpload");
			
				oFileNames += oFileName + " / ";
				sFileNames += sFileName + " / ";
				fileSizes += file.getSize();
				
			}
			oFileNames = oFileNames.substring(0, oFileNames.length() - 2);
			sFileNames = sFileNames.substring(0, sFileNames.length() - 2);
			
			System.out.println("원 본 파 일 : " + oFileNames);
			System.out.println("저 장 파 일 : " + sFileNames);
			System.out.println("총 사 이 즈 : " + fileSizes);
			
			
			res = 1;				
		} catch (IOException error) {
			System.out.println("멀티파일전송중오류" + error.getMessage());
		}
		
		return res;
	}

	@Override
	public int multiFileUpload(MultipartHttpServletRequest mFile, String[] imgNames) {
		int res = 0;
		
	
		
		
		return res;
	}

	@Override
	public Map<String, Integer> analyzer1(String content) {
    int wordFrequenciesToReturn = 10;
    int minWordLength = 2;
    
    Map<String, Integer> frequencyMap = new HashMap<String, Integer>();
    
    String[] words = content.split("\\s+");
    
    for(String word : words) {
    	if(word.length() >= minWordLength) {
    		word = word.toLowerCase();
    		frequencyMap.put(word, (frequencyMap.getOrDefault(word, 0) + 1));
    		
    	}
    }
    
    return frequencyMap.entrySet().stream()
        .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
        .limit(wordFrequenciesToReturn)
        .collect(HashMap::new, (m, e) -> m.put(e.getKey(), e.getValue()), HashMap::putAll);
	}

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return studyDAO.getKakaoAddressSearch(address);
	}

	@Override
	public void setKakaoAddressInput(KakaoAddressVO vo) {
		studyDAO.setKakaoAddressInput(vo);
	}

	@Override
	public ArrayList<KakaoAddressVO> getKakaoAddressList() {
		return studyDAO.getKakaoAddressList();
	}

	@Override
	public int setKakaoAddressDelete(String address) {
		return studyDAO.setKakaoAddressDelete(address);
	}

	@Override
	public String setQrCodeCreate(String realPath) {
		String qrCodeName = javaclassProvide.newNameCreate(2);
		String qrCodeImage = "";
		try {
			// QR Code 안의 한글 인코딩
			qrCodeImage = "생성된 QRCode명 : " + qrCodeName + "___" + "https://www.naver.com";
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1"); 
			
			// QR Code 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 120, 120);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			int qrCodeColor = 0xFF0F0F0F;  // 글자색
			int qrCodeBackColor = 0xFFF0F0F0;  // 배경색
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 렌더링 된 QR코드 이미지를 실제 그림파일로 만들어 낸다
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));			
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public String setQrCodeCreate1(String realPath, QrCodeVO vo) {
		String qrCodeName = javaclassProvide.newNameCreate(2);
		String qrCodeImage = "";
		try {
			// QR Code 안의 한글 인코딩
			qrCodeName += vo.getMid() + "_" + vo.getName() + "_" + vo.getEmail();
			qrCodeImage = "생성날짜 : " + qrCodeName.substring(0,4) + "년 " + qrCodeName.substring(4,6) + "월 " + qrCodeName.substring(6,8) + "일\n ";
		  qrCodeImage += "아이디 : " + vo.getMid() + "\n";
		  qrCodeImage += "이름 : " + vo.getName() + "\n";
		  qrCodeImage += "이메일 : " + vo.getEmail() + "\n";
		  qrCodeImage += "Everyday I shuffln~";
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1"); 
			
			// QR Code 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 120, 120);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			int qrCodeColor = 0xFF0F0F0F;  // 글자색
			int qrCodeBackColor = 0xFFF0F0F0;  // 배경색
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 렌더링 된 QR코드 이미지를 실제 그림파일로 만들어 낸다
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));			
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}
	
	
	@Override
	public String setQrCodeCreate2(String realPath, QrCodeVO vo) {
		String qrCodeName = javaclassProvide.newNameCreate(2);
		String qrCodeImage = "";
		try {
			// QR Code 안의 한글 인코딩
			qrCodeName += vo.getMoveUrl();
			qrCodeImage = vo.getMoveUrl();
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1"); 
			
			// QR Code 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 120, 120);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			int qrCodeColor = 0xFF0F0F0F;  // 글자색
			int qrCodeBackColor = 0xFFF0F0F0;  // 배경색
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 렌더링 된 QR코드 이미지를 실제 그림파일로 만들어 낸다
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));			
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	
	@Override
	public String setQrCodeCreate3(String realPath, QrCodeVO vo) {
		String qrCodeName = javaclassProvide.newNameCreate(2);
		String qrCodeImage = "";
		try {
			// QR Code 안의 한글 인코딩
			qrCodeName += vo.getMid() + "_";
			qrCodeName += vo.getMovieName() + "_";
			qrCodeName += vo.getMovieDate() + "_";
			qrCodeName += vo.getMovieTime() + "_";
			qrCodeName += vo.getMovieAdult() + "_";
			qrCodeName += vo.getMovieChild();
			qrCodeImage = "구매자 ID : " +  vo.getMid() + "\n";
			qrCodeImage += "영화 제목 : " +  vo.getMovieName() + "\n";
			qrCodeImage += "상영 일자 : " +  vo.getMovieDate() + "\n";
			qrCodeImage += "상영 시간 : " +  vo.getMovieTime() + "\n";
			qrCodeImage += "성인관람객 수 : " +  vo.getMovieAdult() + "\n";
			qrCodeImage += "아동관람객 수 : " +  vo.getMovieChild();
			
			
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1"); 
			
			// QR Code 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 120, 120);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			int qrCodeColor = 0xFF0F0F0F;  // 글자색
			int qrCodeBackColor = 0xFFF0F0F0;  // 배경색
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 렌더링 된 QR코드 이미지를 실제 그림파일로 만들어 낸다
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));			
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public String setQrCodeCreate4(String realPath, QrCodeVO vo) {
		String qrCodeName = javaclassProvide.newNameCreate(4);
		String qrCodeImage = "";
		try {
			String strToday = qrCodeName.substring(0, qrCodeName.length() - 3);
			
			// QR Code 안의 한글 인코딩
			qrCodeName += vo.getMid() + "_";
			qrCodeName += vo.getMovieName() + "_";
			qrCodeName += vo.getMovieDate() + "_";
			qrCodeName += vo.getMovieTime() + "_";
			qrCodeName += vo.getMovieAdult() + "_";
			qrCodeName += vo.getMovieChild();
			qrCodeImage = "구매자 ID : " +  vo.getMid() + "\n";
			qrCodeImage += "영화 제목 : " +  vo.getMovieName() + "\n";
			qrCodeImage += "상영 일자 : " +  vo.getMovieDate() + "\n";
			qrCodeImage += "상영 시간 : " +  vo.getMovieTime() + "\n";
			qrCodeImage += "성인관람객 수 : " +  vo.getMovieAdult() + "\n";
			qrCodeImage += "아동관람객 수 : " +  vo.getMovieChild() + "\n";
			qrCodeImage += "티켓 발행일 : " +  vo.getMovieAdult() + "\n";
			qrCodeImage += "QR 티켓명 : " +  vo.getMovieAdult() + "\n";
			
			
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1"); 
			
			// QR Code 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 240, 240);
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			int qrCodeColor = 0xFF0F0F0F;  // 글자색
			int qrCodeBackColor = 0xFFF0F0F0;  // 배경색
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// 렌더링 된 QR코드 이미지를 실제 그림파일로 만들어 낸다
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));			
			
			// QRCode 생성 후, 생성된 정보를 DB에 저장한다
			vo.setPublishDate(strToday);
			vo.setQrCodeName(qrCodeName);
			studyDAO.setQrCodeCreate(vo);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public QrCodeVO getQrCodeSearch(String qrCode) {
		return studyDAO.getQrCodeSearch(qrCode);
	}

	@Override
	public ArrayList<TransactionVO> getTransactionList() {
		return studyDAO.getTransactionList();
	}

	@Override
	public int setTransactionUserInput(TransactionVO vo) { return studyDAO.setTransactionUserInput(vo); }

	@Override
	public ArrayList<TransactionVO> getTransactionList2() {
		return studyDAO.getTransactionList2();
	}

	@Override
	public void setTransactionUser1Input(TransactionVO vo) {
		studyDAO.setTransactionUser1Input(vo);
	}

	@Override
	public void setTransactionUser2Input(TransactionVO vo) {
		studyDAO.setTransactionUser2Input(vo);
	}

	@Transactional
	@Override
	public void setTransactionUserTotalInput(TransactionVO vo) {
		studyDAO.setTransactionUserTotalInput(vo);
	}
	
	
	




	
	
}
