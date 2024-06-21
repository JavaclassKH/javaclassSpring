<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberDeleteCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';

		function pwdDeleteCheck() {
			let pwd = $("#pwd").val().trim();
			if (pwd == "") {
				alert("현재 비밀번호를 입력하세요!");
				$("#pwd").focus();
			}
			else {
				let ans = confirm("회원탈퇴를 진행하시겠습니까?");
				if(ans) {
					ans = confirm("회원탈퇴가 정말로 진행됩니다. \\n회원탈퇴 후에는 1개월간 같은 아이디로 접속하실 수 없습니다 \\n회원탈퇴를 진행하시겠습니까?");
					if(ans) {
						myform.submit();
						location.href="MemberDeleteCheckOk.mem";
					}
				}
				
			}
		}

	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<div>
			<h1 class="text-center"><b>회 원 탈 퇴 신 청 페 이 지</b></h1>
			<form name="myform" method="post">
				<table class="table table-bordered table-warning text-center">
					<tr>
						<th colspan="2">
							<h2>비밀번호 확인</h2>
							<div>(회원 탈퇴를 위해 비밀번호를 한번 더 확인합니다)</div>
						</th>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="비밀번호확인" onclick="pwdDeleteCheck()" class="btn btn-success pt-2 mr-3" />
							<input type="reset" value="다시입력" class="btn btn-danger pt-2 mr-3" />
							<input type="button" value="돌아가기" onclick="location.href='MemberMain.mem';" class="btn btn-primary pt-2 mr-1" />
						</td>
					</tr>
				</table>
				<p><br/></p>
			</form>
		</div>	
	</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>