<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%	pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>pdsContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
 		// 리뷰 보이기,감추기 처리 - 처음 접속시엔 리뷰 보이기 버튼을 감춤
 		$(function(){
			$("#reviewShowBtn").hide();
			$("#reviewHideBtn").show();
			$("#reviewBox").show();
		});
 		
 		// 리뷰 보이기, 리뷰 가리기 
 		function reviewShow() {
			$("#reviewShowBtn").hide();
			$("#reviewHideBtn").show();
			$("#reviewBox").show();
		}
 		
 		function reviewHide() {
			$("#reviewShowBtn").show();
			$("#reviewHideBtn").hide();
			$("#reviewBox").hide();
		}
 		
 		// 리뷰에 답글달기 폼 열기
 		function reviewReply(idx, nickName, content) { 			
			$("#reviewModal #reviewIdx").val(idx);
			$("#reviewModal #reviewReplyNickName").text(nickName);
			$("#reviewModal #reviewReplyContent").html(content);
		}

 		
 		// 리뷰에 답글달기
 		function reviewReplyCheck() {
	 		let replyContent = reviewReplyForm.replyContent.value;
	 		console.log("리뷰답글" + replyContent);
	 		let replyIdx = reviewReplyForm.replyIdx.value;
	 		
	 		if(replyContent.trim() == "") {
	 			alert("리뷰 답글을 입력하세요");
	 			return;
	 		}
	 		
	 		let query = {
	 			reviewIdx : replyIdx,
	 			replyMid : '${sMid}',
	 			replyNickName : '${sNickName}',
	 			replyContent : replyContent
	 		}
	 		
	 		$.ajax({
	 			url : "ReviewReplyInputOk.ad",
	 			type : "post",
	 			data : query,
	 			success : function(res) {
					if(res != "0")  {
						alert("답글 등록이 완료되었습니다");
						location.reload();
					}
					else alert("답글 등록에 실패하였습니다");
				},
				error : function() {
					alert("답글등록 전송오류");
				} 
	 		});
			
		}
		
 		
 		// 다운로드 수 증가
 		function downNumCheck(idx) {
			$.ajax({
				url : "${ctp}/pds/pdsDownNumCheck",
				type : "post",
				data : {idx , idx},
				success : function(res) {
					location.reload();
				},
				error : function() {
					alert("다운로드 수 증가 오류");
				}
			});
		}
 		
 		// top으로 가는 화살표 클릭 시 화면 상단으로 부드럽게 올라가기
 		$(window).scroll(function(){
			if($(this).scrollTop() > 100) {
				$("#topButton").show();
			}
			else {
				$("#topButton").hide();				
			}
				$("#topButton").click(function() {
					window.scrollTo({
						top:0, behavior: "smooth"
					});
				});				
		});
 		
 		// 별점,리뷰후기 작성하기 
 		function reviewCheck() {
 			let star = starForm.star.value; 
 			let review = document.getElementById("review").value;
 			
 			if(star == "") {
 				alert("별점은 반드시 부여해야 합니다");
 				return;
 			}
 			
 			let vs = {
 				part : "pds",
 				partIdx : ${vo.idx},
 				mid : '${sMid}',
 				nickName : '${sNickName}',
 				star : star,
 				content : review
 			}
 			
 			
			$.ajax({
				url : "${ctp}/review/reviewInputOk",
				type : "post",
				data : vs,
				success : function(res) {
					alert(res);
					location.reload();
				},
				error : function() {
					alert("전송 오류");
				}
			});
		
 		}
 			
 		// 리뷰 삭제하기
 		function reviewDelete(idx) {
			let ans = confirm("리뷰를 삭제하시겠습니까?");
			if(!ans) return;
			
			$.ajax({
				url : "${ctp}/review/reviewDelete",
				type : "post",
				data : {idx : idx},
				success : function(res) {
					if(res != "0") {
						alert("리뷰 삭제가 완료되었습니다");
						location.reload();
					}
					else {
						alert("리뷰 삭제에 실패하였습니다");						
					}
				},
				error : function() {
					alert("리뷰 삭제 전송 오류");
				}			
			});
		}
 		
 			
 		
	</script>
	<style>
	
	th {
		background-color: #eee;
		width: 15%
	}
	
	#starForm fieldset {
		direction: rtl;
	} 
	
	#starForm input[type=radio] {
		display: none;
	}
	
	#starForm label {
		font-size: 1.4em;
		color: transparent;
		text-shadow: 0 0 0 #f0f0f0;
	}
	
	#starForm label:hover {
		text-shadow: 0 0 0 rgba(247, 202, 1, 95);
	}
	
	#starForm label:hover ~ label {
		text-shadow: 0 0 0 rgba(247, 202, 1, 95);
	}
	
	#starForm input[type=radio]:checked ~ label {
		text-shadow: 0 0 0 rgba(247, 202, 1, 95);
	}
	
	textarea {
		resize:none;
	}
	
	
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h1 class="text-center"><strong>자 료 내 용 상 세 보 기</strong></h1>
		<br/>
		<table class="table table-bordered text-center">
			<tr>
				<th>게시자</th>
				<td>${vo.nickName}</td>
				<th>게시날짜</th>
				<td>${fn:substring(vo.FDate, 0, 10)}</td>
			</tr>
			<tr>
				<th>파일명</th>
				<td>
					<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
					<c:set var="fSNames" value="${fn:split(vo.FSName, '/')}" />
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
					</c:forEach>
					(<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
					</td>
				<th>다운로드횟수</th>
				<td>${vo.downNum}</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>${vo.part}</td>
				<th class="table-warning">접속IP</th>
				<td>${vo.hostIp}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3" class="text-left">${vo.title}</td>
			</tr>
			<tr>
				<th>상세내용</th>
				<td colspan="3" class="text-left" style="height:180px">
				${fn:replace(vo.content, newLine, '<br>')}
				</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center">
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/pds/pdsList?pag=${pag}&pageSize=${pageSize}&part=${part}';" class="btn btn-danger btn-sm" />
				</td>
			</tr>
		</table>
		<br/><hr/>
		<!-- 리뷰  -->
		<div>
			<form name="starForm" id="starForm">
				<fieldset style="border:0px;">
					<div class="viewPoint m-0 b-0">
						<input type="radio" name="star" value="5" id="star1" /><label for="star1">★</label>
						<input type="radio" name="star" value="4" id="star2" /><label for="star2">★</label>
						<input type="radio" name="star" value="3" id="star3" /><label for="star3">★</label>
						<input type="radio" name="star" value="2" id="star4" /><label for="star4">★</label>
						<input type="radio" name="star" value="1" id="star5" /><label for="star5">★</label>
						: 별점 주기 ◆ 
					</div>
				</fieldset>
				<div class="m-0 p-0">
					<textarea rows="3" name="review" id="review" class="form-control mb-2" placeholder="별점후기를 작성시 100포인트 지급!"></textarea>
				</div>
				<div>
					<input type="button" value="리뷰등록" onclick="reviewCheck()" class="btn btn-outline-primary btn-sm form-control" />
				</div>
			</form>
		</div>
		<hr/>
		<br/>
		<div id="score" class="row">
			<div class="col">
				<h4><input type="button" value="보이기" id="reviewShowBtn" onclick="reviewShow()" class="badge badge-pill badge-primary" /></h4>
				<h4><input type="button" value="감추기" id="reviewHideBtn" onclick="reviewHide()" class="badge badge-pill badge-warning" /></h4>
			</div>
			<div class="col text-right">
				<b>리뷰평점 : <font size="5em"><fmt:formatNumber value="${reviewAvg}" pattern="#,##0.0" /></font></b>
			</div>
		</div>
		<br/>
		<div id="reviewBox">
			<c:forEach var="vo" items="${rVos}" varStatus="st">
				<div class="row">
					<div class="col ml-3">
						<b>${vo.nickName}</b>
						<span style="font-size:9px">${fn:substring(vo.RDate,0,10)}</span>
						<c:if test="${vo.mid == sMid || sLevel == 0}">
							<a href="javascript:reviewDelete(${vo.idx})" title="삭제" class="badge badge-pill badge-danger">X</a>
						</c:if>
							<a href="#" onclick="reviewReply('${vo.idx}','${vo.nickName}','${vo.content}')"  title="답글달기" class="badge badge-pill badge-success" data-toggle="modal" data-target="#replyModal">RE</a>
							<%-- <p>${vo.idx} / ${vo.nickName} / ${vo.content}</p> --%>
					<div class="row borderless m-1 p-1">
						${fn:replace(vo.content, newLine, '<br>')}	
					</div>
					</div>
					<div class="col text-right mr-2">
						<c:forEach var="i" begin="1" end="${vo.star}" varStatus="iSt">
							<font color="gold">★</font>
						</c:forEach>
						<c:forEach var="j" begin="1" end="${5 - vo.star}" varStatus="iSt">☆</c:forEach>
					</div>
				</div>
			<hr/>
			</c:forEach>
		</div>
		<!-- 자료실에 업로드 된 자료가 사진이라면 아래에 모두 보여주기 -->
		<div class="text-center">
			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
			${fNames[st.index]}<br/>
			<c:set var="len" value="${fn:length(fSName)}" />
			<c:set var="ext" value="${fn:substring(fSName, len-3, len)}" />
			<c:set var="extLower" value="${fn:toLowerCase(ext)}" />
			<c:if test="${extLower == 'jpg' || extLower == 'png' || extLower == 'gif'}">
				<img src="${ctp}/pds/${fSName}" width="80%" />
			</c:if>
			<hr/>
			</c:forEach>
		</div>
		<!-- 위로가기 버튼 -->
		<h5 id="topButton" class="text-right mr-3"><img src="${ctp}/images/top_arrow.gif" /></h5>
	</div>
<p><br/></p>

	<!-- 답글달기 모달 띄우기 -->
	<div class="modal fade" id="replyModal">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title"> &gt;&gt; 리뷰 답글달기 &lt;&lt; </h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form name="reviewReplyForm" class="was-validated">
						<table class="table table-bordered">
							<tr>
								<th style="26%">게시글 작성자</th>
								<td style="74%"><span id="reviewReplyNickName"></span></td>
							</tr>
							<tr>
								<th>게시글 내용</th>
								<td><span id="reviewReplyContent"></span></td>
							</tr>
						</table>
						
						답글 작성자 : ${sNickName}<br/>
						답글 내용 
						<textarea rows="3" name="replyContent" id="reviewReplyContent" class="form-control mb-2" required></textarea>
						<input type="button" value="답글달기" onclick="reviewReplyCheck()" class="btn btn-outline-success form-control">
						<input type="hidden" name="replyIdx" value="${vo.idx}" />
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>