<%@ page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>

<%
    // 서버 측에서 사용자 세션을 확인하고, 세션이 없으면 기본 페이지로 리다이렉트합니다.
    if (session.getAttribute("user") == null) {
      response.sendRedirect("/login");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>Main</title>
<style>
  body {
    margin: 0;
    padding: 0;
    height: 100vh;
    overflow: hidden;
  }
  
  .left {
    flex: 1;
    border: 0px solid #ccc;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .right {
    flex: 1;
    overflow: auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
  }
  
  .divider {
    width: 1px;
    background-color: #ccc;
    height: 100%;
  }
  
  #fileUploadLabel {
    margin-left: 20px;
    cursor: pointer;
    display: inline-block;
    overflow: hidden;
    position: relative;
    width: 400px;
    height: 400px;
  }
  
  #fileUploadLabel img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  
  #cancelContainer {
    display: none;
    position: relative;
  }
  
  #selectedImage {
    max-width: 500px;
  }
  
  #cancelButton {
    position: absolute;
    top: 5px;
    right: 5px;
    z-index: 2;
  }
  
  #cancelButton img{
    width: 30px;
    height: 30px;
  }
  
  #FeedbackButtons {
    width: 45%;
    display: flex;
    justify-content: space-between;
    padding: 30px;
  }
  
  #FeedbackButtons img {
    width: 100px;
    height: 100px;
  }
  
  #dislikeReason {
    width: 220px;
    font-size: 16px;
    background-color: #f5f5f5;
    border: 1px solid #ccc;
    border-radius: 5px;
    text-align: center;
  }
  
  #reasonForm {
    margin-bottom: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
  }
  
  label {
    display: block;
    text-align: center;
  }
  
  input[type="submit"] {
    margin-top: 40px;
    display: block;
    width: 100%;
    height: 60px;
    font-size: 22px;
  }
  
  input[type="file"] {
    opacity: 0;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
    display: none;
  }
</style>
</head>

<nav class="navbar navbar-expand-md mb-4" style="background-color: white;">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">RoadScanner</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-5 mb-md-0">
        <c:if test="${user ne null}">
          <li class="nav-item">
            <a class="nav-link" href="${CP}/main/preUpload">사진  업로드</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">게시판</a>
          </li>
        </c:if>
        <c:if test="${user.grade == 2}">
        <li class="nav-item dropdown">
          <input type="hidden" id="nekeyword" name="nekeyword" value ="${user.id}">
          <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">관리자 기능</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${CP}/admin">List</a></li>
            <li><a class="dropdown-item" href="#">Upload</a></li>
            <li><a class="dropdown-item" href="#">None</a></li>
          </ul>
        </li>
        </c:if>
      </ul>
      <form class="d-flex" role="search">
        <!-- 로그인 세션 X -->
        <c:if test="${user eq null}">
          <button type="button" id="login" onClick="window.location.reload()" class="btn btn-outline-primary me-2">Login</button>
          <button type="button" onclick="location.href='${CP}/registerpage'" class="btn btn-outline-primary" style="margin-right: 50px;">Sign-up</button>
        </c:if>
        
        <!-- 로그인 세션 O -->
        <c:if test="${user ne null}">
          <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='${CP}/mypage'">MyPage</button>
          <button type="button" class="btn btn-outline-primary" onclick="location.href='${CP}/logout'" style="margin-right: 50px;">LogOut</button>
        </c:if>
      </form>
    </div>
  </div>
</nav>

