<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="stylesheet" href="${CP}/resources/js/fullpage/fullPage.css" >
  <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
  
  <!-- JS -->
  <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
  <script src="${CP}/resources/js/fullpage/fullPage.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
  
  <title>RoadScanner</title>
  
  <style>
  
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Bruno+Ace&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Bruno+Ace+SC&display=swap');
  
  .section {
    position: relative;
    width: 100%;
    height: 100vh;
    display: flex;
    overflow: hidden;
  }
  
  .intro_logo {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white; /* 텍스트 색상을 원하는 대로 설정해주세요 */
    font-size: 70px; /* 원하는 폰트 크기로 설정해주세요 */
    font-family: 'Bruno Ace', cursive;
    font-style: italic;
    text-shadow: 5px 5px 6px black;
  }
  
  .intro_video {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    height: auto;
    z-index: -1;
  }
  
  #second {
    border-radius: 10px; 
    border: 2px solid black; 
    margin: 0px 300px; 
    height: 600px;
  
  }
  
  #third {
    font-family: 'NanumSquareNeoBold';
    /* font-family: 'Noto Sans KR', sans-serif; */
    padding: 110px; 
    border-radius: 10px; 
    border: 6px solid white;
    color: white; 
    height: 600px; 
    background-color: rgba(0, 0, 0, 0.5);
  }
  
  #fourth {
    list-style: none; 
    margin: 20px 150px; 
    font-size: 20px;
  }
  
  #section-button {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-image: url(resources/picture/start.jpg); 
    background-size: cover; 
    width: 100%; 
    height: 100%; 
    background-position: center;
  }
  
  #start-button {
    text-align:center; 
    font-size: 150px; 
    color: black; 
    text-decoration: none; 
    font-family: 'Bruno Ace SC', cursive; 
    margin-top: 30px;
  }
          
  </style>

</head>

<body>

<div id="fullpage">

  <div class="section active">
    <video class="intro_video" src="${CP}/resources/video/test02.mov" data-autoplay loop muted></video>
    <div class="intro_logo">
        <p>RoadScanner</p>
    </div>
  </div>
 
  <div class="section">
    <video class="intro_video" src="${CP}/resources/video/driving.mp4" data-autoplay loop muted></video>
	    <div id="second">
	    
	      <div class="info-section" id="third">
	        <h1 style="text-align: center;">교통표지판 인식 AI 웹 서비스</h1>
	        <br/>
	        
	        <ul id="fourth">
	          <li>약 40,000개의 훈련 이미지와 13,000개의 테스트 이미지로 학습되어 교통 표지판을 식별할 수 있습니다</li>
	          <li>&nbsp;</li>
	          <li>1. 서비스를 이용하시려면 회원가입 후 사용 가능합니다</li>
	          <li>2. 회원가입 하신 계정으로 로그인합니다</li>
	          <li>3. 원하는 표지판 사진을 업로드해주세요</li>
	          <li>4. 결과를 확인하여 만족스럽다면 '좋아요'를 눌러주세요</li>
	          <li>5. 만약 만족스럽지 않다면, '싫어요'의 이유를 같이 선택해주세요</li>
	        </ul>
	      </div>
	      
	    </div>
    
  </div>
  
  <div class="section">
   <div class="section-button" id="section-button">
    <a id="start-button" href="${CP}/login"><b>START</b></a>
   </div>
  </div>
  
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