<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wordcloudForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function wordCheck1() {
		let content = $("#content").val();
		if(content.trim() == "") {
			alert("입력plz");
			 $("#content").focus();
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/wordcloud/analyzer1",
			type: "post",
			data : {content : content},
			success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+ no +"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    		},
    		error : function() {
    			alert("전송오류~");
    		}
		});
		
	}

	
	function wordCheck2() {		
    	$.ajax({
    		url  : "${ctp}/study/wordcloud/analyzer2",
    		type : "post",
    		success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    		},
    		error : function() {
    			alert("전송오류~");
    		}
    	});
    }
	
	function wordCheck3() {		
			let url = "https://news.naver.com/"
			let selector = "div.cjs_t";
		
    	$.ajax({
    		url  : "${ctp}/study/wordcloud/analyzer3",
    		type : "post",
    		data : {
    			url : url,
    			selector : selector
    		},
    		success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    			
    			let _width = '650';
    			let _height = '380';
    			 
    			// 팝업을 가운데 위치시키기 위해 아래와 같이 값 구하기
    			let _left = Math.ceil(( window.screen.width - _width ) / 2);
    			let _top = Math.ceil(( window.screen.height - _height ) / 2); 
    			
    			window.open('${ctp}/study/wordcloud/wordcloudShow', 'wordCloud','width=1024, heigth=850, left=100, top=400');
    			
    		},
    		error : function() {
    			alert("전송오류~");
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
	<h2 class="text-primary">WordCloud 사용 예시</h2><span class="spinner-border text-danger">IVE</span>
	<br/><hr/><br/>
	<div>
		사용 단어의 빈도 수
		<textarea rows="6" name="content" id="content" placeholder="문장입력하셈" class="form-control" style="resize: none;"></textarea>
	</div><br/>
	<div class="row">
		<div class="col">
			<input type="button" value="textarea내용분석" onclick="wordCheck1()" class="btn btn-primary btn-sm" />
		</div>
		<div class="col">
			<input type="button" value="sample.txt내용분석" onclick="wordCheck2()" class="btn btn-secondary btn-sm ml-5" />
		</div>
		<div class="col">
			<input type="button" value="뉴스크롤링분석" onclick="wordCheck3()" class="btn btn-info btn-sm ml-5" />
		</div>
		<div class="col text-right">
			<input type="button" value="재실행" onclick="location.reload()" class="btn btn-danger btn-sm" />
		</div>
	</div><br/><br/>
	<h3 class="text-center"><strong>결 과</strong></h3>
	<div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

