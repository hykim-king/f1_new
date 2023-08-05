<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<%
 String strReferer = request.getHeader("referer");
 if(strReferer == null){
%>
 <script language="javascript">
  alert("접속을 차단합니다.");
  document.location.href="${CP}/login";
 </script>
<%
 return;
 }
%>  
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
    <title>관리자 페이지</title>
</head>
<body>

<div class ="admin_container">
    <h1 style="margin: auto; text-align:cneter;">여기는 관리자전용이다</h1>   
    <iframe src="http://localhost:8080/memberAdmin"
    style="margin: 50px auto; height: 500px;"></iframe>


<br/>


    <h1 style="margin: auto; text-align:cneter;">여기는 관리자전용이다</h1>   
    <iframe src="http://localhost:8080/memberAdmin2"
    style="margin: 50px auto; height: 400px;"></iframe>
</div>


</body>
</html>
