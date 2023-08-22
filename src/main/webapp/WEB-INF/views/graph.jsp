<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
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
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Feedback Graph</title>
</head>

<%@include file ="login/navbar.jsp" %>

<body>
  <div class="container">
    <h2>Feedback</h2>
    
    <div class="accordion">
		  <div class="accordion-item">
		    <div class="accordion-header">
		      <span>싫어요 피드백 누적 개수</span>
		      <span class="accordion-icon">∨</span>
		    </div>
		    <div class="accordion-content">
		      <div class="d-flex justify-content-center align-items-center flex-column">
			      <div class="barchart">
			        <canvas id="feedback_barchart"></canvas>
			      </div>
			      <table class="table table-bordered text-center" style="width: 60%;">
			        <thead>
			          <tr class="table-secondary">
			            <th>분류</th>
			            <th>누적 개수</th>
			          </tr>
			        </thead>
			        <tbody>
			          <tr>
			            <td>인식 오류</td>
			            <td id="u1"></td>
			          </tr>
			          <tr>
			            <td>결과 오류</td>
			            <td id="u2"></td>
			          </tr>
			          <tr  class="table-light">
			            <td>전체</td>
			            <td id="total"></td>
			          </tr>
			        </tbody>
			      </table>
			    </div>
		    </div> <!-- accordion-content -->
		  </div> <!-- accordion-item -->
		  <div class="accordion-item">
		    <div class="accordion-header">
          <span>월별 싫어요 피드백 개수 변화</span>
          <span class="accordion-icon">∨</span>
		    </div>
		    <div class="accordion-content">
		      <div class="container" style="width:60%; margin-bottom:10px;">
			      <select class="form-select" id="monthDropDown" name="month" style="width:100px;">
			      </select>
			    </div>
			    <div class="linechart">
			      <canvas id="feedback_linechart"></canvas>
			    </div>
		    </div> <!-- accordion-content -->
		  </div> <!-- accordion-item -->
		</div>   
  </div> <!--container -->

	<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>
	<script src="${CP}/resources/js/graph.js"></script>

</body>

  <%@include file ="login/footer.jsp" %>
	<link rel="stylesheet" href="${CP}/resources/css/graph.css" >
	
</html>