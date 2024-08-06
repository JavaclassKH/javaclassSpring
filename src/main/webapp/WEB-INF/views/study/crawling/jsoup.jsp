<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsoup.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
</style>
<script>
	'use strict';
	/*
	$(function(){
		$("#url").change(function(){
			let url = document.querySelector("select[name='url']");
			let urlNo = url.options[url.selectedIndex].text.substring(0,url.options[url.selectedIndex].text.indexOf("."));
			
			let selector = document.myform.selector;
			for(let i=0; i<selector.length; i++) {
				if(urlNo == selector[i].)
			}
		});
	});
	*/
	
	$(function(){
		$("#url").on("change",function(){
			let url = document.querySelector("select[name='url']");
			let urlNo = url.options[url.selectedIndex].text.substring(0,url.options[url.selectedIndex].text.indexOf("."));
			
			let temp = "<option>";
			let selector = document.myform.selector;
			for(let i=0; i<selector.length; i++) {
				if(urlNo == selector[i].value.substring(0,selector[i].value.indexOf("."))) {
					temp += selector[i].value;
					break;
				}
			}
			temp += "</option>";
			$("#selector").html(temp);
		});
	});
	
	// 크롤링1
	function crawling1() {
		let url = document.getElementById("url").value;
		let selector = document.getElementById("selector").value;
		
		if(url.trim() == "") {
			alert("주소를 선택해주세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/crawling/jsoup",
			type : "post",
			data : {
				url : url.substring(url.indexOf("-") + 1),
				selector : selector.substring(selector.indexOf(".") + 1)
			},
			success:function(res) {
				if(res != "") {
					let str = "";
					for(let i=0; i<res.length; i++) {
						str += res[i] + "<br/>";
					}
					$("#demo").html(str);
				}
				else $("#demo").html("검색된 자료가 없습니다");
			},
			error:function() {
				alert("전송오류1");
			}
		});	
	}

	// 네이버 주요(헤드라인)뉴스 검색
	function crawling2() {
		$.ajax({
			url : "${ctp}/study/crawling/jsoup2",
			type : "post",
			success:function(vos) {
				if(vos != "") {
					let str = "<table class='table table-borderless'>";
					str += "<tr class='table-light'><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>";
					for(let i=0; i<vos.length; i++) {
						str += "<tr>";
						str += "<td>" + (i+1) + "</td>";
						str += "<td>" + vos[i].item1 + "</td>";
						str += "<td>" + vos[i].item2 + "</td>";
						str += "<td>" + vos[i].item3 + "</td>";
						str += "</tr>";
					}
					str += "<tr><td colspan='4' class='m-0 p-0'></td></tr>";
					str += "</table>";
					$("#demo").html(str);
				}
				else $("#demo").html("검색된 자료가 없습니다"); 
			},
			error:function() {
				alert("전송오류2");
			}
		});			
	}

	// 다음 연예뉴스 검색
	function crawling3() {
		$.ajax({
			url : "${ctp}/study/crawling/jsoup3",
			type : "post",
			success:function(vos) {
				if(vos != "") {
					let str = "<table class='table table-borderless'>";
					str += "<tr class='table-light'><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>";
					for(let i=0; i<vos.length; i++) {
						str += "<tr>";
						str += "<td>" + (i+1) + "</td>";
						str += "<td>" + vos[i].item1 + "</td>";
						str += "<td>" + vos[i].item2 + "</td>";
						str += "<td>" + vos[i].item3 + "</td>";
						str += "</tr>";
					}
					str += "<tr><td colspan='4' class='m-0 p-0'></td></tr>";
					str += "</table>";
					$("#demo").html(str);
				}
				else $("#demo").html("검색된 자료가 없습니다"); 
			},
			error:function() {
				alert("전송오류2");
			}
		});			
	}

	  // 네어버 검색어로 검색결과 가져오기
    function crawling4() {
    	let searchString = document.getElementById("searchString").value;
    	let page = document.getElementById("page").value;
    	if(searchString.trim() == "") {
    		alert("검색어를 입력하세요");
    		document.getElementById("searchString").focus();
    		return false;
    	}
    	if(page.trim() == "") page = 1;
    	
    	let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+(page*15+1)+"&where=web";
    	let searchSelector = "div.total_dsc_wrap";
    	
    	$.ajax({
    		url  : "${ctp}/study/crawling/jsoup4",
    		type : "post",
    		data : {
    			search : search,
    			searchSelector : searchSelector
    		},
    		success:function(vos) {
    			if(vos != "") {
    				let str = '';
    				for(let i=0; i<vos.length; i++) {
    					str += vos[i] + "<br/>";
    				}
	    			$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
	

	  // 네이버 검색어로 그림 검색결과 가져오기
    function crawling5() {
    	let searchString = document.getElementById("searchString").value;
    	let page = document.getElementById("page").value;
    	if(searchString.trim() == "") {
    		alert("검색어를 입력하세요");
    		document.getElementById("searchString").focus();
    		return false;
    	}
    	if(page.trim() == "") page = 1;
    	
    	let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+(page*15+1)+"&where=web";
    	let searchSelector = "div.thumb_single _parent";
    	
    	$.ajax({
    		url  : "${ctp}/study/crawling/jsoup4",
    		type : "post",
    		data : {
    			search : search,
    			searchSelector : searchSelector
    		},
    		success:function(vos) {
    			if(vos != "") {
    				let str = '';
    				for(let i=0; i<vos.length; i++) {
    					str += vos[i] + "<br/>";
    				}
	    			$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
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
	<h2 class="text-center text-info"><strong>jsoup을 이용한 Web Crawling 연습</strong></h2><br/><hr/>
	<form name="myform" method="post">
		<div><a href="javascript:location.reload()" class="btn btn-success btn-sm form-control">재검색</a></div><br/>
		<div class="input-group mb-4">
		<div class="input-group-text"><b>크롤링할 웹 주소</b></div>
			<select name="url" id="url" class="form-control">
				<option value="">URL을 선택하세요</option>
				<option>1.Naver News-https://news.naver.com</option>
				<option>2.Naver News Images-https://news.naver.com</option>
				<option>3.Naver News 언론사이름-https://news.naver.com</option>
			</select>
		</div>
		<div class="input-group mb-4">
		<div class="input-group-text"><b>크롤링할 셀렉터</b></div>
			<select name="selector" id="selector" class="form-control">
				<option value="">셀렉터를 선택하세요</option>
				<option>1.div.cjs_t</option>
				<option>2.div.cjs_news_mw</option>
				<option>3.h4.channel</option>
			</select>
			<div class="input-group-append"><input type="button" value="크롤링1" onclick="crawling1()" class="btn btn-primary"></div>
		</div>
		<div>
			<input type="button" value="크롤링2(네이버주요뉴스)" onclick="crawling2()" class="btn btn-secondary mr-3">
			<input type="button" value="크롤링3(다음연예뉴스)" onclick="crawling3()" class="btn btn-info">
		</div><br/><hr/><br/>
		<!-- 네이버 검색어 -->
    <div class="input-group mb-3">
	    <div class="input-group-text">네이버 검색어로 검색(검색어)</div>
	    <input type="text" name="searchString" id="searchString" value="엔믹스" class="form-control"/>
    </div>
    <div class="input-group mb-3">
	    <div class="input-group-text">네이버 검색어로 검색(이미지)</div>
	    <input type="text" name="page" id="page" value="1" class="form-control" />
			<div class="input-group-append"><input type="button" value="검색크롤링5" onclick="crawling5()" class="btn btn-dark"></div>	    
    </div>
	</form><br/><hr/><br/>
	<div id="demo"></div><br/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

