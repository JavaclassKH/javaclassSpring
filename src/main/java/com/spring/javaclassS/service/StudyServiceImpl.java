package com.spring.javaclassS.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.dao.DbtestDAO;
import com.spring.javaclassS.dao.StudyDAO;
import com.spring.javaclassS.vo.CrimeVO;
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

	




	
	
}
