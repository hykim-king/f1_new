<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
    // 서버 측에서 사용자 세션을 확인하고, 세션이 없으면 기본 페이지로 리다이렉트합니다.
    if (session.getAttribute("user") == null) {
      response.sendRedirect("/login");
    }
%> --%>
<c:set var="CP" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"  href="${CP}/resources/css/changePw.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link  href="${CP}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>로드스캐너 마이페이지</title>
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
     </ul>
     <form class="d-flex" role="search">
       <button type="button" id="login" onclick="location.href='${CP}/login'" class="btn btn-outline-primary me-2">Login</button>
       <button type="button" onclick="location.href='${CP}/registerpage'" class="btn btn-outline-primary" style="margin-right: 50px;">Sign-up</button>  
     </form>
     
   </div>
   
 </div>
</nav>

<body class="d-flex flex-column min-vh-100">
 <h3 style="text-align: center; margin-top: 100px; margin-bottom: 40px;">비밀번호 재설정 페이지</h3>
  <div id="container">
      <form>
        <fieldset style="border:0 solid black;">
          <ul class="list-group" style="list-style: none;">
            <li>
              <label>이메일</label><br/>
              <div style="display: flex;">
	              <input class="form-control" type="text" id="remail" placeholder="이메일 주소" onkeyup="check_email(event)"
	                     style="width: 700px; margin-right: 50px;">
	              <input type="button" class="btn btn-outline-primary" id="emailDulpCheck" value="유저 확인">
              </div>
            </li>
            <li>
             <label for="mail-Check-Btn">이메일 인증번호 입력</label>
             <label id="mail-check-warn" style="margin-left: 10px;"></label><br/>
             <input class="form-control" type="text" class="emailcheck" name="checkInput" id="checkInput" placeholder="인증번호 6자리를 입력해주세요" 
                    maxlength="6" required="required" style="width: 655px;">
            </li> 
            <li>
              <label>비밀번호 수정</label><br/>
              <input class="form-control" type="password" id="rpassword" placeholder="문자, 숫자, 특수문자 포함 8~20글자)" onchange="check_pw()">
            </li>
            <li>
              <label>비밀번호 확인</label>
              <label id="pw_check" style="margin-left: 10px; text-align: center;"></label><br/>
              <input class="form-control" type="password" id="rpassword2" placeholder="비밀번호 재입력" onchange="check_pw()">
            </li>
          </ul>
        </fieldset>
      </form>
      <form method="POST" name="register_form">
            <input type="hidden" name="pw" id="pw">
            <input type="hidden" name="email" id="email">         
      </form>
        <input type="hidden" name="emailok" id="emailok"> 
    </div>
    <div class="update_btn">
      <input type="button" class="btn btn-outline-primary" id="changePw" value="변경">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="btn btn-outline-danger" id="cancel" value="취소">
    </div>
</body>

<footer class="py-3 my-4 mt-auto">
  <ul class="nav justify-content-center border-bottom pb-3 mb-3">
  </ul>
  <p class="text-center text-body-secondary">&copy; 2023 F1 RoadScanner Project, All rights reserved.</p>
</footer>

<script>
function check_pw() {
    var pw = document.getElementById('rpassword').value;
    var num = pw.search(/[0-9]/g);
    var eng = pw.search(/[a-z]/ig);
    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
       
    if(pw.length<8 || pw.length>20) {
       window.alert('비밀번호는 8글자 이상, 20글자 이하만 이용 가능합니다.');
       document.getElementById('rpassword').value='';
       document.getElementById('rpassword').focus();
    } else if(pw.search(/\s/) != -1) {
       window.alert('비밀번호는 공백 없이 이용 가능합니다');
       document.getElementById('rpassword').value='';
       document.getElementById('rpassword').focus();
    } else if(num < 0 || eng < 0 || spe < 0) {
       window.alert('영문, 숫자, 특수문자를 최소 1글자 이상씩 사용하여 입력해주세요');
       document.getElementById('rpassword').value='';
       document.getElementById('rpassword').focus();
    }           
    
    if(document.getElementById('rpassword').value !='' && document.getElementById('rpassword2').value!='') {
      
        if(document.getElementById('rpassword').value == document.getElementById('rpassword2').value) {
            document.getElementById('pw_check').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('pw_check').style.color='blue';
            document.getElementById('pw_check').style.fontSize='15px';
        } else {
            document.getElementById('pw_check').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('pw_check').style.color='red';
            document.getElementById('pw_check').style.fontSize='15px';
            document.getElementById('rpassword').value='';
            document.getElementById('rpassword2').value='';
        }
        
    }
    
}   // check_pw end

