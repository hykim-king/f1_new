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

	<style>
	  .section-button {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 100%;
	  }
	
	  .start-button {
	    font-size: 8rem;
	    padding: 80px 160px;
	    border: none;
	    cursor: pointer;
	  }
	  
		   .info-section {
	    padding: 20px;
	    font-size: 1.5rem;
	  }
	  
		   /* 각 섹션에 배경색 적용 */
	  .section:nth-child(odd) {
	    background-color: #f9f9f9; /* 홀수 섹션 배경색 */
	  }
	
	  .section:nth-child(even) {
	    background-color: #FFA500; /* 짝수 섹션 배경색 */
	  }
		  
	</style>

<title>RoadScanner main</title>
</head>
<body>

<div id="fullpage">
  <div class="section">동영상</div>
  <div class="section">
      <div class="info-section">
      <h1>RoadScanner는??(임시)</h1>
      </br>
      <p>RoadScanner는 교통 표지판 인식 AI 웹 서비스입니다.</p>
      <p>RoadScanner는 교통 표지판을 식별하고 분류 할 수 있습니다.</p>
      <p>RoadScanner는 약 39,000개의 훈련 이미지와 12,600개의 테스트 이미지로 학습되었습니다.</p>
    </div>
    </div>
  <div class="section">
    <div class="info-section">
      <h1>RoadScanner를 이용하는 방법(임시)</h1>
      </br>
      <ol>
        <li>회원가입 및 로그인을 해주세요.</li>
        <li>파일 업로드 페이지에서 궁금한 사진을 업로드 해주세요.</li>
        <li>사진의 결과를 확인합니다.</li>
        <li>사진결과가 정확하다면 좋아요를 눌러주세요.</li>
        <li>사진 결과가 부정확하다면 싫어요와 이유를 써주세요.</li>
      </ol>
    </div>
    </div>
  <div class="section">
   <div class="section-button">
      <a href="/login" class="btn btn-outline-dark">시작하기</a>
    </div>
  </div>
</div>
<script>

$(document).ready(function(){
	
	$('#fullpage').fullpage({		
		autoScrolling:true,
		scrollHorizontally: true
				
	});
	
});

</script>
</body>
</html>