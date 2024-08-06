<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	'use strict';
	
  window.Kakao.init("81a8989e7cb4ef49ef24ef39b4eafb5b"); 	
  function kakaoLogout() {
	  const accessToken = Kakao.Auth.getAccessToken();
	  if(accessToken) {
		  Kakao.Auth.logout(function(){
				window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=81a8989e7cb4ef49ef24ef39b4eafb5b&logout_redirect_uri=http://localhost:9090/javaclassS/member/memberLogout"; 			  
		  });
	  }
  }
 
 
 
</script>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
<%--   프로젝트 제출시 이부분 주석 풀고 아래 주석하기!   --%>
		<a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <!-- <a href="http://192.168.50.64:9090/javaclassS/" class="w3-bar-item w3-button w3-padding-large">HOME</a> -->
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Guest</a>
    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Pds</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">UserList</a>
        <a href="${ctp}/dbtest/dbtestList" class="w3-bar-item w3-button">Database Test</a>
        <a href="${ctp}/study/ajax/ajaxForm" class="w3-bar-item w3-button">Ajax Test</a>
        <a href="${ctp}/study/restapi/restapi" class="w3-bar-item w3-button">REST API</a>
        <a href="${ctp}/study/password/password" class="w3-bar-item w3-button">Password Encryption</a>
        <a href="${ctp}/study/mail/mailForm" class="w3-bar-item w3-button">Mail</a>
        <a href="${ctp}/study/fileUpload/fileUpload" class="w3-bar-item w3-button">File Upload</a>
        <a href="${ctp}/study/crawling/jsoup" class="w3-bar-item w3-button">Crawling(jsoup)</a>
        <a href="${ctp}/study/crawling/selenium" class="w3-bar-item w3-button">Crawling(selenium)</a>
        <a href="${ctp}/study/wordcloud/wordcloudForm" class="w3-bar-item w3-button">WordCloud</a>
      </div>
    </div>
	  <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">Study2 <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="${ctp}/study/random/randomForm" class="w3-bar-item w3-button">randomAlphaNumeric</a>
        <a href="${ctp}/study/kakao/kakaomap" class="w3-bar-item w3-button">KakaoMap</a>
        <a href="${ctp}/study/weather/weatherForm" class="w3-bar-item w3-button">날씨API</a>
        <a href="${ctp}/study/captcha/captchaForm" class="w3-bar-item w3-button">captcha연습</a>
        <a href="${ctp}/study/qrCode/qrCodeForm" class="w3-bar-item w3-button">QR Code</a>
        <a href="${ctp}/study/thumbnail/thumbnailForm" class="w3-bar-item w3-button">Thumbnail연습</a>
        <a href="${ctp}/study/chart/chartForm" class="w3-bar-item w3-button">Web Chart First</a>
        <a href="${ctp}/study/chart2/chart2Form" class="w3-bar-item w3-button">Web Chart Second</a>
        <a href="${ctp}/study/validator/validatorForm" class="w3-bar-item w3-button">Validator</a>
        <a href="${ctp}/study/transaction/transactionForm" class="w3-bar-item w3-button">트랜잭션</a>
        <a href="${ctp}/study/scheduler/schedulerForm" class="w3-bar-item w3-button">Schedualer</a>
        <a href="${ctp}/study/dbShop/dbShopList" class="w3-bar-item w3-button">DB Shop</a>
        <a href="${ctp}/study/payment/payment" class="w3-bar-item w3-button">결제연습</a>
        <a href="${ctp}/errorPage/errorMain" class="w3-bar-item w3-button">에러페이지</a>
      </div>
	  </div>
    <div class="w3-dropdown-hover w3-hide-small">
      <button onclick="location.href='${ctp}/member/memberMain';" class="w3-padding-large w3-button" title="More">MyPage <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">Schedule Management</a>
        <a href="${ctp}/webSocket/webSocket" class="w3-bar-item w3-button">Websocket Chatting</a>
        <a href="${ctp}/dbtest/dbtestList" class="w3-bar-item w3-button">Photo Gallery</a>
        <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">MemberList</a>
        <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">Password Change</a>
        <a href="${ctp}/member/memberPwdCheck/i" class="w3-bar-item w3-button">MemberInfoChange</a>
        <a href="${ctp}/study/mail/mailForm" class="w3-bar-item w3-button">MemberCancel</a>
        <c:if test="${sLevel == 0}">
	        <a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">Administer Page</a>
        </c:if>
      </div>
    </div>
    <div class="text-right">
	    <c:if test="${empty sLevel}">
		    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-right">Login</a>
	  	  <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small w3-right">Join</a>
	    </c:if>
	    <c:if test="${!empty sLevel}">
		    <div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-large w3-button" title="More">Logout <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
				    <a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">일반 Logout</a>
				    <a href="javascript:kakaoLogout()" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Kakao Logout</a>
				    <a href="javascript:alert('잘가, 가지마 , 행복해 , 떠나지마,\n나를 잊어줘 잊고 살아가줘');" class="w3-bar-item w3-button w3-padding-large w3-hide-small">브아솔갱~</a>
				  </div>
				</div>
	    </c:if>
    </div>
    <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>

	<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
	<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
	  <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">guest</a>
	  <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">board</a>
	  <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">pds</a>
	  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">study</a>
	</div>
	
	
	
	