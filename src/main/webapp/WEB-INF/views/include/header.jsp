<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>   
<head>
	<style>
		nav {
			margin-top: 4px;
			margin-right: 4px;
		}
	</style>
</head>
  <div class="header">
    <header>    
      <img src="${ctp}/resources/images/HeaderImg.jpg" width="100%" height="410px" style="position: absolute; opacity: 0.8;">
      <nav class="nav">
        <li><a href="${ctp}/member/memberLogin">로그인</a></li> &nbsp;&nbsp;
        <li><a href="${ctp}/member/memberJoin">회원가입</a></li> &nbsp;&nbsp;
        <li><a href="#">로그아웃</a></li> &nbsp;&nbsp;
      </nav>
    </header>
  </div>