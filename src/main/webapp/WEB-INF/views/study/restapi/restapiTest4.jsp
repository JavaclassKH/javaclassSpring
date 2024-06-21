<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restapiTest4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	async function getCrimeDate() {
		let year = $("#year").val();
		let apiyear = '';
		
		/* const like JAVA's ENUM */
		const API_KEY = 'mMd2%2FVlZATo4EDjD%2F8V9RTLHmJFMlM7ewrloDlcH0s%2Bk2Ywgw83zCKRw%2Bb9xr4GD6pzMYlZmu%2FDqnbRCyunFLA%3D%3D';
		
		if(year == 2015) apiyear = '/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669';
		else if(year == 2016) apiyear = '/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff';
		else if(year == 2017) apiyear = '/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116';
		else if(year == 2018) apiyear = '/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7';
		else if(year == 2019) apiyear = '/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0';
		else if(year == 2020) apiyear = '/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e';
		else if(year == 2021) apiyear = '/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2';
		else if(year == 2022) apiyear = '/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c';
		
		let url = 'https://api.odcloud.kr/api';
		url += apiyear;
		url += "?serviceKey=" + API_KEY;
		url += "&page=1&perPage=200";
		
		let response = await fetch(url);
		let res = await response.json();
		
		let str = res.data.map((item, i) => [
			(i+1) + " . "
			+ "발생년도 : " + item.발생년도 + "년 &nbsp; "
			+ " , 경찰서 : " + item.경찰서
			+ " , 강도 : " + item.강도 + "건 &nbsp; "
			+ " , 절도 : " + item.절도 + "건 &nbsp; "
			+ " , 살인 : " + item.살인 + "건 &nbsp; "
			+ " , 폭력 : " + item.폭력 + "건 &nbsp; "
			+ "<br/>"			
		]);		
		
		$("#d").html(str);
	}
	
	
	
	// 검색한 자료를 DB에 저장하기
	async function saveCrimeDate() {
		let year = $("#year").val();
		let apiyear = '';
		
		const API_KEY = 'mMd2%2FVlZATo4EDjD%2F8V9RTLHmJFMlM7ewrloDlcH0s%2Bk2Ywgw83zCKRw%2Bb9xr4GD6pzMYlZmu%2FDqnbRCyunFLA%3D%3D';
		
		if(year == 2015) apiyear = '/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669';
		else if(year == 2016) apiyear = '/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff';
		else if(year == 2017) apiyear = '/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116';
		else if(year == 2018) apiyear = '/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7';
		else if(year == 2019) apiyear = '/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0';
		else if(year == 2020) apiyear = '/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e';
		else if(year == 2021) apiyear = '/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2';
		else if(year == 2022) apiyear = '/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c';
		
		let url = 'https://api.odcloud.kr/api';
		url += apiyear;
		url += "?serviceKey=" + API_KEY;
		url += "&page=1&perPage=200";
		
		let response = await fetch(url);
		let res = await response.json();	
		
		let str = res.data.map((item, i) => [
			(i+1) + " . "
			+ "발생년도 : " + item.발생년도 + "년 &nbsp; "
			+ " , 경찰서 : " + item.경찰서
			+ " , 강도 : " + item.강도 + "건 &nbsp; "
			+ " , 절도 : " + item.절도 + "건 &nbsp; "
			+ " , 살인 : " + item.살인 + "건 &nbsp; "
			+ "<br/>"			
		]);		
		
		$("#d").html(str);
		
		// 화면에 출력된 자료들을 반복문을 통해 변수에 담아준다
		let query = "";
		for(let i=0; i<res.data.length; i++) {
			if(res.data[i].경찰서 != null) {
				query = {
						year : year,
						police : res.data[i].경찰서,
						robbery : res.data[i].강도,
						theft : res.data[i].절도,
						murder : res.data[i].살인,
						violence : res.data[i].폭력
				}
			}
		
			$.ajax({
				url : "${ctp}/study/restapi/saveCrimeData",
				type : "post",
				data : query,
				error:function(){
					alert("전 송 5 Ryu");
				}
			});
		}
		alert(year + "년도 자료가 저장되었습니다");
		
		
		
		// 화면에 출력된 자료들을 모두 DB에 저장시켜준다
		
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h1 class="text-center text-dark"><strong>restapiTest4</strong></h1>
	<h2>경찰청 강력범죄 발생현황 자료 리스트</h2>
	<hr/><br/>
	<form name="mf" method="post">
		<div>
			<select name="year" id="year" class="form-control mb-3">
				<option value="">년도목록</option>
				<c:forEach var="i" begin="2015" end="2022" step="1" varStatus="st">
					<option value="${i}">${year == i ? 'selected' : ''}${i}년</option>
				</c:forEach>
			</select>
			<input type="button" value="현황조회" onclick="getCrimeDate()" class="btn btn-danger form-control mb-2" />
			<input type="button" value="DB저장" onclick="saveCrimeDate()" class="btn btn-danger form-control mb-2" />
			<input type="button" value="DB삭제" onclick="deleteCrimeDate()" class="btn btn-danger form-control mb-2" />
			<input type="button" value="DB출력" onclick="listCrimeDate()" class="btn btn-danger form-control" />
		</div><br/>
		<div>
			경찰서 지역명 : 
			<select name="police" onchange="policeCheck()" style="border: 1px solid gray; width: 120px; height: 30px; border-radius: 5px;">
				<option>서울</option>
				<option>경기</option>
				<option>강원</option>
				<option>충북</option>
				<option>충남</option>
				<option>전북</option>
				<option>전남</option>
				<option>경북</option>
				<option>경남</option>
				<option>제주</option>
			</select> &nbsp;&nbsp;&nbsp;&nbsp;
			정렬순서 : 
			오름차순 <input type="radio" name="yearOrder" value="a" /> &nbsp;&nbsp;
			내림차순 <input type="radio" name="yearOrder" value="d" />
			<input type="button" value="연도/경찰서별출력" onclick="yearPoliceCheck()" class="btn btn-outline-dark" />
		</div>
	</form>
	<br/><hr/><br/><br/>
	<div id="d"></div>
	<hr/>
	<h3>범죄 분석 통계</h3>
	<!-- 1. 년도별 /강도/살인/절도/폭력 -->
	<!-- 2. 경찰서별 /강도/살인/절도/폭력 -->
	<!-- 3. 범죄 발생 건수가 가장 적은 지역 -->
	<hr/>
	<br/><br/><hr/>
		
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

