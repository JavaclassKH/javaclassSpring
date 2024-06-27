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
		    
		  function pwdCheck() {
		    	let pwd = $("#pwd").val().trim();
		    	if(pwd == "") {
		    		alert("현재 비밀번호를 입력하세요!");
		    		$("#pwd").focus();
		    		return false;
		    	}
		    	
		    	$.ajax({
		    		url  : "${ctp}/member/memberPwdCheck",
		    		type : "post",
		    		data : {
		    			pwd : pwd,
		    			mid : '${sMid}'
		    		},
		    		success:function(res) {
		    			if(res != "0") {
		    				if('${pwdFlag}' == 'p') {
		    					$("#pwdDemo").show();
		    					$("#pwdForm").hide();
		    				}
		    				else location.href = '${ctp}/member/memberUpdate';
		    			}
		    			else {
		    				alert("비밀번호가 틀립니다. 확인해주세요");
		    				$("#pwd").focus();
		    			}
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
			
			$.ajax({
				url : "${ctp}/member/memberPwdChangeOk",
				type : "post",
				data : {
					pwd : pwdCheck,
					mid : '${sMid}'	
				},
				success:function(res){
					if(res != "0") {
						alert("비밀번호가 변경되었습니다\n다시 로그인해주세요");
						location.href='${ctp}/member/memberLogout';
					}
				},
				error:function(){
					alert('오류');
				}
			});
			
			
			
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<script> 
		alert("Please be careful when modifying your personal information"); 
		</script>
	<div class="container">
		<div>
			<h1 class="text-center"><b>Info change form</b></h1>
			<form name="myform" id="pwdForm" method="post">
				<table class="table table-bordered table-warning text-center">
					<tr>
						<th colspan="2">
							<h3>Check Password</h3>
							<div>(Confirm your password once again to edit your membership information.)</div>
						</th>
					</tr>
					<tr>
						<td>password</td>
						<td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="button" value="passwordCheck" onclick="pwdCheck()" class="btn btn-warning pt-2 mr-3" />
							<input type="reset" value="reset" class="btn btn-danger pt-2 mr-3" />
							<input type="button" value="back" onclick="location.href='${ctp}/member/MemberMain';" class="btn btn-primary pt-2 mr-3" />
						</td>
					</tr>
				</table>
				<p><br/></p>
			</form>
			<div id="pwdDemo">
				<form name="pwdForm" method="post">			
					<table class="table table-bordered table-info">
						<tr>
							<td class="text-left"> enter password to change </td>
							<td><input type="password" name="pwdCheck" id="pwdCheck" class="form-control" /></td>
						</tr>
            <tr>
							<td class="text-left"> password Check </td>
							<td><input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control" /></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<input type="button" value="change" onclick="pwdChangeCheck()" class="btn btn-danger btn-sm" />
								<input type="reset" value="reset" class="btn btn-danger pt-2 mr-3" />
								<input type="button" value="back" onclick="location.href='${ctp}/member/MemberMain';" class="btn btn-primary pt-2 mr-3" />
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