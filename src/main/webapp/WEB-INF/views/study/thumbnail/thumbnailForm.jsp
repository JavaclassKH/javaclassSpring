<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thumbnailForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	// 썸네일 만들기
	function fCheck() {
	 	let file = document.getElementById("file").value;
   	let ext = file.substring(file.lastIndexOf(".") + 1).toLowerCase();
   	let maxSize = 1024 * 1024 * 20;	// 기본 단위 : Byte,   1024 * 1024 * 20 = 20MByte 허용
   	
  	if(file.trim() == "") {
   		alert("올릴 파일 골라라");
   		return false;
   	}
   	
   	let fileSize = document.getElementById("file").files[0].size;
   	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip') {
   		alert("업로드 가능한 파일은 'jpg/gif/png/zip'만 가능합니다.");
   	}
   	if(fileSize > maxSize) {
   		alert("업로드 파일의 최대용량은 20MByte입니다.");
   		return false;
   	}
    
   	let formData = new FormData();
   	formData.append("file", document.getElementById("file").files[0]);
   	
	}
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h1 class="text-center text-muted"><b>Thumbnail 연습</b></h1><br/>
	<form name="myform" method="post" enctype="multipart/form-data">
		<p> fileName
			<input type="file" name="file" id="file" class="form-control-file bordered" accept=".jpg, .png, .gif, .jpeg, .tiff" />
		</p><br/>
		<p>
			<input type="button" value="썸네일만들기" onclick="fCheck()" class="btn btn-success form-control mb-4" />
			<input type="reset" value="재선택" class="btn btn-warning form-control mb-4" />
			<input type="button" value="썸네일리스트" onclick="location.href='#';" class="btn btn-primary form-control" />
		</p>
	</form><br/><hr/><br/>
	<div id="demo"></div>
<br/><br/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

