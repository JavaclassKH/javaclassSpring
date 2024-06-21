<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxTest3_1.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	.btns {
		text-align: right;
	}
</style>
<script>
	'use strict';
	
	function dodoCheck() {
		let dodo = $("#dodo").val();
		
		if(dodo.trim() == "") {
			alert("지역을 선택하세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest3_1",
			type : "post",
			data : {dodo : dodo},
			success : function(res) {
				//console.log(res);
				let str = '<option>도시선택</option>';
				for(let i=0; i<res.length; i++) {
					if(res[i] == null) break;
					str += '<option>'+res[i]+'</option>';
				}
				$("#city").html(str);
				
				$("").html
			},
			error : function() {
				alert("전송오류");
			}
		});		
	}
	
	
	function fCheck() {
		let dodo = $("#dodo").val();
		let city = $("#city").val();
		
		if(dodo == "" || city == "") {
			alert("지역 선택해주셈");
			return false;
		}
		let str = "선택하신 지역은 " + dodo + " / " + city;
		$("#d").html(str);
	}
	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h1>ajaxTest3_1.jsp(문자배열 처리)</h1><br/>
	<hr/><hr/>
	<form name="myform" method="post">
		<h3>도시를 선택하세요</h3>
		<select name="dodo" id="dodo" onchange="dodoCheck()" class="form-control mb-3">
			<option>지역선택</option>
			<option>서울</option>
			<option>경기</option>
			<option>충북</option>
			<option>충남</option>
		</select>
		<select name="city" id="city" class="form-control">
			<option>도시선택</option>
		</select>
		<div class="btns">
			<input type="button" value="선택" onclick="fCheck()" class="btn btn-info mr-3 mt-3" />
			<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-danger mr-3 mt-3" />
		</div>
	</form> 
	<div id="d"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
