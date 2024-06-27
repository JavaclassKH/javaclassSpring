<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>pdsInput.jsp</title>
		<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<script>
	'use strict';
    let cnt = 1;
    
    function fCheck() {
    	let fName = document.getElementById("fName").value;
    	let title = $("#title").val();
    	let ext = "";
    	let fileSize = 0;
    	let maxSize = 1024 * 1024 * 20;	// 기본 단위 : Byte,   1024 * 1024 * 20 = 20MByte 허용
    	
    	let fileLength = document.getElementById("fName").files.length;	// 선택한 파일의 갯수
    	if(fileLength < 1) {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	else if(title.trim() == "") {
    		alert("제목을 입력하세요.");
    		return false;
    	}
    	
    	for(let i=0; i<fileLength; i++) {
    		fName = document.getElementById("fName").files[i].name;		// 선택된 1개의 파일이름가져오기
    		ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	fileSize = document.getElementById("fName").files[i].size;
	    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip') {
	    		alert("업로드 가능한 파일은 'jpg/gif/png/zip'만 가능합니다.");
	    	}
    	}
    	
    	if(fileSize > maxSize) {
    		alert("업로드 파일의 최대용량은 20MByte입니다.");
    	}
    	else {
	    	myform.fSize.value = fileSize;
    		myform.submit();
    	}
    }
		
		// 파일박스 추가 (동적폼)
		function fileBoxAppend() {
			cnt++;
			let fileBox = '';
			fileBox += '<div id="fileBox'+cnt+'">';
			fileBox += '<input type="file" name="fName'+cnt+'" id="file'+cnt+'" class="form-control file border mb-2" style="float:left; width:85%;" />';
			fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger mb-2 ml-2" style="width:10%;" />';
			fileBox += '</div>';
			$("#fileBox").append(fileBox); 
		}
	
		// 파일박스 삭제
		function deleteBox(cnt) {
			$("#fileBox"+cnt).remove();
			cnt--;
		}
		
	
</script>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h1 class="text-center mb-5">자 료 업 로 드 페 이 지</h1>
		<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
			<br/>
			<div>
				<input type="button" value="파박추가" onclick="fileBoxAppend()" class="btn btn-info mb-2" />					
				<input type="file" name="file" id="fName" class="form-control-file border mb-2 p-2" multiple />
			</div>
			<div id="fileBox"></div>
			<div class="mb-2 mt-1">
				게시자 ${sNickName}
			</div>
			<div class="mb-2 mt-1">
				제목  <input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요" class="form-control" required />
			</div>
			<div class="mb-2">
				내용 <textarea rows="5" name="content" id="content" placeholder="자료의 설명을 입력하세요" style="resize: none;" class="form-control"></textarea>
			</div>
			<div class="mb-2">
				분류 <select name="part" id="part" class="form-control">
					<option ${part == "전체" ? "selected" : ""}>전체</option>
					<option ${part == "학습" ? "selected" : ""}>학습</option>
					<option ${part == "여행" ? "selected" : ""}>여행</option>
					<option ${part == "음식" ? "selected" : ""}>음식</option>
					<option ${part == "기타" ? "selected" : ""}>기타</option>
				</select>
			</div>
			<div class="mb-2">
				공개여부&nbsp;&nbsp;&nbsp;
				공개&nbsp;&nbsp; <input type="radio" name="openSw" onclick="pwdCheckClose()" value="공개" class="mr-2" checked />
				비공개&nbsp;&nbsp; <input type="radio" name="openSw" onclick="pwdCheckOpen()" value="비공개" />
				<div id="pwdDemo" style="display:none; width:200px" class="mt-2">
					다운로드 전용 비밀번호
					<input type="password" name="pwd" id="pwd" />
				</div>
			</div>			
			<br/>
			<div> 
				<input type="button" value="자료올리기" onclick="fCheck()" class="btn btn-success mr-1" />
				<input type="reset" value="다시작성" class="btn btn-warning mr-1" />
				<input type="button" value="돌아가기" onclick="location.href='PdsLists.pds?part=${part}';" class="btn btn-info" />
			</div>
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
			<input type="hidden" name="mid" value="${sMid}" />
			<input type="hidden" name="nickName" value="${sNickName}" />
			<input type="hidden" name="fSize" value="0" />
		</form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>