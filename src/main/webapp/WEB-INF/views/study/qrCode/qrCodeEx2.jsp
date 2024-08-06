<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qrCodeEx2.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function qrCodeCreate2() {
		let moveUrl = $("#moveUrl").val();
		
		if(moveUrl.trim() == "") {
			alert("사이트 주소를 입력해주세요");
			$("#moveUrl").focus();
			return false;
		}

		$.ajax({
			url : "${ctp}/study/qrCode/qrCodeCreate2",
			type : "post",
			data : {moveUrl:moveUrl},
			success:function(res){
				if(res != "") {
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
	<h1 class="text-center text-info"><b>QR코드 찍으면 소개할 사이트로 이동시키기 이동시키기</b></h1>
	<div>(소개하고픈 사이트의 주소 입력 레츠기리론~ 가자구 어서어!)</div>
  <form name="myform" method="post">
    <table class="table table-bordered border-radius text-center">
      <tr class="table table-warning">
        <td colspan="2"><font size="10em"><b>Info to QRCode</b></font></td>
      </tr>
      <tr>
        <th>URL to Go</th>
        <td><input type="text" name="moveUrl" id="moveUrl" value="https://cafe.daum.net/IVEstarship" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR생성" onclick="qrCodeCreate2()" class="btn btn-outline-success mr-2"/>
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