function check_email(event) {
    const hangul = /[^0-9a-zA-Z@\.]/g;
    const ele = event.target;
    
    if(hangul.test(ele.value)) {
      ele.value = ele.value.replace(hangul,'');
    }
    
}   // check_email

function email_authNumber() {
    const email = $('#remail').val();    // 이메일 주소값 얻어오기!
    const checkInput = $('#checkInput'); // 인증번호 입력하는곳
        
    if("ok" != document.getElementById('emailok').value){
    	
      alert('이메일 중복 확인 후, 진행하세요');
      
    } else {
    	
        $.ajax({
            type : 'get',
            url : "change_mailCheck?email=" + email,
            success : function(data) {

                console.log("data : " + data);
                $('#checkInput').attr('disabled', false);
                code = data;
                alert('인증번호가 전송되었습니다.');
            }
        
        }); // end ajax
        
    }   // else end

} // email_authNumber end

// 인증번호 비교
// blur -> focus가 벗어나는 경우 발생
$('#checkInput').blur(function() {
    const inputCode = $(this).val();
    const $resultMsg = $('#mail-check-warn');

    if (inputCode == code) {
        $resultMsg.html('인증번호가 일치합니다.');
        $resultMsg.css('color', 'blue');
        $resultMsg.css('font-size', '15px');
        $('#mail-Check-Btn').attr('disabled', true);
        $('#remail').attr('readonly', true);
        certified_Email = true;
    } else {
        certified_Email = false;
        $resultMsg.html('인증번호가 일치하지 않습니다.');
        $resultMsg.css('color', 'red');
        $resultMsg.css('font-size', '15px');
    }
    
});   // checkInput function end

$(document).ready(function(){  //모든 화면이 다 로딩이 되면 실행하는 영역
   console.log("document ready");
   
  $("#cancel").on("click", function(){
    
    window.location.href="${CP}/findIdAndPw";
    
  });   // $("#cancel") click
  
  $("#changePw").on("click", function(){
    
	    let registerPw = document.getElementById('rpassword2').value;
	    let registerEmail =  $('#remail').val();
	    console.log(registerEmail);
	     
	    document.register_form.pw.value = registerPw;
	    document.register_form.email.value = registerEmail;

      
      if("" == document.getElementById('rpassword').value || "" == document.getElementById('rpassword2').value) {
          alert("비밀번호를 입력하세요");
          return false;
      }
            
      if("" == document.getElementById('checkInput').value){
        alert("이메일 인증을 진행해 주십시오.");
          return false;
      }
      
      if( document.getElementById('checkInput').value != code){
          alert("이메일 인증번호가 다릅니다.");
          return false;
      }
    
    $.ajax({
          type: "POST",
          url:"${CP}/changePassword",
          asyn:"true",
          dataType:"html",
          data:{
            password: $("#pw").val(),
            email: $("#email").val()
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
    
  });   // $("#changePw") click
  
  $("#emailDulpCheck").on("click",function(){
      console.log("emailDulpCheck ready");
      
      var emial_str = $('#remail').val();
      console.log(emial_str);
      
      if(""==$('#remail').val()) {
        alert("이메일을 입력하세요");
        $('#remail').focus(); 
        return;
        
    } else if(emial_str.search(/\s/) != -1) {
        alert('이메일은 공백 없이 입력하세요');
        document.getElementById('remail').value='';
        return;
    }
    
    $.ajax({
        type: "POST",
        url:"${CP}/emailCheck",
        dataType:"html",
        data:{
          email: emial_str
        },
        success:function(data){
            let parsedJSON = JSON.parse(data);
            console.log("parsedJSON.msgId:"+parsedJSON.msgId);                             
            
            if("20" == parsedJSON.msgId){
              alert(parsedJSON.msgContents);  // javascript 메시지 다이얼 로그
              $("#remail").focus();
            } 
            
            if("10" == parsedJSON.msgId){//
              alert(parsedJSON.msgContents);
              $('#emailok').attr('value',"ok");
              email_authNumber();
            }
            
           
          },
          error:function(data){//실패시 처리
            console.log("error:"+data);
          }
          
    }); //  $.ajax End --------------------------
     
    
  });  // #idDulpCheck end
  
  
});   //모든 화면이 다 로딩이 되면 실행하는 영역
</script>
</html>