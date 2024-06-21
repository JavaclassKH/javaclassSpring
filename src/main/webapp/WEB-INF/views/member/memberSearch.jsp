<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberSearch.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src = "${ctp}/js/woo.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
    <h2 class="text-center"><b><font color="blue">개  별  회  원  정  보</font></b></h2>
   	<div>
			<table class="table table-hover">
				<tr class="text-dark table-primary text-center">
					<th>번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>성명</th>
					<th>성별</th>
					<th>생일</th>
					<th>전화번호</th>
					<th>주소</th>			
					<th>이메일</th>			
					<th>홈페이지</th>			
					<th>직업</th>			
					<th>취미</th>			
					<th>자기소개</th>			
					<th>회원가입일</th>			
					<th>마지막방문일</th>			
				</tr>						
					<tr class="text-center">
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.nickName}</td>
						<td>${vo.name}</td>
						<td>${vo.gender}</td>
						<td>${fn:substring(vo.birthday,0,10)}</td>
						<td>${vo.tel}</td>
						<td>${vo.address}</td>
						<td>${vo.email}</td>
						<td>${vo.homePage}</td>
						<td>${vo.job}</td>
						<td>${vo.hobby}</td>
						<td>${vo.content}</td>
						<td>${vo.startDate}</td>
						<td>${vo.lastDate}</td>
					</tr>
				<tr><td colspan="15" class="m-0 p-0"></td></tr>
			</table>
			<div class="text-center"><a href="javascript:window.close();" class="btn btn-outline-danger btn-lg"><font color="darkred">돌아가기</font></a></div>
		</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>