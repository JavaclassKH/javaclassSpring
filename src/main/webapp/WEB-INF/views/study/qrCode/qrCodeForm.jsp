<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qrCodeForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function qrCodeCreate() {
		$.ajax({
			url : "${ctp}/study/qrCode/qrCodeCreate",
			type : "post",
			success:function(res){
				if(res != "") {
					let qrCode = 'QR Code명 : ' + res + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>';
					qrCode += '<img src="${ctp}/qrCode/' + res + '.png" />';
					$("#demo").html(qrCode);
				}
				else alert("qr create fail");					
			},
			error:function(){
				alert("ㅋㅋ");
			}
		});
	}
	

	
</script>
<style>
	.alert {
		width: 400px;
		height: 300px;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2><b>QR코드 연습하기!</b></h2>
	<br/><hr/><br/>
		<div class="row">
			<div class="col">
				<a href="javascript:qrCodeCreate()" class="btn btn-light">QR생성</a>
			</div>
			<div class="col">
				<a href="qrCodeEx1" class="btn btn-success">개인정보등록</a>
			</div>
			<div class="col">
				<a href="qrCodeEx2" class="btn btn-primary">상품소개사이트</a>
			</div>
			<div class="col">
				<a href="qrCodeEx3" class="btn btn-secondary">티켓예매등록</a>
			</div>
			<div class="col">
				<a href="qrCodeEx4" class="btn btn-secondary">티켓예매정보 DB등록</a>
			</div>
		</div>
		<br/><div id="demo"></div>
	<br/><hr/><br/>
</div>


<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

