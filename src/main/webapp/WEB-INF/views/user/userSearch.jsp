<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userSearch.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function deleteCheck(idx) {
		let ans = confirm("선택회원을 삭제하시겠습니까?");
		
		if(!ans) return false;
		else  location.href='${ctp}/user/userDelete?idx='+idx;
		
	}
	
	$(document).ready(function(){
		$(".userInput").hide();
		$("#btnShow").show();
		$("#btnHide").hide();
		
		$("#btnShow").click(function(){
			$(".userInput").show();
			$("#btnShow").hide();
			$("#btnHide").show();
		});
		
		$("#btnHide").click(function(){
			$(".userInput").hide();
			$("#btnShow").show();
			$("#btnHide").hide();
		});
	});
	
	// 회원개별조회
	function userSearch() {
		let mid = myform.mid.value;
		
		if(mid.trim() == "") {
			alert("아이디를 입력하세요");
			$("#mid").focus();
			return false;
		}
		else {
			location.href="${ctp}/user/userSearch?mid="+mid;
		}
		
	}
	
	
</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회 원 개 별 조 회</h2>
	<hr/>
	<input type="button" id="btnShow" value="보여" class="btn btn-primary" />
	<input type="button" id="btnHide" value="가려" class="btn btn-primary" />
	<div class="userInput">
		<form name="myform" method="post" action="${ctp}/user/userInputOk">
			<table class="table table-hover">
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="mid" value="atom1234" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>성명</th>
					<td>
						<input type="text" name="name" value="아톰맨" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>나이</th>
					<td>
						<input type="number" name="age" value="21" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address" value="청주" class="form-control" />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="가입" class="btn btn-success mr-3" />
						<input type="reset" value="재입력" class="btn btn-warning mr-3" />
						<input type="button" value="개별조회" onclick="userSearch()" class="btn btn-info" />
					</td>
				</tr>
			</table>
		</form><br/>
	</div>
	<br/><br/><br/>
	<div class="SearchResult">
		<table class="table table-hover">
			<tr>
				<th>아이디</th>
				<th>성명</th>
				<th>나이</th>
				<th>주소</th>
			</tr>
			<tr>
				<td>${vo2.mid}</td>
				<td>${vo2.name}</td>
				<td>${vo2.age}</td>
				<td>${vo2.address}</td>
			</tr>
		</table>
	</div>
	<br/><br/><br/>
	<table class="table table-hover">
		<tr class="table-secondary">
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>나이</th>
			<th>주소</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
				<td>${vo.address}</td>
				<td>
					<a href="javascript:deleteCheck('${vo.idx}')" class="btn btn-danger btn-sm">Del</a>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<br/><hr/>
	<div><a href="${ctp}/" class="btn btn-warning btn-lg">돌아가기</a></div>
</div>
<p><br/></p>
</body>
</html>

