<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function UserSearch(mid) {
		let str = '';
		
		$.ajax({
			url : "study/restapi/UserSearch",
			type : "post",
			data : {mid:mid},
			success:function(vo){
				
				if(vo != null){
					str = "<b>선택하신 회원의 정보입니다</b>";
					str += "검색하신 회원의 아이디는 : " + mid + "입니다. <br/>"
					str += "검색하신 회원의 이름은 : " + vo.name + "입니다. <br/>"
					str += "검색하신 회원의 나이는 : " + vo.age + "입니다. <br/>"
					str += "검색하신 회원의 주소는 : " + vo.address + "입니다. "
				}				
				$("#demo").html(str);	
			},
			error:function(){
				alert("전송오류");
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
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

