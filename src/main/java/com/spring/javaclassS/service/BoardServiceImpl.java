package com.spring.javaclassS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS.dao.BoardDAO;
import com.spring.javaclassS.vo.BoardReply2VO;
import com.spring.javaclassS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize) { return boardDAO.getBoardList(startIndexNo, pageSize); }
	
	@Override
	public int setBoardInput(BoardVO vo) { return boardDAO.setBoardInput(vo); }

	@Override
	public BoardVO getBoardContent(int idx) {	return boardDAO.getBoardContent(idx); }

	@Override
	public void setReadNumPlus(int idx) {	boardDAO.setReadNumPlus(idx); }

	@Override
	public BoardVO getPreNexSearch(int idx, String str) {	return boardDAO.getPreNexSearch(idx, str); }

	
	// content에 이미지가 있다면 ckeditor폴더에서 board폴더로 이미지파일을 복사한다
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3         4         5         6         7
		//								01234567890123456789012345678901234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

		int position = 31;  // 파일명의 시작위치
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true; 
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "board/" + imgFile;
		
			fileCopyCheck(origFilePath, copyFilePath);   // ckeditor폴더의 이미지를 board폴더 위치로 복사하는 메소드 
		
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[4096];
			int cnt = 0;
			
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();			
			
		} catch (FileNotFoundException e) {
			System.out.println("파일 io : " + e.getMessage());
		} catch (IOException e) {
			System.out.println("파일 복사 : " + e.getMessage());
		} 
			
	
	}

	@Override
	public void imgBackUp(String content) {
		
		//  							0         1         2         3         4         5         6         7
		//								01234567890123456789012345678901234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/board/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;  // 파일명의 시작위치
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true; 
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);   // ckeditor폴더의 이미지를 board폴더 위치로 복사하는 메소드 
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}

		
		
	}

	@Override
	public void imgDelete(String content) {
		//  							0         1         2         3         4         5         6         7
		//								01234567890123456789012345678901234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS/data/board/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093559_jsp서블릿 주소 에러.jpg" style="height:273px; width:360px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;  // 파일명의 시작위치
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true; 
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			
			fileCopyDelete(origFilePath);   // board폴더의 이미지를 삭제하는 메소드 
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 글 수정시 서버에 존재하는 이미지파일 삭제
	private void fileCopyDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardUpdate(BoardVO vo) { return boardDAO.setBoardUpdate(vo); }

	@Override
	public int setBoardDelete(int idx) { return boardDAO.setBoardDelete(idx); }

	@Override
	public BoardReply2VO getBoardParentReplyCheck(int boardIdx) { return boardDAO.getBoardParentReplyCheck(boardIdx); }

	@Override
	public int setBoardReplyInput(BoardReply2VO replyVo) { return boardDAO.setBoardReplyInput(replyVo); }

	@Override
	public List<BoardReply2VO> getBoardReplyList(int idx) { return boardDAO.getBoardReplyList(idx);	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) { boardDAO.setReplyOrderUpdate(boardIdx, re_order);	}

	@Override
	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search, String searchString) {	
		return boardDAO.getBoardSearchList(startIndexNo,pageSize,search,searchString);
	}

	
	
	
}

