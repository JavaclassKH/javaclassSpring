<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("nl", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>guestList2.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'ues strict';
		
		function delCheck(idx) {
			let ans = confirm("삭제하시겠습니까?");		
			if(ans) {
				location.href="${ctp}/GuestDelete?idx="+idx;
				return false;
			}			
		}
		
		function w3school() {
		 	let ans = confirm("후회하지 않을 자신 있으신가요??"); 
		 	if(ans) {
		 		alert("공부하세요");
				window.open('about:blank').location.href="https://www.w3schools.com";
		 	}	
		 	else {
		 		alert("그래도 공부하세요");		 
		 		window.open('about:blank').location.href="https://www.w3schools.com";
		 	}
		}	
		
		function pageSizeChange() {
			let pageSizeChange = document.getElementById("pageSizeChange").value;
			location.href = "${ctp}/GuestList?pageSize="+pageSizeChange+"&pag="+${pag};
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
	<div class="container">
		<h2 class="text-center">Guest book page</h2>
			<table class="table table-borderless m-0 p-0">
			<tr>
				<!-- <td><a href="" class="btn btn-info">관리자전용</a></td> -->
				<td class="text-right">
					<button class="btn btn-danger" onclick="w3school()">
					  <span class="spinner-border spinner-border-sm"></span>don't click!
					</button>
				</td>
				<td><a href="${ctp}/guest/guestInput.jsp" class="btn btn-success">Write</a></td>
				<td class="text-right"> 
				<span class="mr-15">this Page : ${pag} / Next page :  ${totPage}</span>
				<c:if test="${pag > 1}"> 
					<a href="${ctp}/GuestList?pag=1" class="btn btn-info btn-sm"><span class="spinner-border spinner-border-sm"></span>First Page</a>
					<a href="${ctp}/GuestList?pag=${pag - 1}" class="btn btn-outline-info ml-4 mr-1">front</a>
				</c:if>
				<c:if test="${pag < totPage}">
					<a href="${ctp}/GuestList?pag=${pag + 1}"  class="btn btn-outline-info ml-1 mr-4">behind</a>	
					<a href="${ctp}/GuestList?pag=${totPage}" class="btn btn-info btn-sm"><span class="spinner-border spinner-border-sm"></span>Last page</a>	
				</c:if>
				</td>
				<tr>
					<td colspan="2" class="text-right">
						<select name="pageSize" id="pageSizeChange" onchange="pageSizeChange()">
							<option value="5"><c:if test="${pageSize != 5} ">selected</c:if>5</option>
							<option value="10"><c:if test="${pageSize != 10} ">selected</c:if>10</option>
							<option value="15"><c:if test="${pageSize != 15} ">selected</c:if>15</option>
						</select>
					</td>
				</tr>
				<td></td>
			</tr>
			</table>
			<c:set var="no" value="${fn:length(vos)}" />
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<table class="table table-bordered">
				<tr>
					<th class="col-2">No.${curScrStartNo}
					<c:if test="${sAdmin == 'OK' || sName == vo.name}">
						<a href="javascript:delCheck(${vo.idx})" class="btn btn-outline-danger ml-2">Delete</a></th>									
					</c:if>			
						<td class="text-right row-2 pr-5"><b><font color="darkred">Writerip : ${vo.hostIp}</font></b></td>	
				</tr> 
				<tr>
					<th class="table-primary">name</th>
					<td>
			<%-- 		<c:if test="${vo.hostIp == '192.168.50.20'}">선생님 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.51'}">이수연 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.52'}">김성현 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.53'}">최민영 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.54'}">윤서경 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.55'}">성민지 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.57'}">조현서 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.58'}">안소은 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.59'}">탁민아 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.60'}">이규희 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.61'}">심지언 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.63'}">김도완 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.64'}">관리자</c:if>
					<c:if test="${vo.hostIp == '192.168.50.66'}">김한나 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.68'}">박영서 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.69'}">배민재 : ${vo.name}</c:if>
					<c:if test="${vo.hostIp == '192.168.50.70'}">김은하 : ${vo.name}</c:if>
					
					<c:if test="${vo.hostIp != '192.168.50.20' && vo.hostIp != '192.168.50.51' &&
					vo.hostIp != '192.168.50.52' && vo.hostIp != '192.168.50.53' && vo.hostIp != '192.168.50.54' &&
					vo.hostIp != '192.168.50.55' && vo.hostIp != '192.168.50.57' && vo.hostIp != '192.168.50.58' &&
					vo.hostIp != '192.168.50.59' && vo.hostIp != '192.168.50.60' && vo.hostIp != '192.168.50.61' &&
					vo.hostIp != '192.168.50.63' && vo.hostIp != '192.168.50.64' && vo.hostIp != '192.168.50.66' &&
					vo.hostIp != '192.168.50.68' && vo.hostIp != '192.168.50.69' && vo.hostIp != '192.168.50.70'}">${vo.name}</c:if> --%>
					${vo.name}
					</td>
					</tr>
					<tr>
					<th class="table-success">visitDatr</th>
					<td>${fn:substring(vo.visitDate, 0, 19)}</td>
				</tr>
				<tr>
					<th class="table-secondary">email Address</th>
					<td colspan="3">
						<%-- <c:if test="${vo.email == '' || vo.email == null}">없음</c:if> 
						 <c:if test="${vo.email != '' && vo.email != null}">${vo.email}</c:if> --%>
						<c:if test="${empty vo.email || fn:length(vo.email) < 6 || fn:indexOf(vo.email, '@') == -1 || fn:indexOf(vo.email, '.') == -1}">없음</c:if>
						<c:if test="${!empty vo.email && fn:length(vo.email) >= 6 && fn:indexOf(vo.email, '@') != -1 && fn:indexOf(vo.email, '.') != -1}">${vo.email}</c:if>
					</td>
				</tr>
				<tr>
					<th class="table-warning">link</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage) < 10 || fn:indexOf(vo.homePage, '.') == -1}">없음</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage) >= 10 && fn:indexOf(vo.homePage, '.') != -1}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
					</td>
				</tr>
				<tr>
					<th class="table-danger">visit impression</th>
					<td colspan="3">${fn:replace(vo.content, nl ,"<br/>")}</td>
				</tr>
			</table>		
			<br/>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		</c:forEach>
		<p><br/></p>
		<br/>
		<!-- 블럭페이지 시작!! -->
		<div class="text-center">
			<c:if test="${pag > 1}"><a href="${ctp}/GuestList?pag=1&pageSize=${pageSize}" class="mr-2">First</a></c:if>
			<c:if test="${curBlock > 0}"><a href="${ctp}/GuestList?pag=${((curBlock-1) * blockSize)  + 1}&pageSize=${pageSize}">Before</a></c:if>		
				<c:forEach var="i" begin="${(curBlock*blockSize) + 1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
					<c:if test="${i <= totPage && i == pag}"><strong><a href="${ctp}/GuestList?pag=${i}&pageSize=${pageSize}">[${i}]</a></strong></c:if>
					<c:if test="${i <= totPage && i != pag}"><a href="${ctp}/GuestList?pag=${i}&pageSize=${pageSize}">[${i}]</a></c:if>
				</c:forEach>
			<c:if test="${curBlock < lastBlock}"><a href="${ctp}/GuestList?pag=${(curBlock + 1) * blockSize + 1}&pageSize=${pageSize}">After</a></c:if>		
			<c:if test="${pag < totPage}"><a href="${ctp}/GuestList?pag=${totPage}&pageSize=${pageSize}" class="ml-2">Last</a></c:if>
		</div>
		<!-- 블럭페이지 끝!! -->
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>