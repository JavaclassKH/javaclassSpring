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
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
		<h1><b>Member Main Lobby</b></h1>
		<br/><hr/><br/><br/>
		<h2> &gt;&gt; <b>&nbsp;&nbsp;&nbsp;&nbsp; Chat &nbsp;&nbsp;&nbsp;&nbsp;</b> &lt;&lt; </h2>
		<div style="width:200px">
			<form name="chatForm">
				<label for="chat"><b>	Chat</b></label>
				<iframe src="${ctp}/include/memberMessage.jsp" name="chatFrame" height="220px" class="border"></iframe>
				<div class="input-group mt-2">
					<input type="text" name="chat" id="chat" class="form-control" placeholder="enter" autofocus />
					<div class="input-group-append">
						<input type="button" value="엔터" onclick="chatInput()" class="btn btn-outline-primary" />
					</div>
				</div>
			</form>
		</div>
		<!-- 실시간 비밀채팅 만들기 -->
		<c:if test="${!empty sLogin}">
			임시비밀번호가 메일로 발급되었습니다.
			임시비밀번호로 로그인 후 비밀번호를 변경해주세요
		</c:if>
		<div class="row">
			<div class="col">
				<p class="mb-2">Now <font color="navy"><b>${sNickName}</b></font>(<font color="red">${strLevel}</font>)is Login.</p>
				<p class="mb-2">total visit : ${mVo.visitCnt} ts</p>
				<p class="mb-2">today visit : ${mVo.todayCnt} ts</p>
				<p class="mb-2">points : ${mVo.point} points</p>
			</div>
			<div class="col">
				<p><img src = "${ctp}/data/member/${mVo.photo}" width="250px" /></p>
			</div>
		</div>
		<div>
			<h4 class="mt-4"><b>Activity details</b></h4>
			<p>guest : ${guestCnt}</p>
			<p>board : __</p>
			<p>pds : __</p>
		</div>
	</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>













