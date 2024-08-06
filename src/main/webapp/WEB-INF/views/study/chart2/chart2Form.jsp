<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>chart.jsp</title>
  <style>
  	#ma {
  		height: 120px;
  	}
  </style>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function chartChange() {
    	let part = document.getElementById("part").value;
    	
    	let str = "";
    	if(part == "pie") {
    		str += '<form name="chartForm" method="post" action="googleChart2">';
    		str += '<table class="table table-bordered text-center">';
    		str += '<tr>';
    		str += '<th class="bg-secondary">차트제목</th><td colspan="3" class="bg-secondary"><input type="text" name="title" size="30" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례1</th><td><input type="text" name="subTitle1" class="form-control"/></td>';
    		str += '<th>값1</th><td><input type="number" name="value1" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례2</th><td><input type="text" name="subTitle2" class="form-control"/></td>';
    		str += '<th class="bg-light">값2</th><td><input type="number" name="value2" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례3</th><td><input type="text" name="subTitle3" class="form-control"/></td>';
    		str += '<th class="bg-light">값3</th><td><input type="number" name="value3"  class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례4</th><td><input type="text" name="subTitle4" class="form-control"/></td>';
    		str += '<th class="bg-light">값4</th><td><input type="number" name="value4" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th class="bg-light">범례5</th><td><input type="text" name="subTitle5" class="form-control"/></td>';
    		str += '<th class="bg-light">값5</th><td><input type="number" name="value5" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<td colspan="4"><input type="button" value="차트그리기" onclick="chartShow(\'pie\')" class="btn btn-primary form-control"/></td>';
    		str += '</tr></table>';
    		str += '<input type="hidden" name="part" id="part">';
    		str += '</form>';
    	}
    	else if(part == "barV") {
    		str += '<form name="chartForm" method="post" action="googleChart2">';
    		str += '<table class="table table-bordered text-center">';
    		str += '<tr><th class="bg-secondary">차트 주제목</th><td colspan="4" class="bg-secondary"><input type="text" name="title" size="30" class="form-control"/></td></tr>';
    		str += '<tr><th class="bg-secondary">차트 부제목</th><td colspan="4" class="bg-secondary"><input type="text" name="subTitle" size="30" class="form-control"/></td></tr>';
    		str += '<tr>';
    		str += '<th colspan="2">범례</th>';
    		str += '<td><input type="text" name="legend1" class="form-control"/></td>';
    		str += '<td><input type="text" name="legend2" class="form-control"/></td>';
    		str += '<td><input type="text" name="legend3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축1</th><td><input type="text" name="x1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x1Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축2</th><td><input type="text" name="x2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x2Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축3</th><td><input type="text" name="x3" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x3Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<th>X축4</th><td><input type="text" name="x4" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value1" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value2" class="form-control"/></td>';
    		str += '<td><input type="number" name="x4Value3" class="form-control"/></td>';
    		str += '</tr>';
    		str += '<tr>';
    		str += '<td colspan="5"><input type="button" value="차트그리기" onclick="chartShow(\'barV\')" class="btn btn-primary form-control"/></td>';
    		str += '</tr></table>';
    		str += '<input type="hidden" name="part" id="part">';
    		str += '</form>';
    	}
    	else if(part == "line") {
    		chartShow('line');
    	}
    	else if(part == "line2") {
    		chartShow('line2');
    	}
    	$("#demo").html(str);
    }
   
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center text-secondary"><b>구글 차트 연습2</b></h2><br/>
  <div>
    <p id="ma"><marquee direction="down" scrollamount="68" class="text-center mb-5" style="height: 120px;">학습할 차트를 선택하세요</marquee></p><br/>
    <p>
      <select name="part" id="part" onchange="chartChange()" class="form-control">
        <option value="">차트선택</option>
        <option value="barV" ${vo.part == 'barV' ? 'selected' : ''}>수직막대차트</option>
        <option value="pie" ${vo.part == 'pie' ? 'selected' : ''}>원형차트</option>
      </select>
    </p>
    <hr/>
    <div id="demo"></div>
    <div>
			<%-- <c:if test=""><jsp:include page="" /></c:if>
			<c:if test= ""><jsp:include page="" /></c:if>--%>
    </div>
    <hr/>
  </div>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>