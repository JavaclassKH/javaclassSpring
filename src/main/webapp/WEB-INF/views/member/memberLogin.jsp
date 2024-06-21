<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberLogin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/MemberLoginOk.mem">
    <table class="table table-bordered border-radius text-center">
      <tr class="table table-warning">
        <td colspan="2"><font size="10em"><b>로&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 그&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 인</b></font></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" value="${mid}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" value="1234" required class="form-control" /></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="로그인" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="회원가입" onclick="location.href='${ctp}/MemberJoin.mem';" class="btn btn-primary mr-4"/>
	    		<input type="checkbox" name="idSave" checked /> 아이디 저장
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>