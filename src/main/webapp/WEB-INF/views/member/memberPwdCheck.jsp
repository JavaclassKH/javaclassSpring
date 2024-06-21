<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberPwdCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
		  $(function(){
		    	$("#pwdDemo").hide();
		    });
		    
		    function pwdReCheck() {
		    	let pwd = $("#pwd").val().trim();
		    	if(pwd == "") {
		    		alert("현재 비밀번호를 입력하세요!");
		    		$("#pwd").focus();
		    		return false;
		    	}
		    	$.ajax({
		    		url  : "MemberPwdCheckAjax.mem",
		    		type : "post",
		    		data : {pwd : pwd},
		    		success:function(res) {
		    			if(res != "0") $("#pwdDemo").show();
		    			else alert("비밀번호가 틀립니다. 확인해주세요");
		    		},
		    		error : function() {
		    			alert("전송오류!");
		    		}
		    	});
		    }
	
		function pwdChangeCheck() {
			let pwdCheck = $("#pwdCheck").val();
			let pwdCheckRe = $("#pwdCheckRe").val();
			
			if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "" ) {
				alert("변경할 비밀번호를 입력하세요");
				$("#pwdCheck").focus();
				return false;
			}
			else if(pwdCheck.trim() != pwdCheckRe.trim()) {
				alert("확인 비밀번호가 틀립니다");
				$("#pwdCheck").focus();			
				return false;			
			}
			else {
				pwdForm.submit();
			}
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<script> alert("개인정보 수정은 신중하게 해주시길 바랍니다."); </script>
	<div class="container">
		<div>
			<h1 class="text-center"><b>개 인 정 보 수 정 화 면</b></h1>
			<form name="myform" method="post" action="MemberPwdCheckOk.mem">
				<table class="table table-bordered table-warning text-center">
					<tr>
						<th colspan="2">
							<h3>비밀번호 확인</h3>
							<div>(회원정보 수정을 위해 비밀번호를 한번 더 확인합니다)</div>
						</th>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="비밀번호수정" onclick="pwdReCheck()" class="btn btn-warning pt-2 mr-3" />
							<input type="submit" value="회원정보수정" class="btn btn-success pt-2 mr-3" />
							<input type="reset" value="다시입력" onclick="pwdReCheck()" class="btn btn-danger pt-2 mr-3" />
							<input type="button" value="돌아가기" onclick="location.href='MemberMain.mem';" class="btn btn-primary pt-2 mr-3" />
						</td>
					</tr>
				</table>
				<p><br/></p>
			</form>
			<div id="pwdDemo">
				<form name="pwdForm" method="post" action="MemberPwdChangeCheck.mem">			
					<table class="table table-bordered table-info">
						<tr>
							<td class="text-left"> 변경할 비밀번호를 입력하세요 </td>
							<td><input type="password" name="pwdCheck" id="pwdCheck" class="form-control" /></td>
						</tr>
            <tr>
							<td class="text-left"> 비밀번호 확인 </td>
							<td><input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control" /></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="비밀번호변경하기" onclick="pwdChangeCheck()" class="btn btn-danger btn-sm" />
							</td>
						</tr>	
					</table>
				</form>
			</div>
		</div>	
	</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>