<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>로드스캐너 - 게시판 수정</title>
</head>
<body>
	<form class="container mt-5" id="question-edit-form">
		<!-- 이 부분에 히든 필드 추가 -->
		<input type="hidden" id="no" value="${question.no}">

		<div class="mb-3 row">
			<label for="id" class="col-sm-2 col-form-label">답변상태:</label>
			<div class="col-sm-10">
				<input type="text" id="category" class="form-control"
					value="${question.category}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="id" class="col-sm-2 col-form-label">작성자</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="id"
					value="${question.id}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="title" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="title"
					value="${question.title}">
			</div>
		</div>

		<div class="mb-3 row">
			<label for="idx" class="col-sm-2 col-form-label">첨부파일</label>
			<div class="col-sm-10">
				<input type="file" class="form-control" id="idx"
					value="${question.idx}">
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
				<textarea class="form-control" id="content" rows="10">${question.content}</textarea>
			</div>
		</div>

		<div class="text-center">
			<a href="/qna" role="button" class="btn btn-secondary">취소</a>
			<button type="button" id="btn-update" class="btn btn-primary"
				value="수정">수정</button>
		</div>

	</form>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/qna.js"></script>
</body>
</html>