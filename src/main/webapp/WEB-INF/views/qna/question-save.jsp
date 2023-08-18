<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>로드스캐너 - 게시판 등록</title>
<meta charset="UTF-8">
<meta name="viewport"
    content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 부트스트랩 CSS 추가 -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link  href="${c}/resources/css/membership-style.css" rel="stylesheet">
<link  href="${c}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
<script src="${c}/resources/js/bootstrap/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
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
            <a class="nav-link" href="${c}/main/preUpload">사진 업로드</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${c}/qna">게시판</a>
          </li>
        </c:if>
        <c:if test="${user.grade == 2}">
        <li class="nav-item dropdown">
          <input type="hidden" id="nekeyword" name="nekeyword" value ="${user.id}">
          <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">관리자 기능</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${c}/admin">List</a></li>
            <li><a class="dropdown-item" href="#">Upload</a></li>
            <li><a class="dropdown-item" href="#">None</a></li>
          </ul>
        </li>
        </c:if>
      </ul>
      <form class="d-flex" role="search">
        <!-- 로그인 세션 X -->
        <c:if test="${user eq null}">
          <button type="button" id="login" onclick="location.href='${c}/login'" class="btn btn-outline-primary me-2">Login</button>
          <button type="button" onclick="location.href='${c}/registerpage'" class="btn btn-outline-primary" style="margin-right: 50px;">Sign-up</button>
        </c:if>
        <!-- 로그인 세션 O -->
        <c:if test="${user ne null}">
          <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='${c}/mypage'">MyPage</button>
          <button type="button" class="btn btn-outline-primary" onclick="location.href='${c}/logout'" style="margin-right: 50px;">LogOut</button>
        </c:if>
      </form>
    </div>
  </div>
</nav>
<body>
    <form class="container mt-4" id="question-form">
        <h1 class="mb-4">Q&A 게시판</h1>
        <div class="mb-3 row">
            <label for="category" class="col-sm-2 col-form-label">카테고리:</label>
            <div class="col-sm-10">
                <select id="category" name="category" class="form-select">
                    <option value="30" selected>답변 대기</option>
                    <option value="10">공지</option>
                </select>
            </div>
        </div>
        <div class="mb-3 row">
            <label for="id" class="col-sm-2 col-form-label">작성자</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="id" value="${userId}" readonly>
            </div>
        </div>
        <div class="mb-3 row">
            <label for="title" class="col-sm-2 col-form-label">제목</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="title">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="idx" class="col-sm-2 col-form-label">첨부파일</label>
            <div class="col-sm-10">
                <input type="file" class="form-control" id="idx">
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="badge text-secondary mx-1"
                    style="background-color: #DCDCDC; border-radius: 5px 5px 0px 0px;">내용</div>
            </div>
        </div>
        <div class="mb-3 row">
            <div class="col">
                <textarea class="form-control" id="content" rows="10"></textarea>
            </div>
        </div>
        <div class="text-center">
            <a href="/qna" role="button" class="btn btn-secondary">취소</a>
            <button type="submit" id="btn-save" class="btn btn-primary"
                value="저장">등록</button>
        </div>
    </form>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/js/qna.js"></script>
</body>
<footer class="py-3 my-4 mt-auto">
  <ul class="nav justify-content-center border-bottom pb-3 mb-3">
  </ul>
  <p class="text-center text-body-secondary">&copy; 2023 F1 RoadScanner Project, All rights reserved.</p>
</footer>
</html>