<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
    <link  rel="stylesheet" href="${CP}/resources/css/admin.css" >
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <title>관리자 페이지</title>
</head>
<body>
<c:if test="${user ne null }">
        <input type="hidden" id="ugrade"  value="${user.rgrade}">
</c:if> 
<div class ="admin_container">
    <h1 style="margin: auto; text-align:cneter;">여기는 관리자전용이다</h1>   
    <iframe src="http://localhost:8080/memberAdmin"
    style="margin: 50px auto; height: 500px;">
    </iframe>


<br/> 
    <iframe src="http://localhost:8080/memberAdmin2"
    style="margin: 50px auto; height: 400px;"></iframe>
</div>

<footer class="py-3 my-4 mt-auto">
  <ul class="nav justify-content-center border-bottom pb-3 mb-3">
  </ul>
  <p class="text-center text-body-secondary">&copy; 2023 F1 RoadScanner Project, All rights reserved.</p>
</footer>
</body>
<script>
$(document).ready(function(){ //모든 화면이 다 로딩이 되면 실행하는 영역
    console.log("건설로봇");
});
</script>
</html>
