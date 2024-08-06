<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>validatorForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      background-color: #def;
    }
  </style>
  <script>
    'use strict';
    
    $(document).ready(function(){
    	$("#btnShow").show();
    	$("#btnHide").hide();
    	$("#userInput").hide();
    	
    	$("#btnShow").click(function(){
    		$("#userInput").show();
	    	$("#btnShow").hide();
	    	$("#btnHide").show();
    	});
    	
    	$("#btnHide").click(function(){
    		$("#userInput").hide();
	    	$("#btnShow").show();
	    	$("#btnHide").hide();
    	});
    });
    
    // 회원정보삭제
    function deleteCheck(idx) {
    	let ans = confirm("선택하신 회원을 삭제처리 하시겠습니까?");
    	if(!ans) return false;
    	
    	location.href = "${ctp}/dbtest/dbtestDelete?tempFlag=validator&idx="+idx;
    }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = document.getElementById("mid").value;
    	let url = "${ctp}/dbtest/dbtestIdCheck?mid="+mid;
    	
    	window.open(url, "dbtestWindow", "width=500px, height=250px");
		}
    
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>MemberList</h2>
  <hr/>
  <div class="mb-2">
	  <input type="button" value="show" id="btnShow" class="badge badge-success" />
	  <input type="button" value="hide" id="btnHide" class="badge badge-primary" />
  </div>
  <div id="userInput">
    <form name="myform" method="post">
      <table class="table table-bordered text-center">
        <tr>
          <th>ID</th>
          <td>
          	<div class="input-group">
	          	<input type="text" name="mid" id="mid" class="form-control" />
	          	<div class="input-group-append">
	          		<input type="button" style="border-radius: 5px;" value="idCheck" onclick="javascript:alert('이거 쓸모없는 버튼임 ㅋ');" class="btn btn-light" />
	          	</div>
          	</div>
          </td>
        </tr>
        <tr>
          <th>name</th>
          <td><input type="text" name="name" class="form-control" /></td>
        </tr>
        <tr>
          <th>age</th>
          <td><input type="number" name="age" class="form-control" /></td>
        </tr>
        <tr>
          <th>address</th>
          <td><input type="text" name="address" class="form-control" /></td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="submit" value="join" class="btn btn-success mt-2" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" value="reset" class="btn btn-warning mt-2" />
          </td>
        </tr>
      </table>
    </form>
  </div>
  <table class="table table-hover text-center">
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
          <a href="javascript:deleteCheck(${vo.idx})" class="badge badge-danger">Delete</a>
        </td>
      </tr>
    </c:forEach>
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <div class="row">
  	<div class="col"><a href="${ctp}/" class="btn btn-warning btn-lg">back</a></div>
  </div><br/><hr/><br/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

