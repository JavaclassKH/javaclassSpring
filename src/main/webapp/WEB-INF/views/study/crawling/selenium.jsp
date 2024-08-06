<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selenium.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	#o {
		text-align: center;
	}
</style>
<script>
	'use strict';
	
	function crawling1() {
		$("#sicon").show();
		$.ajax({
			url : "${ctp}/study/crawling/selenium",
			type : "post",
			success:function(vos) {
				if(vos != "") {
					let str = "<table class='table table-borderless'>";
					str += "<tr class='table-hover text-center'><th>번호</th><th>영화제목</th><th>포스터</th><th>예매율</th></tr>";
					for(let i=0; i<vos.length; i++) {
						str += "<tr>";
						str += "<td>" + (i+1) + "</td>";
						str += "<td>" + vos[i].title + "</td>";
						str += "<td>" + vos[i].image + "</td>";
						str += "<td>" + vos[i].percent + "</td>";
						str += "</tr>";
					}
					str += "<tr><td colspan='4' class='m-0 p-0'></td></tr>";
					str += "</table>";
					$("#demo").html(str);
				}
				else $("#demo").html("검색된 자료가 없습니다"); 
				
				
				
				$("#sicon").hide();
			},
			error:function() {
				console.log("전송오류");
			}
		});
	}
	
	// Super Rapid Train Time Table 조회
	    function crawlingCheck() {
    	$("#spinnerIcon").show();
    	let stationStart = $("#stationStart").val();
    	let stationStop = $("#stationStop").val();
    	
    	$.ajax({
				url   : "${ctp}/study/crawling/train",
				type  : "post",
				data  : {
					stationStart : stationStart,
					stationStop : stationStop
				},
    		success:function(vos) {
    			if(vos != "") {
    				let str = '';
    				str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>열차</th><th>출발</th><th>도착</th><th>소요시간</th><th>요금</th></tr>';
    				for(let i=0; i<vos.length; i++) {
	    				str += '<tr>';
	    				str += '<td>'+vos[i].train+'</td>';
	    				str += '<td>'+vos[i].start+'</td>';
	    				str += '<td>'+vos[i].arrive+'</td>';
	    				str += '<td>'+vos[i].time+'</td>';
	    				str += '<td><a href="${ctp}/data/ckeditor/screenshot.png" target="_blank">'+vos[i].price+'</a></td>';
	    				str += '</tr>';
    				}
    				str += '</tr></table>';
    				$("#demo").html(str);
    				
	  				$("#spinnerIcon").hide();
    			}
    			else $("#demo").html("검색한 자료가 없습니다.");
    		}
    	});
    }

	
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container"><br/>
	<h1 class="text-center text-info"><strong>selenium을 이용한 Web Crawling 연습</strong></h1><br/><hr/>
	<form name="myform" method="post">
		<div><a href="javascript:location.reload()" class="btn btn-success btn-sm form-control">재검색</a></div><br/>
		<div class="input-group mb-4">
		<div class="input-group-text"><b>CGV Movie Chart</b></div>
			<div class="input-group-append mr-3">
				<input type="button" value="크롤링1" onclick="crawling1()" class="btn btn-secondary mr-3">
			</div>
			<span id="sicon" style="display: none;">
				<span class="spinner-border text-primary ml-4 mr-2"></span>
				&nbsp;&nbsp; 로딩중입니다 &nbsp;&nbsp;
				<span class="spinner-border text-primary"></span>
			</span>
		</div><br/><hr/><br/>
	</form><br/><hr/><br/>
	<form name="trainForm" method="post">
		<div class="input-group mb-3">
      <span class="input-group-text mr-2">출발역</span>
    	<div class="input-group-append mr-3"><input type="text" name="stationStart" id="stationStart" value="대전" class="form-control"/></div>
      &nbsp;&nbsp; ~ &nbsp;&nbsp;
     	<span class="input-group-text ml-3 mr-2">도착역</span>
      <div class="input-group-append"><input type="text" name="stationStop" id="stationStop" value="부산" class="form-control"/></div>
    </div>
    <div class="input-group mb-3">
	    <div class="input-group-prepend"><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-info" /></div>
	    <span class="input-group-text" style="width:50%">SRT 열차 시간표 조회</span>
	    <div class="input-group-append mr-1"><input type="button" value="웹크롤링" onclick="crawlingCheck()" class="btn btn-success" /></div>
	    <div class="input-group-append"><span id="spinnerIcon" style="display:none"><span class="spinner-border">NMIXX</span>검색중입니다.<span class="spinner-border"></span></span></div>
	  </div>
	</form>
	<br/><hr/><br/>
	<div id="demo"></div><br/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

