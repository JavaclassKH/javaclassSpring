<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>multiFile2.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	.imgsWrap {
		border: 2px solid #efe;
		margin: 8px;
	}
	
	.imgsWrap img {
		max-width: 160px;
		margin: 4px;
	}
	
	.myBtn {
		width: 180px;
		padding: 10px;
		background-color: #08b;
		color: #fef;
		border-radius: 5px;
	}
</style>
<script>
  'use strict';
  
  let imgFiles = [];
    
  $(document).ready(function(){
  	$("#inputImgs").on("change", function(e){
  		//imgFiles = [];
  		$(".imgsWrap").empty();
  		
  		let files = e.target.files;
  		let filesArr = Array.prototype.slice.call(files);
  		
  		let idx = 0;
  		filesArr.forEach(function(f) {
  			if(!f.type.match("image.*")) {
  				alert("You can only Upload image files");
  				return false;
  			}
  			imgFiles.push(f);
  		
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			let str = "<a href='javascript:void(0);' onclick='deleteImage("+idx+")' id='imgId"+idx+"'><img src='"+e.target.result+"' data-file='"+f.name+"' class='' title='그림을 클릭하시면 제거됩니다.("+idx+")'/></a>";
	    			$(".imgsWrap").append(str);
	    			idx++;
	    		}
  			reader.readAsDataURL(f);
  		});
  	});
  });
  
  function deleteImage(idx) {
		imgFiles.slice(idx,1);
		
		let imgId = "#imgId"+idx;
		$(imgId).remove();
	}
    
  function imageUpload() {
		$("#inputImgs").trigger('click');
	}
  
  
  function fCheck() {
		if(imgFiles.length < 1) {
			alert("파일을 선택해주세요");
			return false;
		}
		
		let imgNames = "";
		for(let i=0; i<imgFiles.length; i++) {
			imgNames += imgFiles[i].name + "/";
		}
		imgNames = imgNames.substring(0, imgNames.length - 1);
		$("#imgNames").val(imgNames);
		
		myform.submit();
		
	}
  
    
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center"><strong><font color="red">Image File Upload Practice</font></strong></h2>
	<marquee scrolldelay="60" scrollamount="30" direction="down">marquee~~</marquee>
	<marquee scrolldelay="60" scrollamount="30" direction="up">marquee~~</marquee>
	<br/>
	<form name="myform" method="post" enctype="multipart/form-data">
		<a href="javascript:imageUpload()" class="badge badge-primary myBtn mb-2">load Image</a>
		<p class="mt-5">
			Uploader 
			<c:if test="${!empty sMid}">
				<input type="text" name="mid" value="${sMid}" class="form-control" autofocus readonly />
			</c:if>
			<c:if test="${empty sMid}">
				<input type="text" name="mid" placeholder="enter your nick" class="form-control" autofocus  />
			</c:if>
		</p>
		<p>
			fileName  
			<input type="file" name="fName" id="inputImgs" accept=".jpg, .gif, .png, .zip, .ppt, .pptx, .hwp" multiple style="display: none; margin-bottom: 2px;" />			
		</p>
		<div>			
			<input type="button" value="Upload" onclick="fCheck()" class="form-control btn btn-success mb-3" />			
			<input type="reset" value="rechoose" class="btn btn-warning mr-4" />			
			<input type="button" value="toSingleFileUpload(fileList)" onclick="location.href='${ctp}/study/fileUpload/fileUpload';" class="btn btn-primary mr-4" />
			<input type="button" value="toMultiFileUpload" onclick="location.href='${ctp}/study/fileUpload/multiFile';" class="btn btn-primary mr-4" />
		</div>
		<input type="hidden" name="imgNames" id="imgNames">
	</form>
	<hr/><br/>
	<div>
		<div class="imgsWrap">
			<img id="img" />
		</div>
	</div>
	<br/><hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

