<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoEx2.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>

	// 선택지점 검색
	function addressSearch() {
		let address = myform.address.value;
		
		if(address.trim() == "") {
			alert("검색지점선택 기릿");
			return false;
		}
		alert("검색하러 슈웅~~");
		myform.submit();
	}
	
	// 검색지점 삭제
	function addressDelete() {
		let address = myform.address.value;
		if(address.trim() == "") {
			alert("삭제지점선택 기릿");
			return false;
		}
		let ans = confirm("ㄹㅇ 삭제?! ㄷㄷ.. ");
		if(!ans) return false;
		
		$.ajax({
			url : "${ctp}/study/kakao/kakaoAddressDelete",
			type : "post",
			data : {address : address},
			success:function(r){
				if(r != "0") {
					alert("선택지점이 삭제되었습니다");
					location.href="${ctp}/study/kakao/kakaoEx2";
				}
				else {
					alert("선택지점이 삭제되지 않았습니다");					
				}
			},
			error:function(){
				alert("5Ryu");
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
	<h1 class="text-success text-center">내 DB에 저장된 지명 검색</h1><br/>
	
	<form name="myform" method="get">
	  <select name="address" id="address" class="form-control"> <!--  onchange="javascript:alert('Home.. My Sweet Home');" -->
	  	<option value="">지역을 선택하세요</option>
	  	<c:forEach var="aVo" items="${addressVos}">
	  		<option value="${aVo.address}" ${aVo.address == vo.address ? selected : ''}>${aVo.address}</option>
	  	</c:forEach>
	  </select><br/>
	  <div class="text-right">
			<button onclick="addressSearch()" class="btn btn-light btn-lg mr-4">지점선택</button>
			<button onclick="addressDelete()" class="btn btn-light btn-lg">검색된지점삭제</button>
	  </div>
	</form><br/><hr/><br/>
	
	<div id="map" style="width:100%;height:400px;"></div>
	
	<!-- 카카오맵 Javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(36.63510859972897, 127.45950443649697), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성합니다
		//var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		//geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     //if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude});
		        //var coords = new kakao.maps.LatLng(36.63510859972897, 127.45950443649697);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.address}</div>'
		            //content: '<div style="width:150px;text-align:center;padding:6px 0;">집가고싶다..</div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    //} 
						//});    
	</script>
	<hr/>
	<jsp:include page="kakaoMenu.jsp" />
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

