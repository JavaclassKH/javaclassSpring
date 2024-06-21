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
		
		if(dodo.equals("서울")) {
			strArray[0] = "중구";
			strArray[1] = "강남구";
			strArray[2] = "강북구";
			strArray[3] = "강서구";
			strArray[4] = "강동구";
			strArray[5] = "서초구";
			strArray[6] = "노원구";
			strArray[7] = "관악구";
			strArray[8] = "종로구";
			strArray[9] = "영등포구";
		}	
		else if(dodo.equals("경기")) {
			strArray[0] = "수원시";
			strArray[1] = "오산시";
			strArray[2] = "안양시";
			strArray[3] = "과천시";
			strArray[4] = "안성시";
			strArray[5] = "시흥시";
			strArray[6] = "평택시";
			strArray[7] = "용인시";
			strArray[8] = "성남시";
			strArray[9] = "광명시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] = "증평군";
			strArray[2] = "진천군";
			strArray[3] = "오송읍";
			strArray[4] = "충주시";
			strArray[5] = "제천시";
			strArray[6] = "단양군";
			strArray[7] = "괴산군";
			strArray[8] = "옥천군";
			strArray[9] = "영동";
		}
		else if(dodo.equals("충남")) {
			strArray[0] = "천안시";
			strArray[1] = "아산시";
			strArray[2] = "논산시";
			strArray[3] = "당진시";
			strArray[4] = "서산시";
			strArray[5] = "홍성군";
			strArray[6] = "청양군";
			strArray[7] = "계룡시";
			strArray[8] = "예산군";
			strArray[9] = "보령시";
		}
		
	
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>(); 
		
		if(dodo.equals("서울")) {
			vos.add("중구");
			vos.add("강남구");
			vos.add("강북구");
			vos.add("강서구");
			vos.add("강동구");
			vos.add("서초구");
			vos.add("노원구");
			vos.add("관악구");
			vos.add("종로구");
			vos.add("영등포");
		}	
		else if(dodo.equals("경기")) {
			
			vos.add("수원시");
			vos.add("오산시");
			vos.add("안양시");
			vos.add("과천시");
			vos.add("안성시");
			vos.add("시흥시");
			vos.add("평택시");
			vos.add("용인시");
			vos.add("성남시");
			vos.add("광명시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("증평군");
			vos.add("진천군");
			vos.add("오송읍");
			vos.add("충주시");
			vos.add("제천시");
			vos.add("단양군");
			vos.add("괴산군");
			vos.add("옥천군");
			vos.add("영동");
		}
		else if(dodo.equals("충남")) {
			vos.add("천안시");
			vos.add("아산시");
			vos.add("논산시");
			vos.add("당진시");
			vos.add("서산시");
			vos.add("홍성군");
			vos.add("청양군");
			vos.add("계룡시");
			vos.add("예산군");
			vos.add("보령시");
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
