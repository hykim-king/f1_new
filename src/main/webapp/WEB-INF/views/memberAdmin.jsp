<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <script src="${CP}/resources/js/util.js"></script>
    <title>회원 관리</title>
</head>
<body>
    <div class="container">
    
    
  <!-- 일반회원 --------------------------------------------------------------->
        <!-- 제목 -->
        <div class="page-header">
            <h2 class="text-center">회원 관리</h2>
        </div>
        <!-- 제목 end --------------------------------------------------------------->


        <!-- 회원 정보 테이블 -->
        <table class="table table-hover" id="memberTable">
            <thead class="table-light">
                <tr>
                    <th class="text-center">NO</th>
                    <th class="text-center">아이디</th>
                    <th class="text-center">이메일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${memberList}" varStatus="status">
                    <tr>
                        <td class="text-center col-sm-1">${status.index + 1}</td>
                        <td class="text-center col-sm-5">${member.rid}</td>
                        <td class="text-center col-sm-6">${member.remail}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 회원 정보 테이블 end ------------------------------------------------------------>
        
        <!-- 검색 폼 -->
        <div class="row mb-3">
            <div class="col">
                <form action="${CP}/memberAdmin" method="get" class="form-inline">
                    <div class="form-group">
                        <input type="text" name="searchKeyword" class="form-control" placeholder="아이디 검색">
                    </div>
                    <button type="submit" class="btn btn-primary ml-2">검색</button>
                </form>
            </div>
        </div>
        <!-- 검색 폼 end ------------------------------------------------------------>

        <!-- pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- pagination end ------------------------------------------------------->
  
   <!-- 일반회원 end--------------------------------------------------------------->    
     
        
  <!-- 관리자 리스트  ---------------------------------------------------------------> 
       
         <!-- 제목 -->
        <div class="page-header">
            <h2 class="text-center">관리자 리스트</h2>
        </div>
        <!-- 제목 end --------------------------------------------------------------->


        <!-- 회원 정보 테이블 -->
        <table class="table table-hover" id="memberTable">
            <thead class="table-light">
                <tr>
                    <th class="text-center">NO</th>
                    <th class="text-center">아이디</th>
                    <th class="text-center">이메일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${memberList}" varStatus="status">
                    <tr>
                        <td class="text-center col-sm-1">${status.index + 1}</td>
                        <td class="text-center col-sm-5">${member.rid}</td>
                        <td class="text-center col-sm-6">${member.remail}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 회원 정보 테이블 end ------------------------------------------------------------>
        
        <!-- 검색 폼 -->
        <div class="row mb-3">
            <div class="col">
                <form action="${CP}/memberAdmin" method="get" class="form-inline">
                    <div class="form-group">
                        <input type="text" name="searchKeyword" class="form-control" placeholder="아이디 검색">
                    </div>
                    <button type="submit" class="btn btn-primary ml-2">검색</button>
                </form>
            </div>
        </div>
        <!-- 검색 폼 end ------------------------------------------------------------>

        <!-- pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- pagination end ------------------------------------------------------->
        
	<!-- 관리자 리스트 end --------------------------------------------------------------->    

<!-- container end ------------------------------------------------------------------->
    </div>

</body>
</html>
