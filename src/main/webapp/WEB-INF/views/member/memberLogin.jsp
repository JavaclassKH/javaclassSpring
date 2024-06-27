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
	<style>
		table {
			border-radius: 3px;
		}
		
		.table {
			border-radius: 3px;
		}		
	
	</style>
<script>
	'use strict';
	
	$(document).ready(function(){
		$("#SearchPassword").hide();
	});
	
	function pwdSearch() {
		$("#SearchPassword").show();
	}
	
	// 비밀번호 재발급
	function newPassword() {
		let mid = $("#midSearch").val();
		let email = $("#emailSearch").val();
		
		if(mid.trim() == "" || email.trim() == "") {
			alert("가입하신 아이디와 이메일을 입력하세요!");
			$("#midSearch").focus();
			return false;
		}
		
		$.ajax({
			url : "${ctp}/member/memberNewPassword",
			type : "post",
			data : {
				mid : mid,
				email : email
			},
			success:function(res){
				if(res != "0") {
					alert("임시비밀번호가 메일로 발송되었습니다\n발급된 임시 비밀번호로 로그인하신 뒤\n즉시 비밀번호를 변경해주세요");
				}
				else {
					alert("입력하신 정보가 없습니다!");
				}
			},
			error:function(){
				alert("전 송 오 류");
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
  <form name="myform" method="post">
    <table class="table table-bordered border-radius text-center">
      <tr class="table table-warning">
        <td colspan="2"><font size="10em"><b>Login into site</b></font></td>
      </tr>
      <tr>
        <th>ID</th>
        <td><input type="text" name="mid" value="${mid}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>password</th>
        <td><input type="password" name="pwd" value="1234" required class="form-control" /></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="login" class="btn btn-outline-success mr-2"/>
          <input type="reset" value="reset" class="btn btn-outline-warning mr-2"/>
          <input type="button" value="join" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary mr-2"/>
        </td>
      </tr>
    </table>
    <table class="table table-borderless p-0">
    	<tr>
    		<td class="text-center">
	    		<input type="checkbox" name="idSave" checked /> idSave &nbsp;&nbsp;&nbsp;
	    		[<a href="javascript:midSearch()">findUserid</a>] &nbsp;&nbsp;/&nbsp;&nbsp;     			
	    		[<a href="javascript:pwdSearch()">findPassword</a>]    			
    		</td>
    	</tr>
    </table><br/>
    <div id="SearchPassword">
    	<table class="table table-borderp-0 text-center">
    		<tr>
    			<td colspan="2" class="text-center">
    				<font size="4"><strong>Find Password</strong></font>(put your ID and email when you join us)
    			</td>
    		</tr>
    		<tr>
    			<th>ID</th>
					<td>
						<input type="text" name="midSearch" id="midSearch" placeholder="ID plz" class="form-control" autofocus />
					</td>
    		</tr>
    		<tr>
    			<th>email</th>
					<td>
						<input type="text" name="emailSearch" id="emailSearch" placeholder="email plz" class="form-control" />
					</td>
    		</tr>
    		<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="resetPassword" onclick="newPassword()" class="btn btn-info form-control" />
					</td>
    		</tr>
    	</table>
    </div>
  </form>
</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>