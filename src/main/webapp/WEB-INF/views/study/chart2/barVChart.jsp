<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>barVChart.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['bar']});
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['Year', 'views', 'subscribe', 'good'],
      ['2021', 300, 400, 200],  
      ['2022', 1110, 260, 220],
      ['2023', 660, 1120, 300],
      ['2024', 1630, 5740, 3500]
    ]);

    var options = {
      chart: {
        title: '연도별 유튜브 채널 달성률 통계',
        subtitle: 'views, subscribe, and good: 2021-2024(단위: 1000)',
      }
    };

    var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

    chart.draw(data, google.charts.Bar.convertOptions(options));
  }
</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div id="columnchart_material" style="width: 100%; height: 500px;"></div>
</div>
<p><br/></p>
</body>
</html>

