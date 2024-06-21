package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void setSaveCrimeData(CrimeVO vo) {
		studyDAO.setSaveCrimeData(vo);
	}



	
	
}
