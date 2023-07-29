<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> 
    <!-- CSS -->
    <link href="${CP}/resources/css/withdraw.css" rel="stylesheet"> <!--.css 파일 연결 -->
    <link href="${CP}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="${CP}/resources/js/bootstrap/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <title>test</title>
	

</head>
<body>
<c:if test="${user ne null }">
    <div class="container">
        <h1>RoadScanner</h1>
        <form>
          <label for="password"></label>
          <input type="password" id="upassword" placeholder="비밀번호를 입력하세요">
        </form>
        <input type="hidden" id="uid"  value="${user.uid}">
        <input type="hidden" id="upw"  value="${user.upassword}">
        <button id="doWithdraw">회원 탈퇴하기</button>
   </div>
</c:if>  

<c:if test="${user eq null}">  <!-- 유저 정보X -->
	<div style="text-align: center; margin:80px; auto;">
	    <h4>로그인 이후 진행해주세요.</h4><p/>
	    <img alt="ddd" src="../resources/img/infinite.gif" loop = 1 >
	    <h4><a href="${CP}/login">Go To 로그인</a></h4>
	</div>            
</c:if> <!-- 유저 정보X-end -->
   <script>
       $(document).ready(function() {
           console.log("$document ready");

           $("#doWithdraw").click(function() {
               var password = $("#password").val();
               
               

               
               // 확인 메시지 표시
               if (!confirm('회원 탈퇴하시겠습니까?') == true) {
                   return false;
               }
               
               if($("#upassword").val() != $("#upw").val()) {
               	alert("비밀번호가 다릅니다")
               	console.log("비밀번호를 확인하세요");
               }
                   
               else{


               // AJAX 요청을 보냅니다.
               $.ajax({
                   type: "POST",
                   url:"${CP}/withdraw",
                   dataType:"html",
                   data: {
                   	uid: $("#uid").val()
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
</body>
</html>