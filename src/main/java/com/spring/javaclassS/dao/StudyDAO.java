package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyDAO {

	public UserVO getUserMidSearch(@Param("mid")String mid);

	public List<UserVO> getUserMidList(@Param("mid") String mid);

	public void setSaveCrimeData(@Param("vo") CrimeVO vo);
	
	public void setSaveCrimeDate(CrimeVO vo);
	
	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);
	
	public void setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);
	
	public ArrayList<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(@Param("address") String address);

	public void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);

	public ArrayList<TransactionVO> getTransactionList();

	public int setTransactionUserInput(@Param("vo") TransactionVO vo);

	public ArrayList<TransactionVO> getTransactionList2();

	public void setTransactionUser1Input(@Param("vo") TransactionVO vo);

	public void setTransactionUser2Input(@Param("vo") TransactionVO vo);

	public void setTransactionUserTotalInput(@Param("vo") TransactionVO vo);

}
