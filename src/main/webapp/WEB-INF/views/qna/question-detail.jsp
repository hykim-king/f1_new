<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Question List</title>

    <!-- 부트스트랩 CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h1 class="mb-4">게시글 상세보기</h1>
    <div class="card">
        <div class="card-header">
            제목: ${question.title}
        </div>
        <div class="card-body">
            <h5 class="card-title">작성자: ${question.id}</h5>
            <p class="card-text">
                조회수: ${question.views}
            </p>
            <p class="card-text">
                작성일: ${question.createDate}
            </p>
            <p class="card-text">
                수정일: ${question.updateDate}
            </p>
            <p class="card-text">
                내용: ${question.content}
            </p>
        </div>
    </div>
</div>
<!-- 부트스트랩 JS 및 Popper.js 추가 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/qna.js"></script></body>
</html>
