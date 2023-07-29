<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"  href="${CP}/resources/css/mypage.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link  href="${CP}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>RoadScanner mypage test</title>
</head>
  <header class="p-3 text-bg-white">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">       

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="#" class="nav-link px-2 text-secondary">Home</a></li>
          <li><a href="#" class="nav-link px-2 text-secondary">Features</a></li>
          <li><a href="#" class="nav-link px-2 text-secondary">Pricing</a></li>
          <li><a href="#" class="nav-link px-2 text-secondary">FAQs</a></li>
          <li><a href="#" class="nav-link px-2 text-secondary">About</a></li>
        </ul>

        <div class="text-end">
        <c:if test="${user ne null}">
          <button type="button" class="btn btn-warning me-2"
          onclick="location.href='${CP}/logout'">LogOut</button>
          <button type="button" onclick="location.href='${CP}/mypage'" class="btn btn-warning me-2">MyPage</button>
        </c:if>
        <c:if test="${user eq null}">
          <button type="button" id="login" onclick="location.href='${CP}/login'" class="btn btn-warning me-2">Login</button>
        </c:if>
          <button type="button" onclick="location.href='${CP}/registerpage'" class="btn btn-warning">Sign-up</button>
        </div>
      </div>
    </div>
  </header>
  <body class="d-flex flex-column min-vh-100">
  <c:if test="${user ne null }"> <!--  유저 정보O -->
  <h2 style="text-align: center; margin-top: 100px; margin-bottom: 80px;">${user.uid}의 마이페이지</h2>
	  <div id="container">
			  <form>
			    <fieldset style="border:0 solid black;">
			      <ul class="list-group" style="list-style: none;">
				      <li>
					      <label>아이디</label><br/>
					      <input class="form-control" type="text" id="uid" readonly="readonly" value="${user.uid}">
					    </li>
					    <li>
					      <label>비밀번호 수정</label><br/>
					      <input class="form-control" type="password" id="upassword" placeholder="문자, 숫자, 특수문자 포함 8~20글자)" >
					    </li>
					    <li>
					      <label>비밀번호 확인</label>
					      <label id="pw_check"></label><br/>
					      <input class="form-control" type="password" id="upassword2" placeholder="비밀번호 재입력" onchange="check_pw()">
					    </li>
					    <li>
					      <label>이메일</label><br/>
					      <input class="form-control" type="text" id="uemail" readonly="readonly" value="${user.uemail}">
					    </li>
				    </ul>
			    </fieldset>
			  </form>
			</div>
			<div class="update_btn">
		    <input type="button" class="btn btn-outline-primary" id="update" value="수정">
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <input type="button" class="btn btn-outline-danger" id="cancel" value="취소">
	    </div>
	    <div class="qna_btn">
	       <input type="button" class="btn btn-outline-dark" id="myQnAboard" value="내 QnA보기">
	    </div>
	    <div class="draw_btn">
	       <input type="button" class="btn btn-outline-dark" id="withdraw" value="탈퇴">
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
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Features</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Pricing</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>
    </ul>
    <p class="text-center text-body-secondary">&copy; 2023 F1 TEAM, RoadScanner Project</p>
  </footer>

<script>
function check_pw() {
    var pw = document.getElementById('upassword').value;
    var num = pw.search(/[0-9]/g);
    var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

    if(pw.length<8 || pw.length>20) {
       window.alert('비밀번호는 8글자 이상, 20글자 이하만 이용 가능합니다.');
       document.getElementById('upassword').value='';
    } else if(pw.search(/\s/) != -1) {
       window.alert('비밀번호는 공백 없이 이용 가능합니다');
       document.getElementById('upassword').value='';
    } else if(num < 0 || eng < 0 || spe < 0) {
       window.alert('영문, 숫자, 특수문자를 최소 1글자 이상씩 사용하여 입력해주세요');
       document.getElementById('upassword').value='';
    }           
    
    if(document.getElementById('upassword').value !='' && document.getElementById('upassword2').value!='') {
      
        if(document.getElementById('upassword').value == document.getElementById('upassword2').value) {
            document.getElementById('pw_check').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('pw_check').style.color='blue';
        } else {
            document.getElementById('pw_check').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('pw_check').style.color='red';
            document.getElementById('upassword').value='';
            document.getElementById('upassword2').value='';
        }
        
    }
    
}   // check_pw end

$(document).ready(function(){  //모든 화면이 다 로딩이 되면 실행하는 영역
   console.log("document ready");
   
   $("#login").on("click", function(){
	   
	   window.location.href="${CP}/login";
	   
   }); // login click
   
   $("#withdraw").on("click", function(){
	      
	    alert("탈퇴페이지 이동");
	    window.location.href="${CP}/withdraw";
	    
	  });   // $("#withdraw") click

   $("#withdraw").on("click", function(){
	      
	    alert("로그인페이지로 이동합니다");
	    window.location.href="${CP}/withdraw";
	    
	  });   // $("#cancel") click

  $("#cancel").on("click", function(){
	  
    alert("로그인페이지로 이동합니다");
    window.location.href="${CP}/login";
    
  });   // $("#cancel") click
  
  $("#update").on("click", function(){
	  
	  $.ajax({
	        type: "POST",
	        url:"${CP}/update",
	        asyn:"true",
	        dataType:"html",
	        data:{
	        	uid: $("#uid").val(),
	        	upassword: $("#upassword").val(),
	        	uemail: $("#uemail").val()
	        },
	        success:function(data){//통신 성공
	        	  let parsedJSON = JSON.parse(data);
	        	  
	        	  if("10" == parsedJSON.msgId) {
	        		  alert(parsedJSON.msgContents);
	        		  window.location.href="${CP}/login";
	        	  }
	        	  
	        	  if("20" == parsedJSON.msgId) {
                  alert(parsedJSON.msgContents);
                  return;
	             }
	        	  
	          },
	          error:function(data){//실패시 처리
	            console.log("error:"+data);
	          }
	      });  // ajax end
	  
  });   // $("#update") click
  
});   //모든 화면이 다 로딩이 되면 실행하는 영역
</script>
</html>