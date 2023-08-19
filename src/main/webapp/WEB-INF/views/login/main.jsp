<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="${CP}/resources/js/fullpage/fullPage.css" >
<!-- JS -->
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<script src="${CP}/resources/js/fullpage/fullPage.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<title>Insert title here</title>
<style>

.intro_logo {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
  color: white; /* 텍스트 색상을 원하는 대로 설정해주세요 */
  font-size: 24px; /* 원하는 폰트 크기로 설정해주세요 */
}

</style>
</head>
<body>

<div id="fullpage">
  <div class="section active">
    <video class="intro_video" src="${CP}/resources/video/cat.mp4" data-autoplay loop muted></video>
    <div class="intro_logo">
        <p>RoadScanner</p>
    </div>
  </div>
  <div class="section">2 section</div>
  <div class="section">3 section</div>
</div>
<script>

$(document).ready(function(){
	
	$('#fullpage').fullpage({		
		autoScrolling:true,
		scrollHorizontally: true,
		slidesNavigation : true,
	  navigation : true
				
	});
	
});

</script>
</body>
</html>