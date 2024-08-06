<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qrCodeEx1.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function qrCodeCreate1() {
		let mid = $("#mid").val();
		let name = $("#name").val();
		let email = $("#email").val();
		
		if(mid.trim() == "" || name.trim() == "" || email.trim() == "") {
			alert("개인정보를 입력해주세요");
			$("#mid").focus();
			return false;
		}
		
		let query = {
				mid : mid,
				name : name,
				email : email
		}

		$.ajax({
			url : "${ctp}/study/qrCode/qrCodeCreate1",
			type : "post",
			data : query,
			success:function(res){
				if(res != "") {
					alert(res);
					
					let qrCode = 'QR Code명 : ' + res + '<br/>';
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h1 class="text-center text-info"><b>개인정보를 QR코드로 생성하기</b></h1>
  <form name="myform" method="post">
    <table class="table table-bordered border-radius text-center">
      <tr class="table table-warning">
        <td colspan="2"><font size="10em"><b>Info to QRCode</b></font></td>
      </tr>
      <tr>
        <th>ID</th>
        <td><input type="text" name="mid" id="mid" value="${sMid}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>NAME</th>
        <td><input type="text" name="name" id="name" value="sona123" required class="form-control" /></td>
      </tr>
      <tr>
        <th>email</th>
        <td><input type="email" name="email" id="email" value="forjustgood@gmail.com" required class="form-control" /></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR생성" onclick="qrCodeCreate1()" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="reset" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="Back" onclick="location.href='qrCodeForm';" class="btn btn-primary mr-6"/>
          <a href="javascript:kakaoLogin()" class="ml-4"><img src="${ctp}/images/kakao_login_medium_narrow.png" height="35.75px" /></a>
        </td>
      </tr>
    </table>
  </form><br/>
 	<div>&lt; 생성된 QR코드 &gt;<br/><br/>
	 	<div id="demo"></div>
 	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

