<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chartForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	option {
		font-style: italic;
		font-weight: 900;
	}	
	
	.marquee-container {
		width: 100%;
		height: 120px;	
	}
   
</style>
<script>
	'use strict';
	
	/*
	// 차트 변경
	function chartChange(part) {
		location.href='${ctp}/study/chart/chartForm?part='+part;
	}
	*/
	
	function chartChange() {
		let part = document.getElementById('part').value;
		
		myform.submit();
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<div class="marquee-container">
    <marquee direction="down" scrollamount="10" scrolldelay="20">
    	<h1><span class="text-center text-warning"><b>
    		Google Chart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		Google Chart&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		Google Chart
    	</b></span></h1>
    </marquee>    
  </div>
	<div>
		<div> Choose to pratice Chart <br/><br/><br/>
			<form name="myform" method="get">
				<select name="part" id="part" onchange="chartChange(this.value)" class="form-control">
					<option class="op" value="">Choose</option>
					<option class="op" value="barV">수직막대차트</option>
					<option class="op" value="barH">수평막대차트</option>
					<option class="op" value="line">작은선차트</option>
					<option class="op" value="pie">원형차트</option>
					<option class="op" value="pie3D">3D원형차트</option>
					<option class="op" value="pieDonut">도넛차트</option>
					<option class="op" value="bubble">버블차트</option>
					<option class="op" value="gant">간트차트</option>
					<option class="op" value="timeLine">타임라인스</option>
					<option class="op" value="combo">combo</option>
					<option class="op" value="CheekyIcyThang">Cheeky Icy Thang</option>
				</select>
			</form>
		</div><br/><hr/><br/>
		<div>
			<c:if test="${part == 'barV'}"><jsp:include page="barVChart.jsp" /></c:if>
			<c:if test="${part == 'barH'}"><jsp:include page="barHChart.jsp" /></c:if>
			<c:if test="${part == 'line'}"><jsp:include page="line.jsp" /></c:if>
			<c:if test="${part == 'pie'}"><jsp:include page="pie.jsp" /></c:if>
			<c:if test="${part == 'pie3D'}"><jsp:include page="pie3D.jsp" /></c:if>
			<c:if test="${part == 'pieDonut'}"><jsp:include page="pieDonut.jsp" /></c:if>
			<c:if test="${part == 'bubble'}"><jsp:include page="bubble.jsp" /></c:if>
			<c:if test="${part == 'gant'}"><jsp:include page="gant.jsp" /></c:if>
			<c:if test="${part == 'timeLine'}"><jsp:include page="timeLine.jsp" /></c:if>
			<c:if test="${part == 'combo'}"><jsp:include page="combo.jsp" /></c:if>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

