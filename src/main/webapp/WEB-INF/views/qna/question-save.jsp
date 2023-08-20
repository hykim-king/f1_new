<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로드스캐너 - 게시판 등록</title>
</head>
<body>
<form class="container mt-5" id="question-form">
    <div class="mb-3">
         <c:choose>
             <c:when test="${user.grade == 2}">  <!-- 관리자 등급인 경우 -->
                 <input type="text" id="categoryLabel" class="form-control" value="공지" readonly>
                 <input type="hidden" id="category" name="category" value="10">
             </c:when>

             <c:otherwise>  <!-- 일반 사용자인 경우 -->
                 <input type="text" id="categoryLabel" class="form-control" value="답변대기" readonly>
                 <input type="hidden" id="category" name="category" value="30">
             </c:otherwise>
         </c:choose>
    </div>
    <div class="mb-3">
        <label for="id" class="form-label">작성자:</label>
        <input type="text" id="id" class="form-control" value="${user.id}" readonly>
    </div>
    <div class="mb-3">
        <label for="title" class="form-label">제목:</label>
        <input type="text" id="title" class="form-control">
    </div>
    <div class="mb-3">
        <label for="attachFile" class="form-label">첨부파일:</label>
        <input type="file" id="attachFile" name="attachFile" class="form-control">
    </div>
    <div class="mb-3">
        <label for="content" class="form-label">내용:</label>
        <textarea id="content" class="form-control" placeholder="내용을 입력하세요"></textarea>
    </div>
    <a href="/qna" role="button" class="btn btn-secondary">취소</a>
    <button type="submit" id="btn-save" class="btn btn-primary" value="저장">등록</button>
</form>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/qna.js"></script>
</body>
</html>