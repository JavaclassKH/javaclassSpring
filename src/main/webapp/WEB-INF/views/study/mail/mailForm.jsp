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
	<h2>Send Mail</h2>
	<p>Please enter the recipient's email address accurately.</p>
	<div>
		<form name="mf" method="post">
			<table class="table table-border">
				<tr>
					<th>recipient</th>
					<td>
						<div class="input-group">
							<input type="text" name="toMail" placeholder="enter the recipient's email address" class="form-control" autofocus required />
							<div class="input-group-append">
								<input type="button" value="address book" onclick="javascript:alert('주소록No');" class="btn btn-info form-control" />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>Mail Title</th>
					<td><input type="text" name="title" placeholder="enter title" class="form-control" required /></td>
				</tr>
				<tr>
					<th>Mail Content</th>
					<td>
						<textarea rows="6" name="content" placeholder="enter mail content" class="form-control" required></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="send" class="btn btn-success form-control mt-2" />
						<input type="reset" value="reset" class="btn btn-warning mt-2" />
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

