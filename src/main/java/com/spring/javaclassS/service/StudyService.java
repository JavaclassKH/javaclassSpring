package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public List<UserVO> getMemberNameList();

	public int getMemberAge(String name);

	public List<UserVO> getMemberInfosName(String name);

	public List<UserVO> getMemberInfosByAge(int age);

	public List<UserVO> getMemberInfosByAddress(String address);

	public UserVO getUserMidSearch(String mid);

	public List<UserVO> getUserMidList(String mid);

	public void setSaveCrimeData(CrimeVO vo);

	public int fileUpload(MultipartFile fName, String mid);

	void setSaveCrimeDate(CrimeVO vo);

	public int multiFileUpload(MultipartHttpServletRequest mFile);

	public int multiFileUpload(MultipartHttpServletRequest mFile, String[] imgNames);

	public Map<String, Integer> analyzer1(String content);

	public KakaoAddressVO getKakaoAddressSearch(String address);

	public void setKakaoAddressInput(KakaoAddressVO vo);

	public ArrayList<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(String address);

	public String setQrCodeCreate(String realPath);

	public String setQrCodeCreate1(String realPath, QrCodeVO vo);

	public String setQrCodeCreate2(String realPath, QrCodeVO vo);

	public String setQrCodeCreate3(String realPath, QrCodeVO vo);

	public String setQrCodeCreate4(String realPath, QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(String qrCode);

	public ArrayList<TransactionVO> getTransactionList();

	public int setTransactionUserInput(TransactionVO vo);

	public ArrayList<TransactionVO> getTransactionList2();

	public void setTransactionUser1Input(TransactionVO vo);

	public void setTransactionUser2Input(TransactionVO vo);

	public void setTransactionUserTotalInput(TransactionVO vo);



}
