<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbtestList.jsp(조회,입력,삭제,수정)</title>
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
    	
    	location.href = "${ctp}/dbtest/dbtestDelete?idx="+idx;
    }
    
    // 회원정보찾기
    function idSearch() {
    	let mid = document.getElementById("idSearch").value;
    	if(mid.trim() == "") {
    		alert("검색할 아이디를 입력하세요");
    		return false;
    	}
    	location.href = "${ctp}/dbtest/dbtestSearch/"+mid;
    }
    
    // 회원정보수정란 띄우기
    function updateCheck(idx) {
    	$(".userRow").hide();
    	$("#updateBtn"+idx).hide();
    	$("#row"+idx).show();
    }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = document.getElementById("mid").value;
    	let url = "${ctp}/dbtest/dbtestIdCheck?mid="+mid;
    	
    	window.open(url, "dbtestWindow", "width=500px,height=250px");
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
    <form name="myform" method="post" action="${ctp}/dbtest/dbtestInputOk">
      <table class="table table-bordered text-center">
        <tr>
          <th>ID</th>
          <td>
          	<div class="input-group">
	          	<input type="text" name="mid" id="mid" value="atom1234" class="form-control" />
	          	<div class="input-group-append">
	          		<input type="button" style="border-radius: 5px;" value="idCheck" onclick="idCheck()" class="btn btn-light" />
	          	</div>
          	</div>
          </td>
        </tr>
        <tr>
          <th>name</th>
          <td><input type="text" name="name" value="atom" class="form-control" /></td>
        </tr>
        <tr>
          <th>age</th>
          <td><input type="number" name="age" value="20" class="form-control" /></td>
        </tr>
        <tr>
          <th>address</th>
          <td><input type="text" name="address" value="서울" class="form-control" /></td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="submit" value="join" class="btn btn-success mt-3" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" value="reset" class="btn btn-warning mt-3" />
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
          <a href="javascript:updateCheck(${vo.idx})" id="updateBtn${vo.idx}" class="badge badge-info">Update</a>
        </td>
      </tr>
      <tr class="userRow" id="row${vo.idx}" style="display:none">
	      <form name="myform${vo.idx}" method="post" action="${ctp}/dbtest/dbtestUpdateOk">
	        <td>${vo.idx}</td>
	        <td><input type="text" name="mid" value="${vo.mid}" id="mid${vo.idx}" class="form-control"></td>
	        <td><input type="text" name="name" value="${vo.name}" id="name${vo.name}" class="form-control"></td>
	        <td><input type="number" name="age" value="${vo.age}" id="age${vo.age}" class="form-control"></td>
	        <td><input type="text" name="address" value="${vo.address}" id="address${vo.address}" class="form-control"></td>
	        <td><input type="submit" value="Update" class="btn btn-secondary btn-sm"/></td>
	        <input type="hidden" name="idx" value="${vo.idx}" />
	      </form>
      </tr>
    </c:forEach>
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <div class="row">
  	<div class="col"><a href="${ctp}/" class="btn btn-warning">back</a></div>
  	<div class="col text-right">
  	  <div class="input-group">
  	    <div class="input-group-prepend"><span class="input-group-text">idSearch</span></div>
  	    <input type="text" name="idSearch" id="idSearch" placeholder="put ID to search" class="form-control"/>
  	  	<div class="input-group-append"><button type="button" onclick="idSearch()" class="btn btn-info">Search</button></div>
  	  </div>
  	</div>
  </div>
  <br/>
  <c:if test="${!empty searchVos}">
    <hr/>
    <h4 class="text-center">Search Result</h4>
    <table class="table table-hover text-center">
      <tr class="table-secondary">
	      <th>no</th>
	      <th>ID</th>
	      <th>name</th>
	      <th>age</th>
	      <th>address</th>
	    </tr>
	    <c:forEach var="vo" items="${searchVos}" varStatus="st">
	      <tr>
	        <td>${vo.idx}</td>
	        <td>${vo.mid}</td>
	        <td>${vo.name}</td>
	        <td>${vo.age}</td>
	        <td>${vo.address}</td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="6" class="m-0 p-0"></td></tr>
	  </table>
    <div class="text-right">
      <input type="button" value="close" onclick="location.href='userList';" class="btn btn-success"/>
    </div>
  </c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>