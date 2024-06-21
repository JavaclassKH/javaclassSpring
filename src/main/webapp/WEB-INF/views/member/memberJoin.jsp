<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src = "${ctp}/js/woo.js"></script>
  <script>
    'use strict';
	    let idCheckSw = 0;
	    let nickCheckSw = 1;
    
 	   	function fCheck() {
	    
		    let email1 = myform.email1.value.trim();
		    let email2 = myform.email2.value;
		    let email = email1 + "@" + email2;
		    
		    let tel1 = myform.tel1.value;
		    let tel2 = myform.tel2.value.trim();
		    let tel3 = myform.tel3.value.trim();
		    let tel = tel1 + "-" + tel2 + "-" + tel3;
		    
		    
		    
		    
		    /*
				 // 전송전에 파일에 관련된 사항들을 체크해준다.
					let fName = document.getElementById("file").value;
					if(fName.trim() != "") {
						let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
						let maxSize = 1024 * 1024 * 5;
						let fileSize = document.getElementById("file").files[0].size;
						
						if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
							alert("그림파일만 업로드 가능합니다.");
							return false;
						}
						else if(fileSize > maxSize) {
							alert("업로드할 파일의 최대용량은 5MByte입니다.");
							return false;
						}
					}
					else return false;		
				*/
		    
				
				
				
		    let postcode = myform.postcode.value + " ";   
		    let roadAddress = myform.roadAddress.value + " ";   
		    let detailAddress = myform.detailAddress.value + " ";   
		    let extraAddress = myform.extraAddress.value + "  ";   
		    let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
		    
	    	// 유효성 검사.....
	    	// 정규식을 이용한 유효성 검사..
	    	
	    	
	    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
	    	
	    	
	    	
	    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
	    	
	    	// 전화번호 형식 체크
	    	if(tel2 != "" && tel3 != "") {
	    		// 전화번호형식인지 정규식으로 체크
	    	}
	    	else {
	    		tel2 = "  ";
	    		tel3 = "  ";
	    		tel = tel1 + "-" + tel2 + "-" + tel3;
	    	}
				
	    	if(idCheckSw == 0) {
	    		alert("아이디 중복체크를 시행해주세요");
	    		document.getElementById("midBtn").focus();
	    	} 
	    	else if(nickCheckSw == 0) {    		
	    		alert("닉네임 중복체크를 시행해주세요");
	    		document.getElementById("nickNameBtn").focus();
	    	}
	    	else {
	    		myform.email.value = email;
	    		myform.tel.value = tel;
	    		myform.address.value = address;
	    		
	    		myform.submit();
	    	}
   	 }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == ""){
    		alert("아이디를 입력하세요");
    		myform.mid.focus();
    	}
    	else{
	    	$.ajax({
					url : "${ctp}/member/memberIdCheck",
					type : "get",
					data : { mid : mid },
					success : function(res) {
						if(res == 1) {
							alert("이미 사용중인 아이디입니다.");
							myform.mid.focus();
						}
						else {
							alert("사용 가능한 아이디입니다.");
							idCheckSw = 1;
						}
					},
					error : function() {
						alert("전송 오류");
					}
	    	});    		
    	}
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == ""){
    		alert("닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else{
	    	$.ajax({
					url : "${ctp}/member/memberNickCheck",
					type : "get",
					data : { nickName : nickName },
					success : function(res) {
						if(res == 1) {
							alert("이미 사용중인 닉네임입니다.");
							myform.mid.focus();
						}
						else {
							alert("사용 가능한 닉네임입니다.");
							nickCheckSw = 1;
						}
					},
					error : function() {
						alert("전송 오류");
					}
	    	});    		
    	}
    }
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
<!--   <form name="myform" method="post" class="was-validated" enctype="multipart/form-data"> -->
  <form name="myform" method="post" class="was-validated">
    <h2>회 원 가 입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-warning btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 </label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="nickName">닉네임  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-warning btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명 </label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 </span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
              <option value="850">북한</option>
            </select>-
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-2">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-2">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="homepage">Homepage address:</label>
      <input type="text" class="form-control" name="homePage" value="https://" placeholder="홈페이지를 입력하세요." id="homePage" />
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option>카지노환전상</option>
        <option>가상화폐투자자</option>
        <option>살인청부업자</option>
        <option>전문사기설계자</option>
        <option>조직폭력배</option>
        <option>마약판매상</option>
        <option>자동차딜러</option>
        <option>휴대폰판매자</option>
        <option selected>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
        </label>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) 
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-success mr-3" onclick="fCheck()">회원가입</button> &nbsp;&nbsp;&nbsp;
    <button type="reset" class="btn btn-warning mr-3">다시작성</button> &nbsp;&nbsp;&nbsp;
    <button type="button" class="btn btn-danger" onclick="location.href='${ctp}/member/memberLogin';">로그인</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>