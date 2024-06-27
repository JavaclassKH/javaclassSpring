<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>boardInput.jsp</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
	<h2 class="text-center mb-4"><b>W r i t e</b></h2>
		<form name="myform" method="post">
			<table class="table table-bordered">
				<tr>
					<th>writer</th>
					<td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control" /></td>
				</tr>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" placeholder="enter title" autofocus class="form-control" required /></td>
				</tr>
				<tr>
					<th>content</th>
	        <td><textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
	        <script>
	          CKEDITOR.replace("content",{
	        	  height:480,
	        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
	        	  uploadUrl:"${ctp}/imageUpload"             /* uploadUrl : 여러개의 그림파일을 드래그&드롭으로 올릴 수 있다 */
	        	  
	          });
	        </script>
				</tr>
				<tr>
					<th>isOpen</th>
					<td>
					open &nbsp;&nbsp;<input type="radio" name="openSw" title="openSw" id="openSw1" value="OK" checked /> &nbsp;&nbsp;
					close &nbsp;&nbsp;<input type="radio" name="openSw" title="openSw" id="openSw2" value="NO" />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="submit" class="btn btn-primary btn-sm mr-2" />
						<input type="reset" value="reset" class="btn btn-warning btn-sm mr-2" />
						<input type="button" value="back" onclick="location.href='boardList';" class="btn btn-danger btn-sm" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}" />
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}">
		</form>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>