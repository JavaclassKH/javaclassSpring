package com.spring.javaclassS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyDAO {

	UserVO getUserMidSearch(@Param("mid")String mid);

	List<UserVO> getUserMidList(@Param("mid") String mid);

	void setSaveCrimeData(@Param("vo") CrimeVO vo);

	void setSaveCrimeDate(CrimeVO vo);

}
