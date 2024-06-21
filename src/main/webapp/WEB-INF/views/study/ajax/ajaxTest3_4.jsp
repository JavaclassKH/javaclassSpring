<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxTest3_4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	$(document).ready(function(){
		$("#myformName").hide();
		$("#myformAge").hide();
		$("#myformAddress").hide();
	});
	
	// 선택폼 변경 출력
	function showFormChange(part) {
		if(part == 'name') {
			$("#myformName").show();
			$("#myformAge").hide();
			$("#myformAddress").hide();
		}
		else if(part == 'age') {
			$("#myformName").hide();
			$("#myformAge").show();
			$("#myformAddress").hide();
		}
		else if(part == 'address') {
			$("#myformName").hide();
			$("#myformAge").hide();
			$("#myformAddress").show();
		}
		else if(part == 'hideAll') {
			$("#myformName").hide();
			$("#myformAge").hide();
			$("#myformAddress").hide();
		}
	}
	
	// 회원정보 가져오기
	function partCheck(part) {
		
		if(part == 'name') {
			let name = $("#name").val();
			$.ajax({
				url : "${ctp}/study/ajax/ajaxTest3_4",
				type : "post",
				data : {
					name : name,
					flag : 'na'	
				},
				success:function(age) {
					$(".nameAge").show();
					$("#nameDemo").html(age);
				},
				error:function() {
					alert("전송오류");
				}
			});	
		}
		
		else if(part == 'age') {
			let age = $("#age").val();
			$.ajax({
				url : "${ctp}/study/ajax/ajaxTest3_4",
				type : "post",
				data : {
					age : age,
					flag : 'ag'	
				},
				success:function(age) {
					$(".nameAge").show();
					$("#nameDemo").html(age);
				},
				error:function() {
					alert("전송오류");
				}
			});	
		}
		
		else if(part == 'address') {
			let address = $("#address").val();
			let res = "";
			$.ajax({
				url : "${ctp}/study/ajax/ajaxTest3_4",
				type : "post",
				data : {
					address : address,
					flag : 'ad'	
				},
				success:function(vos) {
					for(let vo of vos) {
						res += vo[i];
					}
					
					$(".nameAge").show();
					$("#nameDemo").html(age);
				},
				error:function() {
					alert("전송오류");
				}
			});	
		}
		
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h1>ajaxTest3_4.jsp(ArrayList)</h1><br/>
	<div>
		<input type="button" value="이름검색" onclick="showFormChange('name')" class="btn btn-success" />
		<input type="button" value="나이검색" onclick="showFormChange('age')" class="btn btn-success" />
		<input type="button" value="주소검색" onclick="showFormChange('address')" class="btn btn-success" />
		<input type="button" value="전부숨기기" onclick="showFormChange('hideAll')" class="btn btn-success" />
	</div><br/><hr/><br/>		
	
	<form name="myformName" id="myformName" method="post">
		<h3>회원 이름을 선택하세요</h3>
		<select name="name" id="name" class="form-control">
			<c:forEach var="vo" items="${vos}">
				<option>${vo.name}</option>
			</c:forEach>
		</select>
			<input type="button" value="선택" onclick="nameCheck('name')" class="btn btn-info mr-3 mt-3" />
			<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-danger mr-3 mt-3" />
	</form>
	
	
	<form name="myformAge" id="myformAge" method="post">
		<h3>회원 나이를 선택하세요</h3>
		<select name="age" id="age" class="form-control">
			<c:forEach var="vo" items="${vos}">
				<option>${vo.age}</option>
			</c:forEach>
		</select>
			<input type="button" value="선택" onclick="partCheck('age')" class="btn btn-info mr-3 mt-3" />
			<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-danger mr-3 mt-3" />
	</form>
	
	
	<form name="myformAddress" id="myformAddress" method="post">
		<h3>회원 주소를 선택하세요</h3>
		<select name="address" id="address" class="form-control">
			<c:forEach var="vo" items="${vos}">
				<option>${vo.address}</option>
			</c:forEach>
		</select>
			<input type="button" value="선택" onclick="partCheck('address')" class="btn btn-info mr-3 mt-3" />
			<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-danger mr-3 mt-3" />
	</form>
	
	<div>
		<span id="infoShow"></span>		
	</div>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

