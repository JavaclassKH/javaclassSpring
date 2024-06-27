package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.BoardService;
import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.BoardReply2VO;
import com.spring.javaclassS.vo.BoardVO;
import com.spring.javaclassS.vo.PagVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
		
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		PagVO pageVo = pageProcess.getTotRecCnt(pag, pageSize, "board", "", "");
		
		ArrayList<BoardVO> vos = boardService.getBoardList(pageVo.getStartIndexNo(), pageVo.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet(Model model) {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		// 만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다 ('/data/ckeditor'에서 '/data/board'로)
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
			
		// 2. 이미지 작업을 모두 마치면, ckeditor폴더 경로를 board폴더 경로로 변경처리
		vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/board"));		
	
		
		// 3. content 안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은 후 DB에 저장한다
		int res = boardService.setBoardInput(vo);
		
		if(res != 0)  return "redirect:/message/boardInputOk";
		else  return "redirect:/message/boardInputNo";
	}
	
	
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, Model model, HttpServletRequest request,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 조회수 증가
		//boardService.setReadNumPlus(idx);
		
		// 조회수 어뷰징 방지
		HttpSession session = request.getSession();
		ArrayList<String> ContentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx"); 
		if(ContentReadNum == null) ContentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		
		if(!ContentReadNum.contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(idx);
			ContentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", ContentReadNum);
		
		
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 이전글, 다음글 CheolEEE
		BoardVO preVo = boardService.getPreNexSearch(idx, "preVo");
		BoardVO nextVo = boardService.getPreNexSearch(idx, "nextVo");
		
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		// 댓글 출력하기
		List<BoardReply2VO> replyVos = boardService.getBoardReplyList(idx);
		System.out.println(replyVos);
		model.addAttribute("replyVos", replyVos);

		
		return "board/boardContent";
	}
	
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 수정화면으로 이동할 시 기존 원본 파일에 그림파일이 존재한다면 현재 폴더의 그림파일을 ckeditor폴더로 복사해준다		
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgBackUp(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(Model model, BoardVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize ) {
		// 수정화면으로 이동할 시 기존 원본 파일에 그림파일이 존재한다면 현재 폴더의 그림파일을 ckeditor폴더로 복사해준다		
		
		/* 1. 수정된 자료가 원본자료와 완전히 동일! (수정하지 않고 나갔을 때) */
		BoardVO originalVo = boardService.getBoardContent(vo.getIdx());
		
		// DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용과 비교해본다, 내용변경이 있다면 수정한 것
		if(!originalVo.getContent().equals(vo.getContent())) {
			// 1) 기존 board 폴더에 그림파일이 존재했다면 원본 그림을 모두 삭제한다 (원본그림파일은 수정창에 들어5기 전에 ckeditor폴더에 저장시켜두었드아.)
			if(originalVo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(originalVo.getContent());
			// 2) 앞의 삭제작업이 끝나면 'board'폴더를 'ckeditor'폴더로 경로변경한다
			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
			// 3) 1,2번 작업이 끝나면 파일을 처음 업로드한것과 같은 작업처리를 해 준다. 즉, content에 이미지가 저장되어있다면 저장된 이미지만 골라서
			// '/data/board'폴더에 복사하고 저장한다.  
			boardService.imgCheck(vo.getContent());
			
			// 4) 이미지 복사작업을 마치면 다시 폴더명을 'ckeditor'폴더에서 'board'폴더로 복사처리한다! 
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
			
			// 모든 작업이 끝난 후 vo를 db에 저장시켜준다
			
		}
		int res = boardService.setBoardUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		
		
		if(res != 0) return "redirect:/message/boardUpdateOk";
		else return "redirect:/message/boardUpdateNo";
	}

	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx, 
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 게시글에 사진이 존재한다면, 서버에 저장된 사진을 삭제처리한다. 
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());		
		
		// 사진작업이 끝나면 DB에 저장된 실제 정보 레코드를 삭제처리한다
		int res = boardService.setBoardDelete(idx);
				
		if(res != 0) return "redirect:/message/boardDeleteOk";
		else return "redirect:/message/boardDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 원본글에 댓글 입력처리(부모댓글)
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReply2VO replyVo, Model model) {
		// 부모댓글의경우는 re_step을 '0'으로 re_order는 '1'로 처리, 원본글의 첫번째 부모댓글은 re_order가 '1'이지만 2번이상은 마지막 부모댓글의 re_order보다 +1 처리
		BoardReply2VO replyParentVO = boardService.getBoardParentReplyCheck(replyVo.getBoardIdx());		
		
		if(replyParentVO == null) {
			replyVo.setRe_order(1);
		}
		else {
			replyVo.setRe_order(replyParentVO.getRe_order() + 1);			
		}
		
		replyVo.setRe_step(0);
		
		int res = boardService.setBoardReplyInput(replyVo);
		
		return res+"";
	}
	
	// 대댓글(부모댓글에 대한 댓글) 입력
	@ResponseBody
	@RequestMapping(value = "/boardReplyInputRe", method = RequestMethod.POST)
	public String boardReplyInputRePost(BoardReply2VO replyVo, Model model) {
		// 대댓글은 부모댓글의 [1]re_step보다 +1 처리 한다, [2]re_order보다 큰 댓글은 모두 +1 처리 후, [3]자신의 re_order을 +1처리 한다 
		int res = 0;
		// [1]
		replyVo.setRe_step(replyVo.getRe_step() + 1);
		// [2]
		boardService.setReplyOrderUpdate(replyVo.getBoardIdx(), replyVo.getRe_order());
		// [3]
		replyVo.setRe_order(replyVo.getRe_order() + 1);
		
		res = boardService.setBoardReplyInput(replyVo);
		
		return res+"";
	}
	
	// 검색기
	@RequestMapping(value = "/boardSearch", method = RequestMethod.POST)
	public String boardSearchPost(Model model, String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		PagVO pagVo = pageProcess.getTotRecCnt(pag, pageSize, "board", search, searchString);
		List<BoardVO> vos = boardService.getBoardSearchList(pagVo.getStartIndexNo(), pageSize, search, searchString);
		String searchTitle = "";
		if(pagVo.getSearchString().equals("title")) searchTitle = "글제목";
		else if(pagVo.getSearchString().equals("title")) searchTitle = "글쓴이";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pagVo);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("searchCount", vos.size());
		
		return "board/boardSearchList";
	}
	
	
	
	
	
	
	
	
}
