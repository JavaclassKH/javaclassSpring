<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
		$(function() {
			$("#userDisplay").hide();
			
			$("#userInfor").on("click", function() {	
 				if($("#userInfor").is(":checked")) {
 					$("#totalList").hide();
 					$("#userDisplay").show();
 				}
 				else { 
 					$("#totalList").show();
 					$("#userDisplay").hide();
 				}
			});
		});
	
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h1 class="text-center mb-2"><b><font size="14em">전&nbsp; 체&nbsp; 회&nbsp; 원&nbsp; 리&nbsp; 스&nbsp; 트&nbsp;</font></b></h1>
		<c:if test="${sLevel == 0}">
			<input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> &nbsp;비공개회원보기
		</c:if>
	<div class="totalList">
		<div>
			<table class="table table-hover">
				<tr class="text-dark table-warning text-center">
					<th>번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>성명</th>
					<th>생일</th>
					<th>성별</th>
					<th>직업</th>
					<th>취미</th>			
					<th>최종방문일</th>	
					<c:if test="${sLevel == 0}">		
					<th>오늘방문횟수</th>		
					<th>활동현황</th>	
					</c:if>
				</tr>			
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<c:if test="${vo.userInfor == '공개'}">
						<tr class="text-center">
							<td>${vo.idx}</td>
							<td><a href="MemberSearch.mem?mid=${vo.mid}" target="_blank">${vo.mid}</a></td>
							<td>${vo.nickName}</td>
							<td>${vo.name}</td>
							<td>${fn:substring(vo.birthday,0,10)}</td>
							<td>${vo.gender}</td>
							<td>${vo.job}</td>
							<td>${vo.hobby}</td>
							<td>${fn:substring(vo.lastDate,0,10)}</td>
							<c:if test="${sLevel == 0}">
							<td>${vo.todayCnt}</td>
							<td>
								<c:if test="${vo.userDel == 'OK'}"><font color="red"><b>탈퇴신청</b></font></c:if>
								<c:if test="${vo.userDel != 'OK'}"><b>정상활동</b></c:if>
							</td>
							</c:if>
						</tr>
					</c:if>
				</c:forEach>
				<tr><td colspan="11" class="m-0 p-0"></td></tr>
			</table>
			
			<br/><br/>
			
			<div id="userDisplay">
				<c:if test="${sLevel == 0}">
					<h2 class="text-center mb-4"><b><font size="12em"> 비 공 개 회 원 리 스 트 </font></b></h2>
					<h3 class="text-center mt-2"><b> 관 리 자 전 용 열 람 리 스 트</b></h3>
						<table class="table table-hover">
							<tr class="text-dark table-danger text-center">
								<th>번호</th>
								<th>아이디</th>
								<th>닉네임</th>
								<th>성명</th>
								<th>생일</th>
								<th>성별</th>
								<th>직업</th>
								<th>취미</th>			
								<th>최종방문일</th>		
								<c:if test="${sLevel == 0}">	
								<th>오늘방문횟수</th>			
								<th>활동현황</th>			
								</c:if>
							</tr>			
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<c:if test="${vo.userInfor == '비공개'}">
									<tr class="text-center">
										<td>${vo.idx}</td>
										<td><a href="MemberSearch.mem?mid=${vo.mid}" target="_blank">${vo.mid}</a></td>
										<td>${vo.nickName}</td>
										<td>${vo.name}</td>
										<td>${fn:substring(vo.birthday,0,10)}</td>
										<td>${vo.gender}</td>
										<td>${vo.job}</td>
										<td>${vo.hobby}</td>
										<td>${fn:substring(vo.lastDate,0,10)}</td>
										<c:if test="${sLevel == 0}">
										<td>${vo.todayCnt}</td>
										<td>
											<c:if test="${vo.userDel == 'OK'}"><font color="red"><b>탈퇴신청</b></font></c:if>
											<c:if test="${vo.userDel != 'OK'}"><b>정상활동</b></c:if>
										</td>
										</c:if>
									</tr>
							</c:if>
						</c:forEach>
						<tr><td colspan="11" class="m-0 p-0"></td></tr>
					</table>
				</c:if>
			</div>
		</div>
		</div>
	</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>