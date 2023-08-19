<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<%
 String strReferer = request.getHeader("referer");
 if(strReferer == null){
%>
 <script language="javascript">
  alert("접속을 차단합니다.");
  document.location.href="${CP}/mypage";
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
    <link href="${CP}/resources/css/withdraw.css" rel="stylesheet"> <!--.css 파일 연결 -->
    <link href="${CP}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="${CP}/resources/js/bootstrap/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <title>로드스캐너 탈퇴</title>
</head>

  <%@include file ="navbar.jsp" %>

<body class="d-flex flex-column min-vh-100">
<c:if test="${user ne null }">
    <div class="container">
        <h1 style="text-align: center; margin-top: 100px; margin-bottom: 100px;">RoadScanner</h1>
        <form>
          <label for="password"></label>
          <input type="password" id="upassword"  placeholder="비밀번호를 입력하세요">
        </form>
        <input type="hidden" id="uid"  value="${user.id}">
        <input type="hidden" id="upw"  value="${user.password}">
        <div class="wbut">
	       <input type="button" class="btn btn-outline-dark" id="withdraw" value="회원 탈퇴하기">
	    </div>
    
    </div>
</c:if>  
<c:if test="${user eq null}">  <!-- 유저 정보X -->
	<div style="text-align: center; margin:80px; auto;">
	    <h4>로그인 이후 진행해주세요.</h4><p/>
	    <img alt="ddd" src="../resources/img/infinite.gif" loop = 1 >
	    <h4><a href="${CP}/login">Go To 로그인</a></h4>
	</div>            
</c:if> <!-- 유저 정보X-end -->
   
</body>

  <%@include file ="footer.jsp" %>

<script>
   $(document).ready(function() {

       $("#withdraw").click(function() {
           var password = $("#upassword").val();

           // 확인 메시지 표시
           if (!confirm('회원 탈퇴하시겠습니까?') == true) {
               return false;
           }
      
           else {

	           // AJAX 요청을 보냅니다.
	           $.ajax({
	               type: "POST",
	               url:"${CP}/withdraw",
	               dataType:"html",
	               data: {
	                id: $("#uid").val(),
	                password: $("#upassword").val()
	               },
	               success:function(data) {
	                let parsedJSON = JSON.parse(data);
	                  
	                    if("10" == parsedJSON.msgId){
	                          alert(parsedJSON.msgContents);
	                          window.location.href="${CP}/login";
	                   } 
	                                         
	                   if("20" == parsedJSON.msgId){
	                       alert(parsedJSON.msgContents);
	                       return;
	                   }
	                   
	               },
	               error: function(data) {
	                   console.log("error:" + data);
	               }
	           }); // --ajax
           
           } // -- else
        	   
       }); // --doWithdraw
       
   });
</script>
</html>