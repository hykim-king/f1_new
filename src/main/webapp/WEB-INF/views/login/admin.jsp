<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<%
    // 서버 측에서 사용자 세션을 확인하고, 세션이 없으면 기본 페이지로 리다이렉트합니다.
    if (session.getAttribute("user") == null) {
      response.sendRedirect("/login");
    }
%>
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
	
<nav class="navbar navbar-expand-md mb-4" style="background-color: white;">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">RoadScanner</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <c:if test="${user ne null}">
          <li class="nav-item">
            <a class="nav-link" href="${CP}/main/preUpload">사진 업로드</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">게시판</a>
          </li>
        </c:if>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">관리자 기능</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${CP}/admin">List</a></li>
            <li><a class="dropdown-item" href="#">Upload</a></li>
            <li><a class="dropdown-item" href="#">Board</a></li>
          </ul>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <!-- 로그인 세션 X -->
       <%-- <c:if test="${user eq null}">
          <button type="button" id="login" onClick="window.location.reload()" class="btn btn-outline-primary me-2">Login</button>
        </c:if> --%>
        
        <!-- 로그인 세션 O -->
        <c:if test="${user ne null}">
          <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='${CP}/mypage'">MyPage</button>
          <button type="button" class="btn btn-outline-primary" onclick="location.href='${CP}/logout'" style="margin-right: 50px;">LogOut</button>
        </c:if>
      </form>
    </div>
  </div>
</nav>

<body>

<c:if  test="${user ne null}">
<div class ="admin_container">
    <h1 style="margin: auto; text-align:center;">관리자전용 페이지입니다.</h1>   
    <iframe id ="member_iframe" src="http://localhost:8080/login/list_member"
    style="margin: 50px auto; height: 500px;"></iframe>


<br/>

    <h1 style="margin: auto; text-align:center;"></h1>   
    <iframe id ="admin_iframe" src="http://localhost:8080/login/list_admin"
    style="margin: 50px auto; height: 500px;"></iframe>


<br/>


    <h1 style="margin: auto; text-align:center;"></h1>   
    <iframe id ="banned_iframe" src="http://localhost:8080/login/list_banned"
    style="margin: 50px auto; height: 500px;"></iframe>
</div>
</c:if>

<c:if test="${user eq null}">  <!-- 유저 정보X -->
    <div style="text-align: center; margin:80px auto;">
        <h4>로그인 이후 진행해주세요.</h4><p/>
          <img alt="ddd" src="../resources/img/infinite.gif" loop = 1 >
        <h4><a href="${CP}/login">Go To 로그인</a></h4>
    </div>            
</c:if> <!-- 유저 정보X-end -->


</body>


<footer class="py-3 my-4 mt-auto">
  <ul class="nav justify-content-center border-bottom pb-3 mb-3">
  </ul>
  <p class="text-center text-body-secondary">&copy; 2023 F1 RoadScanner Project, All rights reserved.</p>
</footer>

</html>
