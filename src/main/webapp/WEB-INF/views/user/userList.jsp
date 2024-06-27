<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function deleteCheck(idx) {
		let ans = confirm("선택회원을 삭제하시겠습니까?");
		
		if(!ans) return false;
		else location.href='${ctp}/user/userDelete?idx='+idx;
	}
	
	$(document).ready(function(){
		$(".userInput").hide();
		$("#btnShow").show();
		$("#btnHide").hide();
		
		$("#btnShow").click(function(){
			$(".userInput").show();
			$("#btnShow").hide();
			$("#btnHide").show();
		});
		
		$("#btnHide").click(function(){
			$(".userInput").hide();
			$("#btnShow").show();
			$("#btnHide").hide();
		});
	});
	
	// 회원개별조회
	function userSearch() {
		let mid = myform.mid.value;
		
		if(mid.trim() == "") {
			alert("아이디를 입력하세요");
			$("#mid").focus();
			return false;
		}
		else {
			location.href="${ctp}/user/userSearch?mid="+mid;
		}		
	}
	
	$(document).ready(function(){
		$("SearchResult").hide();
		
		$("#btnUserSearch").click(function(){
			$("SearchResult").show();			
		});
	});
	
	// 회원정보수정
	function updateCheck() {
		let mid = updateForm.mid.value;
		let name = updateForm.name.value;
		let age = updateForm.age.value;
		let address = updateForm.address.value;
		
		if(mid.trim() == "" || name.trim() == "" || age.trim() == "" || address.trim() == "" ) {
			alert("빈칸 없이 입력해주세요");
			$("#mid").focus();
			return false;
		}
		else {
			updateForm.submit();
		}
	}
	
	// Modal에 idx 주입
	function idxGive(idx) {
		$("#idx").val(idx);
	}
	
	
	
</script>
</head>
<body>
<!-- navbar -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>Member List</h2>
	<hr/>
	<input type="button" id="btnShow" value="show" class="btn btn-primary mb-3 mr-2" />
	<input type="button" id="btnHide" value="hide" class="btn btn-primary mb-3" />
	<div class="userInput">
		<form name="myform" method="post" action="${ctp}/user/userInputOk">
			<table class="table table-hover">
				<tr>
					<th>ID</th>
					<td>
						<input type="text" name="mid" value="atom1234" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>name</th>
					<td>
						<input type="text" name="name" value="atomMan" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>age</th>
					<td>
						<input type="number" name="age" value="21" class="form-control" />
					</td>
				</tr>
				<tr>
					<th>address</th>
					<td>
						<input type="text" name="address" value="청주" class="form-control" />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="join" class="btn btn-success mr-3" />
						<input type="reset" value="reset" class="btn btn-warning mr-3" />
						<input type="button" id="btnUserSearch" value="partSearch" onclick="userSearch()" class="btn btn-info" />
					</td>
				</tr>
			</table>
		</form><br/>
	</div>
	<br/><br/><br/>
	<div class="SearchResult">
			<table class="table table-hover">
				<tr>
					<th>ID</th>
					<th>name</th>
					<th>age</th>
					<th>address</th>
				</tr>
				<tr>
					<td>${vo2.mid}</td>
					<td>${vo2.name}</td>
					<td>${vo2.age}</td>
					<td>${vo2.address}</td>
				</tr>
			</table>
		</div>
		<br/><br/><br/>
		<table class="table table-hover">
			<tr class="table-secondary">
				<th>no</th>
				<th>ID</th>
				<th>name</th>
				<th>age</th>
				<th>address</th>
				<th>note</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${vo.idx}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.age}</td>
					<td>${vo.address}</td>
					<td>
						<a href="javascript:deleteCheck('${vo.idx}')" class="btn btn-danger btn-sm">Delete</a>
						<button type="button" class="btn btn-primary btn-sm ml-3" onclick="idxGive('${vo.idx}')" data-toggle="modal" data-target="#myModal">MemberInfoUpdate</button>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="6" class="m-0 p-0"></td></tr>
		</table>
	<br/><hr/>
	<div class="text-center"><a href="${ctp}/" class="btn btn-warning btn-lg">back</a></div>
</div>
<p><br/></p>

<!-- 회원정보 수정 모달 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title text-center">MemberInfoUpdate</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
	      <form name="updateForm" method="get" action="${ctp}/user/userInfoUpdate">
	      	<div>
	      		<input type="hidden" name="idx" id="idx" class="form-control mb-3" readonly />
	      	</div>
					<div>
						ID <input type="text" name="mid" class="form-control mb-3" />
					</div>
					<div>
						name <input type="text" name="name" class="form-control mb-3" />
					</div>
					<div>
						age  <input type="number" name="age" class="form-control mb-3" />
					</div>
					<div>
						address <input type="text" name="address" class="form-control mb-3" />
					</div>
					<div>
						<input type="button" value="infoUpdate" onclick="updateCheck()" class="btn btn-dark" />
					</div>
	      </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

