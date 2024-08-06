<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaomap.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<div id="map" style="width:100%;height:620px;"></div>
	<!-- Kakao맵을 불러주는 javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=81a8989e7cb4ef49ef24ef39b4eafb5b&libraries=services,clusterer,drawing"></script>
	<script>
	// 1. 지도를 생성하는 기본 코드! (가장 중요! 지도가 생성되어야 사용이 가능)
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(36.63510859972897, 127.45950443649697),  // 지도의 중심 좌표값 설정
			level: 3  // 지도의 확대/축소 레벨
		};
		
		var map = new kakao.maps.Map(container, options);
		
		// 지도에 교통정보를 표시하도록 지도타입을 추가합니다
		map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
	</script>
	<br/><hr/><br/>
	<jsp:include page="kakaoMenu.jsp" />	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