<body class="d-flex flex-column min-vh-100">
  <div class="left">
    <form action="fileUploaded" method="post" enctype="multipart/form-data" onsubmit="return false;">
      <div id="previewGroup" style="display: flex; flex-direction: row;">
        <label id="fileUploadLabel" for="fileUpload" style="display: block; cursor: pointer;">
          <img id="selectButtonImg" alt="SelectButton" src="${CP}/resources/img/selectButton.jpg" width="400" height="400">
        </label>
        <!-- 파일 선택 -->
        <input type="hidden" id="userid" value="${user.id}">
        <input id=fileUpload name="fileUpload" type="file" accept=".jpg, .jpeg, .png, .bmp, .tiff, .webp, .ico, .svg" onchange="displaySelectedFile(event)" style="display: none;">
        <div id="cancelContainer">
          <img id="selectedImage" alt="Selected Image">
          <button id="cancelButton" type="button" class="btn btn-link">
            <img alt="XButton" src="${CP}/resources/img/cancel.png">
          </button>
        </div>
      </div>
      <!-- 모델로 사진 전송, 실행 -->
      <div id="RunContainer" style="display: none;">
        <input type="submit" value="표지판 알아보기" id="runButton">
      </div>
    </form>
  </div>
  
  <script>
    // 선택한 이미지 미리보기로 보여주기-------------------------------------------------------
    // 이미지 미리보기 취소
    const fileUploadInput = document.getElementById('fileUpload');
    const fileUploadLabel = document.getElementById('fileUploadLabel');
    const selectButtonImg = document.getElementById('selectButtonImg');
    const cancelContainer = document.getElementById('cancelContainer');
    const selectedImage = document.getElementById('selectedImage');
    const cancelButton = document.getElementById('cancelButton');
    const RunContainer = document.getElementById('RunContainer');

    function displaySelectedFile(event) {
      const file = event.target.files[0];
      if (file) {
        // 파일 크기 체크 (5MB)
        const maxSize = 5 * 1024 * 1024;
        if (file.size > maxSize) {
            alert('최대 5MB인 이미지만 선택 가능합니다.');
            fileUploadInput.value = '';
            return;
        }
        
        const reader = new FileReader();

        reader.onload = function() {
          fileUploadLabel.style.display = 'none';    // 파일선택 버튼 이미지 숨기기
          cancelContainer.style.display = 'block';   // 미리보기 보이기
          selectedImage.src = reader.result;
          RunContainer.style.display = 'block';      // "표지판 알아보기" 버튼 보이기
        };
        
        // 추가: 허용된 이미지 확장자 체크
        const allowedExtensions = ['jpg', 'jpeg', 'png', 'bmp', 'tiff', 'webp', 'ico', 'svg'];
        const fileExtension = file.name.split('.').pop().toLowerCase();
        if (!allowedExtensions.includes(fileExtension)) {
          alert('이미지 파일이 아닙니다.');
          fileUploadInput.value = '';
          return;
        }
        
        reader.readAsDataURL(file);
        //console.log(`displaySelectedFile`);
      } else {
        fileUploadLabel.style.display = 'block';    // 파일선택 버튼 이미지 보이기
        cancelContainer.style.display = 'none';     // 미리보기 숨기기
        RunContainer.style.display = 'none';        // "표지판 알아보기" 버튼 숨기기
      }
    }
    
    // 취소 버튼 클릭 이벤트 리스너 추가
    cancelButton.addEventListener('click', function() {
      fileUploadInput.value = '';                   // 파일 선택 취소
      fileUploadLabel.style.display = 'block';      // 파일선택 버튼 이미지 보이기
      cancelContainer.style.display = 'none';       // 미리보기 숨기기
      RunContainer.style.display = 'none';          // "표지판 알아보기" 버튼 숨기기
      //console.log(`displaySelectedFile: None`);
    });
    // 선택한 이미지 미리보기로 보여주기 End----------------------------------------------------

    // 파일 업로드-------------------------------------------------------------------
    // '표지판 알아보기'클릭 시 파일 업로드, /upload로 넘어가기
    $("#runButton").on("click", function(){
      //console.log('runButton click');
      let userid = $("#userid").val();
      let formData = new FormData();
        formData.append("fileUpload", $("#fileUpload")[0].files[0]);
        formData.append("idx", 1);
        formData.append("id", userid);
        formData.append("category", 10);
        formData.append("name", "testname");
        formData.append("url", "testurl");
        formData.append("fileSize", 0);
        formData.append("checked", 0);
        formData.append("u1", 0);
        formData.append("u2", 0);
      
      $.ajax({
          type: "POST",
          url: "/main/fileUploaded",
          processData: false,
          contentType: false,
          data: formData,
          success: function(data) { // 통신 성공
               console.log(data);
               // 여기서 페이지 이동
               window.location.href = "/main/upload?imgName=" + encodeURIComponent(data);
          },
          error: function(data) { // 실패시 처리
              console.error("파일 업로드 오류:", data.msgId, data.msgContents);
          }
      });

      
    });
    // 파일 업로드 End----------------------------------------------------------------

  </script>
</body>

 <footer class="py-3 my-4 mt-auto">
  <ul class="nav justify-content-center border-bottom pb-3 mb-3">
  </ul>
  <p class="text-center text-body-secondary">&copy; 2023 F1 RoadScanner Project, All rights reserved.</p>
</footer>

</html>