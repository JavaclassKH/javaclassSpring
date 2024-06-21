<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
		// 채팅내용을 DB에 저장
		function chatInput() {
			let chat = document.getElementById("chat").value;
			if(chat.trim() != "") {
				$.ajax({
					url : "MemberChatInput.mem",
					type : "post",
					data : {chat : chat},
					error : function() {
						alert("채팅 전송 오류");
					}
				});
			}
		}
		
		// 채팅대화 입력 후 엔터키를 눌렀을때 자동으로 메시지 DB에 저장! chatInput() 함수 호출!
		$(function() {
			$("#chat").on("keydown",function(e){
				if(e.keyCode == 13) chatInput();
			});
		});		
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h1><b>인증회원 전용 메인 로비, 환영합니다!</b></h1>
		<br/><hr/><br/><br/>
		<h2> &gt;&gt; <b>&nbsp;&nbsp;&nbsp;&nbsp; 실시간 채팅 &nbsp;&nbsp;&nbsp;&nbsp;</b> &lt;&lt; </h2>
		<div style="width:200px">
			<form name="chatForm">
				<label for="chat"><b>	실&nbsp;&nbsp; 시&nbsp;&nbsp; 간&nbsp;&nbsp; 대&nbsp;&nbsp; 화 </b></label>
				<iframe src="${ctp}/include/memberMessage.jsp" name="chatFrame" height="220px" class="border"></iframe>
				<div class="input-group mt-2">
					<input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요." autofocus />
					<div class="input-group-append">
						<input type="button" value="엔터" onclick="chatInput()" class="btn btn-outline-primary" />
					</div>
				</div>
			</form>
		</div>
		<!-- 실시간 비밀채팅 만들기 -->
		<div class="row">
			<div class="col">
				<p class="mb-2">현재 <font color="navy"><b>${sNickName}</b></font>(<font color="red">${strLevel}</font>)님이 로그인 중입니다.</p>
				<p class="mb-2">총 방문횟수 : ${mVo.visitCnt} 회</p>
				<p class="mb-2">오늘 방문횟수 : ${mVo.todayCnt} 회</p>
				<p class="mb-2">보유 포인트 : ${mVo.point} p</p>
			</div>
			<div class="col">
				<p><img src = "${ctp}/images/member/${mVo.photo}" width="250px" /></p>
			</div>
		</div>
		<div>
			<h4 class="mt-4"><b>활동내역</b></h4>
			<p>방명록 등록 글 수 : ${guestCnt}개</p>
			<p>게시판 등록 글 수 : __개</p>
			<p>자료실 등록 글 수 : __개</p>
		</div>
	</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

<!-- <div class="table">
			<table class="table table-hover table-dark">
			 
			</table>
		</div> -->

















