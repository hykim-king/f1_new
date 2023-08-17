<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로드스캐너 - 게시판 등록</title>
</head>
<body>
<form class="container mt-5" id="question-form">
    <div class="mb-3">
        <label for="category" class="form-label">카테고리:</label>
        <select id="category" name="category" class="form-select">
            <option value="30" selected>답변 대기</option>
            <option value="20">답변 완료</option>
            <option value="10">공지</option>
        </select>
    </div>
    <div class="mb-3">
        <label for="id" class="form-label">작성자:</label>
        <input type="text" id="id" class="form-control">
    </div>
    <div class="mb-3">
        <label for="title" class="form-label">제목:</label>
        <input type="text" id="title" class="form-control">
    </div>
    <div class="mb-3">
        <label for="thisFile" class="form-label">첨부파일:</label><br>
		    <div id="thisFile" style="position: relative; width: 50%; display: none;">
		      <input type="text" id="fileName" class="form-control" readonly>
		      <button id="cancelButton" type="button" class="btn btn-link" style="position: absolute; top: 0; right: 0;">
		        <img alt="XButton" src="${CP}/resources/img/cancel.png" style="height: 25px;">
		      </button>
		    </div>
		    <label for="fileUpload" id="uploadLabel" class="btn btn-secondary" style=" width: 100%;">파일 선택</label>
        <input id=fileUpload type="file" accept=".jpg, .jpeg, .png, .bmp, .tiff, .webp, .ico, .svg" style="display: none;">
        <input type="hidden" id="idx">
        <input type="hidden" id="count" value="default">
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