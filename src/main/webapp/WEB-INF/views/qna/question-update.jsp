<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>로드스캐너 - 게시판 수정</title>
</head>
<body>
<form class="container mt-5" id="question-edit-form">
  <!-- 이 부분에 히든 필드 추가 -->
  <input type="hidden" id="no" value="${question.no}">

  <div class="mb-3">
    <label for="id" class="form-label">답변상태:</label>
    <input type="text" id="category" class="form-control" value="${question.category}" readonly>
  </div>

  <div class="mb-3">
    <label for="id" class="form-label">작성자:</label>
    <input type="text" id="id" class="form-control" value="${question.id}" readonly>
  </div>
  <div class="mb-3">
    <label for="title" class="form-label">제목:</label>
    <input type="text" id="title" class="form-control" value="${question.title}">
  </div>
  <div class="mb-3">
    <c:choose>
      <c:when test="${question.idx == null}">
		    <label for="thisFile" class="form-label">첨부파일:</label><br>
		    <div id="thisFile" style="position: relative; width: 50%; display: none;">
		      <input type="hidden" id="thisName" value="${originFileName}">
		      <input type="text" id="fileName" class="form-control" value="${fileName}" readonly>
		      <button id="cancelButton" type="button" class="btn btn-link" style="position: absolute; top: 0; right: 0;">
		        <img alt="XButton" src="${CP}/resources/img/cancel.png" style="height: 25px;">
		      </button>
		    </div>
		    <label for="fileUpload" id="uploadLabel" class="btn btn-secondary">파일 선택</label>
		    <input id=fileUpload type="file" accept=".jpg, .jpeg, .png, .bmp, .tiff, .webp, .ico, .svg" style="display: none;">
		    <input type="hidden" id="idx">
      </c:when>
      <c:otherwise>
		    <label for="thisFile" class="form-label">첨부파일:</label><br>
		    <div id="thisFile" style="position: relative; width: 50%">
		      <input type="hidden" id="thisName" value="${originFileName}">
		      <input type="text" id="fileName" class="form-control" value="${fileName}" readonly>
		      <button id="cancelButton" type="button" class="btn btn-link" style="position: absolute; top: 0; right: 0;">
		        <img alt="XButton" src="${CP}/resources/img/cancel.png" style="height: 25px;">
		      </button>
		    </div>
		    <label for="fileUpload" id="uploadLabel" class="btn btn-secondary" style="display: none;">파일 선택</label>
		    <input id=fileUpload type="file" accept=".jpg, .jpeg, .png, .bmp, .tiff, .webp, .ico, .svg" style="display: none;">
		    <input type="hidden" id="idx">
      </c:otherwise>
    </c:choose>
  </div>
  <div class="mb-3">
    <label for="content" class="form-label">내용:</label>
    <textarea id="content" class="form-control">${question.content}</textarea>
  </div>
  <a href="/qna" role="button" class="btn btn-secondary">취소</a>
  <button type="button" id="btn-update" class="btn btn-primary" value="수정">수정</button>
</form>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/qna.js"></script>
</body>
</html>