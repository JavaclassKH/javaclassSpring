<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mailForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	th {
		background-color: #efe;
		vertical-align: middle;
		text-align: center;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>메 일 보 내 기</h2>
	<p>받는 사람의 메일주소를 정확히 입력해 주세요.</p>
	<div>
		<form name="mf" method="post">
			<table class="table table-border">
				<tr>
					<th>받는사람</th>
					<td>
						<div class="input-group">
							<input type="text" name="toMail" placeholder="받으실 분의 메일 주소를 입력하세요" class="form-control" autofocus required />
							<div class="input-group-append">
								<input type="button" value="주소록" onclick="javascript:alert('주소록No');" class="btn btn-info form-control" />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>메일제목</th>
					<td><input type="text" name="title" placeholder="제목을 입력하세요" class="form-control" required /></td>
				</tr>
				<tr>
					<th>메일내용</th>
					<td>
						<textarea rows="6" name="content" placeholder="메일 내용을 입력하세요" class="form-control" required>메일 내용을 입력하세요</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="보내기" class="btn btn-success form-control mt-2" />
						<input type="reset" value="다시쓰기" class="btn btn-warning mt-2" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

