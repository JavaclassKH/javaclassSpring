<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function ajaxTest1(idx) {
		//location.href="${ctp}/study/ajax/ajaxTest1?idx="+idx;		
		
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest1",
			type : "post",
			data : {idx : idx},
			success : function(res) {
				$("#demo1").html(res);
			},
			error : function() {
				alert("ajaxTest1 전송 오류");
			}
		});
		
	}
	
	function ajaxTest2(str) {
		
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest2",
			type : "post",
			//contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			//headers : { ContentType : "application/json; charset=UTF-8" },
			data : {str : str},
			success : function(res) {
				$("#demo2").html(res);
			},
			error : function() {
				alert("ajaxTest2 전송 오류");
			}
		});
		
	}
	
	// vo를 사용한 아이디로 검색
	function fCheckId1() {
		let mid = document.getElementById("mid").value;
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요");
    		document.getElementById("mid").focus();
    		return false;
    	}
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest4-1",
    		type : "post",
    		data : {mid : mid},
    		success:function(vo) {
    			console.log(vo);
    			let str = '<h5>vo로 전송된 자료 출력</h5>';
    			if(vo != '') {
    			  str += '아이디 : ' + vo.mid + '<br/>';
    			  str += '성명 : ' + vo.name + '<br/>';
    			  str += '나이 : ' + vo.age + '<br/>';
    			  str += '주소 : ' + vo.address + '<br/>';
    			}
    			else {
    				str += "<b>찾고자 하는 자료가 없습니다.</b>";
    			}
    			$("#d3").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
	}
	
	// vo를 사용한 아이디로 검색
	function fCheckId2() {
		let mid = document.getElementById("mid").value;
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요");
    		document.getElementById("mid").focus();
    		return false;
    	}
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest4-2",
    		type : "post",
    		data : {mid : mid},
    		success:function(vos) {
    			console.log(vos);
    			let str = '<h5>vo로 전송된 자료 출력</h5>';
    			
    			if(vos != '') {
    				str += '<table class="table table-borderless table-hover text-center">'
    				str += '<tr class="table-secondary">';
    				str += '<th>아이디</th><th>이름</th><th>나이</th><th>주소</th>';
 						str += '</tr>';
 						for(let i=0; i<vos.length; i++) {
 							str += '<tr>';
	    			  str += '<td>' + vos[i].mid + '</td>';
	    			  str += '<td>' + vos[i].name + '</td>';
	    			  str += '<td>' + vos[i].age + '</td>';
	    			  str += '<td>' + vos[i].address + '</td>'; 							
 							str += '</tr>';
 						}
 							str += '<tr><td colspan="4" class="m-0 p-0"></td></tr>';
 							str += '</table>';
    			}
    			else {
    				str += "<b class='text-center'>찾고자 하는 자료가 없습니다.</b>";
    			}
    			
    			$("#d3").html(str);
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
	<h1 style="text-align: center; vertical-align: top;">Here is ajaxForm</h1>
	<br/><hr/><br/>
	<div>
		Basic(int -> String -> int -> String) <br/><br/>
		<a href="javascript:ajaxTest1(10)" class="btn btn-light mr-2 mb-2">valueTransfer1 </a>&nbsp;&nbsp;&nbsp;<span id="demo1"></span>
	</div><br/>
	<div>
		Basic(String) <br/><br/>
		<a href="javascript:ajaxTest2('안농')" class="btn btn-light mr-2 mb-2">valueTransfer2 </a>&nbsp;&nbsp;&nbsp;<span id="demo2"></span>
	</div>
	<br/><hr/><br/>
	<div class="mb-2">
		Application(Array) - 시(도)/구(시,군,동) print<br/><br/>
		<a href="${ctp}/study/ajax/ajaxTest3_1" class="btn btn-primary mr-2">StringArray</a>&nbsp;&nbsp;&nbsp;<span id="demo2"></span>		
		<a href="${ctp}/study/ajax/ajaxTest3_2" class="btn btn-secondary mr-2">ArrayList</a>&nbsp;&nbsp;&nbsp;<span id="demo2"></span>		
		<a href="${ctp}/study/ajax/ajaxTest3_3" class="btn btn-dark mr-2">Map</a>&nbsp;&nbsp;&nbsp;<span id="demo2"></span>		
		<a href="${ctp}/study/ajax/ajaxTest3_4" class="btn btn-info mr-2">Search name from DB</a>&nbsp;&nbsp;&nbsp;<span id="demo2"></span>		
	</div>
	<br/><hr/><br/>
	<div> ID : 
		<input type="text" name="mid" id="mid" style="border: 1px solid gray; border-radius: 3px;" autofocus />
		<input type="button" value="AllIDmatch(vo)" onclick="fCheckId1()" class="btn btn-info mr-3" />
		<input type="button" value="partIDmatch(vos)" onclick="fCheckId2()" class="btn btn-info mr-3" />
	</div><br/>
	<div id="d3"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

