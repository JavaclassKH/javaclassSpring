<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!--  kakaoMenu.jsp  -->

<script>
	'use strict';

/*	
	let cnt = 0;

	// 초기 호출
	setTimeout(toggleMenu, 5000);

	function toggleMenu() {
	    cnt++;
	    if (cnt % 2 === 0) {
	        show();
	    } else {
	        $("#menu").hide();
	    }

	    // 다음 호출 예약
	    setTimeout(toggleMenu, 5000);
	}

	function show() {        
	    $("#menu").show();
	}
*/
	
</script>

<div id="menu">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<p>
		<a href="${ctp}/study/kakao/kakaoEx1" class="btn btn-link mr-4">Marker 표시/저장</a>
		<a href="${ctp}/study/kakao/kakaoEx2" class="btn btn-primary mr-4">내 DB에 저장된 지명 검색</a>
		<a href="${ctp}/study/kakao/kakaoEx3" class="btn btn-secondary mr-4">KakaoDB에 저장된 키워드 검색</a>
		<a href="${ctp}/study/kakao/kakaoEx4" class="btn btn-success mr-4">주변검색~~~</a>
		<a href="${ctp}/study/kakao/kakaoEx5" class="btn btn-info mr-4">거리계산</a>
		<a href="${ctp}/study/kakao/kakaoEx5" class="btn btn-light">검색지점사진저장</a>
	</p>
</div>