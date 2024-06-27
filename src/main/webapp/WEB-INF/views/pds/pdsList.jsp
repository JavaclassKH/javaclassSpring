<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>pdsList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
 		function partCheck() {
			let part = $("#part").val();
			location.href="PdsList.pds?";
		} 
	
 		// 다운로드 수 증가
 		function downNumCheck(idx) {
			$.ajax({
				url : "${ctp}/pds/pdsDownNumCheck",
				type : "post",
				data : {idx , idx},
				success : function(res) {
					location.reload();
				},
				error : function() {
					alert("다운로드 수 증가 오류");
				}
			});
		}
 		
 		// 자료실 자료 삭제하기
 		function pdsDeleteCheck(idx, fSName) {
 			let ans = confirm("선택하신 자료를 삭제하시겠습니까?");
 			if(!ans) return;
 			
 			$.ajax({
 				url : "${ctp}/pds/pdsDeleteCheck",
 				type: "post",
 				data : {
 					idx : idx,
 					fSName : fSName
 				},
 				success : function(res) {
 					if(res != "0") {
						alert("자료가 성공적으로 삭제되었습니다"); 						
 						location.reload(); 
 					}
 					else {
						alert("자료 삭제에 실패했습니다."); 						 						
 					}
 				},
 				error : function() {
					alert("전송오류");
				},
 			});
 		}
 		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h1 class="text-center">자 료 실 리 스 트 (${pageVO.part})</h1>
		<br/>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td>
					<form name="partForm">
						<select name="part" id="part" onchange="partCheck()">
							<option ${part == "전체" ? "selected" : ""}>전체</option>
							<option ${part == "학습" ? "selected" : ""}>학습</option>
							<option ${part == "여행" ? "selected" : ""}>여행</option>
							<option ${part == "음식" ? "selected" : ""}>음식</option>
							<option ${part == "기타" ? "selected" : ""}>기타</option>
						</select>
					</form>
				</td>
				<td class="text-right">
					<a href="${ctp}/pds/pdsInput?part=${pageVO.part}" class="badge bg-success"><font color="navy">자료올리기</font></a>
				</td>
			</tr>
		</table>
		 <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>분류</th>
      <th>파일명(크기)</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <a href="pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${pageVO.part}">${vo.title}</a>
	        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
        </td>
        <td>
          ${vo.nickName}
        </td>
        <td>
          ${vo.date_diff == 0 ? fn:substring(vo.FDate,11,19) : fn:substring(vo.FDate,0,10)}
        </td>
        <td>${vo.part}</td>
        <td>
          <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
          <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
          <c:forEach var="fName" items="${fNames}" varStatus="st">
            <a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
          </c:forEach>
          (<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
        </td>
        <td>${vo.downNum}</td>
        <td>
          <c:if test="${vo.mid == sMid || sLevel == 0}">
            <a href="javascript:pdsDeleteCheck('${vo.idx}','${vo.FSName}')" class="badge badge-danger">삭제</a><br/>
          </c:if>
          <a href="${stp}/pds/pdsTotalDown?idx=${vo.idx}" class="badge badge-primary">전체파일다운</a>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
	</div>
<p><br/></p>
	<!-- 블록페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
		    <c:if test="${i <= pageVO.totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVO.totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/PdsList?part=${pageVO.part}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

<!-- 

  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>분류</th>
      <th>파일명(크기)</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <a href="pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${pageVO.part}">${vo.title}</a>
	        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
        </td>
        <td>
          ${vo.nickName}
        </td>
        <td>
          ${vo.date_diff == 0 ? fn:substring(vo.FDate,11,19) : fn:substring(vo.FDate,0,10)}
        </td>
        <td>${vo.part}</td>
        <td>
          <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
          <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
          <c:forEach var="fName" items="${fNames}" varStatus="st">
            <a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
          </c:forEach>
          (<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
        </td>
        <td>${vo.downNum}</td>
        <td>
          <c:if test="${vo.mid == sMid || sLevel == 0}">
            <a href="javascript:pdsDeleteCheck('${vo.idx}','${vo.FSName}')" class="badge badge-danger">삭제</a><br/>
          </c:if>
          <a href="PdsTotalDown.pds?idx=${vo.idx}" class="badge badge-primary">전체파일다운</a>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
  
  		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>자료제목</th>
				<th>게시자</th>
				<th>게시일자</th>
				<th>자료분류</th>
				<th>파일명(크기)</th>
				<th>다운로드 수</th>
				<th>비고</th>
			</tr>
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${curScrStartNo}</td>
					<td>
						<a href="pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${vo.part}">${vo.title}</a>
						<c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</td>
					<td>${vo.nickName}</td>
					<td>
					${vo.date_diff == 0 ? fn:substring(vo.FDate,10,19) : fn:substring(vo.FDate,0,10)}
					</td>
					<td>${vo.part}</td>
					<td>
						<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
						<c:set var="fSNames" value="${fn:split(vo.FSName, '/')}" />
						<c:forEach var="fName" items="${fNames}" varStatus="st">
							<a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
						</c:forEach>
						(<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
					</td>
					<td>${vo.downNum}</td>
					<td>
						<c:if test="${vo.mid == sMid || sLevel == 0}">
							<a href="javascript:pdsDeleteCheck(${vo.idx},'${vo.FSName}')" class="badge bg-danger"><font color="black">삭제</font></a><br/>
						</c:if>
						<a href="pdsTotalDown?idx=${vo.idx}" class="badge bg-primary"><font color="black">전체다운로드</font></a>
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			</c:forEach>
		 	<tr><td colspan="9" class="m-0 p-0"></td></tr> 
		</table>
  
 -->