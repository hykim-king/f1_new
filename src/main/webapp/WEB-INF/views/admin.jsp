<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
<link  href="${CP}/resources/css/admin.css" rel="stylesheet">
<link  href="${CP}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <title>관리자 페이지</title>
</head>
<body>
<div class ="admin_container">
<h1>여기는 관리자전용이다</h1>    
        <c:forEach var="list" items="${list}">
                <ul style="list-style: none; 
                     text-align: left; padding-left: 0; margin-top: 10px; height: 200px;">
                    <li>no:<span>${list.rnumber}</span></li>
                    <li>id:<span>${list.rid}</span></li>
                    <li>id:<span>${list.rpassword}</span></li>
                    <li>email:<span>${list.remail}</span></li>
                    <li>보관방법:<span>${list.rdate}</span></li>
                </ul>           
        </c:forEach>
    <div>
        <nav aria-label="Page navigation example">
		  <ul class="pagination admin_paging">
		  <c:if test="${page.prev}">
		    <li class="page-item"><a class="page-link" href="/admin?num=${page.startPageNum - 1}">이전</a></li>
		  </c:if>
		  <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
		      
		      <c:if test="${select != num}">
	            <li class="page-item"><a class="page-link" href="/admin?num=${num}">${num}</a></li>
	          </c:if>
	          
	          <c:if test="${select == num}">
		        <li class="page-item"><a class="page-link" href="/admin?num=${num}">${num}</a></li>
		      </c:if>
		  
		  </c:forEach>
		  <c:if test="${page.next}">  
		    <li class="page-item"><a class="page-link" href="/admin?num=${page.endPageNum + 1}">다음</a></li>
		  </c:if>
		  </ul>
		</nav>   
	</div>	
</div>	
</body>
</html>
