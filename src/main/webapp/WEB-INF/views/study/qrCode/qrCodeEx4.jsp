<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qrCodeEx4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function qrCodeCreate4() {
		let mid = $("#mid").val();
		let name = $("#name").val();
		let email = $("#email").val();
		let movieName = $("#movieName").val();
		let movieDate = $("#movieDate").val();
		let movieTime = $("#movieTime").val();
		let movieAdult = $("#movieAdult").val();
		let movieChild = $("#movieChild").val();
		
		if(mid.trim() == "" || name.trim() == "" || email.trim() == "" || movieName.trim() == "" || movieDate.trim() == "" || movieTime.trim() == "") {
			alert("아이디 필수입력");
			$("#mid").focus();
			return false;
		}
		
		let query = {
			mid : mid,
			name : name,
			email : email,
			movieName : movieName,
			movieDate : movieDate,
			movieTime : movieTime,
			movieAdult : movieAdult,
			movieChild : movieChild
		}

		$.ajax({
			url : "${ctp}/study/qrCode/qrCodeCreate4",
			type : "post",
			data : query,
			success:function(res){
				$("#qrCodeView").show();
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
	
	function qrCodeSearch() {
		let qrCode = $("#qrCode").val();
		$.ajax({
			url : "${ctp}/study/qrCode/qrCodeSearch",
			type : "post",
			data : {qrCode:qrCode},
			success:function(vo){
				let str = '';
				str += '<table class="table table-info">';
 				str += '<tr><td>구매자 아이디 ' + vo.mid + '</td></tr>';
				str += '<tr><td>티켓발매날짜 ' + vo.publishDate + '</td></tr>';
				str += '<tr><td>구매자 이름 ' + vo.name + '</td></tr>';
				str += '<tr><td>구매자 이메일 ' + vo.email + '</td></tr>';
				str += '<tr><td>영화 제목 ' + vo.movieName + '</td></tr>';
				str += '<tr><td>영화 상영일 ' + vo.movieDate + '</td></tr>';
				str += '<tr><td>영화 상영시간 ' + vo.movieTime + '</td></tr>';
				str += '<tr><td>성인 관람객 수 ' + vo.movieAdult + '</td></tr>';
				str += '<tr><td>소인 관람객 수 ' + vo.movieChild + '</td></tr>';
				str += '</table>';
				
				$("#demoQrCode").html(str);
			
				
				
				
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
	<h1 class="text-center text-info"><b>티켓정보를 QR코드로 생성하기</b></h1>
	<p>영화티켓 예매정보를 QR코드로 생성</p>
	<p>생성된 QR코드를 메일로 보내드립니다, 입장시 QR코드를 제시해주세요</p>
  <form name="myform" method="post">
    <table class="table table-border text-center">
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
      <tr class="table table-warning">
        <td colspan="2"><font size="10em"><b>Info to QRCode</b></font></td>
      </tr>
      <tr>
        <th>MOVIE Name</th>
        <td>
        	<select name="movieName" id="movieName" class="form-control">
        		<option value="">Select your own Movie Name</option>
        		<option>범죄도시4</option>
        		<option>인사이드아웃2</option>
        		<option>하이재킹</option>
        		<option>데드풀과 울버린</option>
        		<option>콰이어트 플레이스 - 첫 날</option>
        		<option>듄</option>
        		<option>여고괴담3 - 여우 계단</option>
        		<option>미확인 동영상 : 절대클릭금지</option>
        		<option>퓨리오사 : 매드맥스 사가</option>
        	</select>
        </td>
      </tr>
      <tr>
        <th>상영일자선택</th>
        <td><input type="date" name="movieDate" id="movieDate" value="<%= LocalDate.now() %>" required class="form-control" /></td>
      </tr>
      <tr>
        <th>상영시간선택</th>
        <td>
        	<select name="movieTime" id="movieTime" class="form-control">
        		<option value="">Select your own Movie Time</option>
        		<option>09시~11시</option>
        		<option>11시30분~13시30분</option>
        		<option>14시00분~16시00분</option>
        		<option>16시30분~18시30분</option>
        		<option>19시00분~21시00분</option>
        		<option>21시30분~23시30분</option>
        	</select>
        </td>
      </tr>
      <tr>
      	<td colspan="2">
	      	<div class="input-group">
	      	<div class="input-group-prepend">성인</div>
	      		<input type="number" name="movieAdult" id="movieAdult" value="1" min="1" required class="form-control" />
	      	</div>	
	      	<div class="input-group">
	      		<div class="input-group-prepend">아동</div>
	      		<input type="number" name="movieChild" id="movieChild" value="0" min="0" required class="form-control" />
	      	</div> 
      	</td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR생성" onclick="qrCodeCreate4()" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="reset" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="Back" onclick="location.href='qrCodeForm';" class="btn btn-primary mr-6"/>
        </td>
      </tr>
    </table>
  </form><br/><br/><hr/><br/><br/>
 	<div>&lt; 생성된 QR코드 &gt;<br/><br/>
	 	<div id="demo"></div>
 	</div><br/><hr/><br/>
 	<div id="qrCodeView" style="display: none; border: 1px dotted red;">
 		<h3>생성된 QR코드와 DB의 정보를 확인해본다!</h3>
		<div class="input-group">
			<input type="text" name="qrCode" id="qrCode" class="form-control" />
			<div class="input-group-append">
				<input type="button" value="DB검색" onclick="qrCodeSearch()" class="form-control" />
			</div>
		</div>
		<div id="demoQrCode"></div>
 	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>








