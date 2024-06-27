<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fileUpload.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />

 <script>
    'use strict';
    
    function fCheck() {
    	let fName = document.getElementById("fName").value;
    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
    	let maxSize = 1024 * 1024 * 20;	// 한번에 업로드 최대용량은 20MByte
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("fName").files[0].size;
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 20MByte입니다.");
    	}
    	else if(ext != "jpg" && ext != "gif" && ext != "png" && ext != "zip" && ext != "ppt" && ext != "pptx" && ext != "hwp") {
    		alert("업로드 가능한 파일은 'jpg/gif/png/zip/ppt/pptx/hwp'파일 입니다.");
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 개별파일 삭제
    function fileDelete(file) {
    	let ans = confirm("선택파일을 삭제하시겠습니까?");
    	
    	if(!ans) return false;
    	
    	$.ajax({
    		url : "${ctp}/study/fileUpload/fileDelete",
    		type : "post",
    		data : {file : file},
    		success:function(res) {
    			if(res != "0") {
    				alert("선택하신 파일이 삭제되었습니다");
    				location.reload();
    			}
    			else alert("삭제실패");
    		},
    		error:function() {
    			alert("전송오류");
    		}
    	});
		}
    
    // 모든파일 삭제
    function fileDeleteAll() {
    	let ans = confirm("모든 파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url : "${ctp}/study/fileUpload/fileDeleteAll",
    		type : "post",
    		success:function(res) {
    			if(res != "0") {
    				alert("모든 파일이 삭제되었습니다");
    				location.reload();
    			}
    			else alert("삭제실패");
    		},
    		error:function() {
    			alert("전송오류");
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
	<h2 class="text-center"><strong><font color="red">File Upload Practice</font></strong></h2>
	<br/>
	<form name="myform" method="post" enctype="multipart/form-data">
		<p>
			Uploader 
			<c:if test="${!empty sMid}">
				<input type="text" name="mid" value="${sMid}" class="form-control" autofocus readonly />
			</c:if>
			<c:if test="${empty sMid}">
				<input type="text" name="mid" value="" class="form-control" autofocus  />
			</c:if>
		</p>
		<p>
			fileName  
			<input type="file" name="fName" id="fName" class="borderless form-control-file" accept=".jpg, .gif, .png, .zip, .ppt, .pptx, .hwp" />			
		</p>
		<div>			
			<input type="button" value="Upload" onclick="fCheck()" class="form-control btn btn-success mb-3" />			
			<input type="reset" value="rechoose" class="btn btn-warning mr-4" />			
			<input type="button" value="toMultiFileUpload" onclick="location.href='${ctp}/study/fileUpload/multiFile';" class="btn btn-primary mr-4" />
			<input type="button" value="toImageFileUpload" onclick="location.href='${ctp}/study/fileUpload/multiFile2';" class="btn btn-secondary mr-4" />
			<input type="button" value="deleteAll" onclick="fileDeleteAll()" class="btn btn-danger" />			
		</div>
	</form>
	<br/><hr/>
	<div id="downloadFile">
		<h3>FileInfo from server(total : ${fileCount} ea)</h3>
		<div class="row">
			<div class="col">
				<div class="col">Save route : ${ctp}/resources/data/fileUpload/*.*</div>
				<div class="col">
					<!-- 삭제 처리 -->
				</div>
			</div>
			<table class="table table-hover table-borderless text-center">
				<tr class="table-secondary">
					<th>No</th>
					<th>FileName</th>
					<th>FilePart</th>
					<th>note</th>
				</tr>
				<c:forEach var="file" items="${files}" varStatus="st">
					<tr>
						<td>${st.count}</td>
						<td>${file}</td>
						<td>
							<c:set var="fNameArr" value="${fn:split(file,'.')}" />	
							<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr) - 1])}" />
							<c:if test="${extName == 'zip'}">compressed file</c:if>
							<c:if test="${extName == 'ppt'}">powerpoint file</c:if>
							<c:if test="${extName == 'pptx'}">powerpoint file</c:if>
							<c:if test="${extName == 'hwp'}">hwp file</c:if>
							<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'|| extName == 'jpeg'}">
								<img src="${ctp}/fileUpload/${file}" width="160px" />
							</c:if>
						</td>
						<td>
							<input type="button" value="delete" onclick="fileDelete('${file}')" class="btn btn-danger mr-4" />
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

