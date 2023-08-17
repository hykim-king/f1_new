<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로드스캐너</title>

<!-- 부트스트랩 CSS 추가 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<div class="container mt-5">
		<h1 class="mb-4">Q&A 게시판</h1>
		<div class="card mb-5">
			<input type="hidden" id="no" value="${question.no}">
			<div class="card-header">
				<h2 class="card-title mb-0">${question.title}</h2>
			</div>
			<div class="row m-2 mb-0">
				<div class="col-8">
					<div class="card">
						<div class="card-body py-2">
							<p class="card-text">작성자: ${question.id}</p>
						</div>
					</div>
				</div>
				<div class="col-4 d-flex justify-content-end">
					<div class="card">
						<div class="card-body py-2">
							<p class="card-text text-end">조회수: ${question.views}</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row m-2">
				<div class="col">
					<div class="card">
						<div class="card-body py-2">
							<p class="card-text" style="margin-bottom: 5px;">작성일: ${question.createDate}</p>
							<c:if test="${question.updateDate != null}">
								<p class="card-text">최종 수정일: ${question.updateDate}</p>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<!-- 선 추가 -->
			<div class="row mx-1">
				<div class="col">
					<hr style="margin: 1;">
				</div>
			</div>
			<div class="row m-2 mb-1">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<div class="badge text-secondary mb-2" style="background-color: #DCDCDC;">내용</div>
							<p class="card-text mt-2">${question.content}</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row m-2 mt-1">
				<div class="col-auto">
					<a href="/qna/update/${question.no}" class="btn" style="background-color: #DCDCDC;">수정</a>
					<button type="button" id="btn-delete" class="btn" style="background-color: #DCDCDC;">삭제</button>
				</div>
			</div>
		</div>

		<!-- 답변 내용 -->
		<c:if test="${question.category != 10}">
			<div class="card mb-5">
				<div class="card-body" id="answer-section">
					<c:choose>
						<c:when test="${answer == null}">
							<!-- 답변이 없을 경우 답변 등록 폼을 표시 -->
							<div class="mb-3">
								<form id="answer-form">
									<label for="id" class="form-label">작성자:</label>
									<!-- 나중에 관리자 session값 주고 readonly로 변경 예정 -->
									<input type="text" id="id" class="form-control">

									<textarea class="form-control" id="answer-content" rows="5"
										placeholder="답변을 입력하세요"></textarea>
									<a href="#" role="button" class="btn btn-secondary">취소</a>
									<button type="submit" id="btn-answer-save"
										class="btn btn-primary" value="저장">등록</button>
								</form>
							</div>
						</c:when>

						<c:otherwise>
							<!-- 답변이 있는 경우 답변 내용을 표시 -->
							<div class="mb-3" id="answer-detail">
								<p class="card-text">작성자: ${answer.id}</p>
								<!-- 나중에 관리자 session 가져올 예정 -->
								<p class="card-text">작성일: ${answer.createDate}</p>
								<c:if test="${answer.updateDate != null}">
									<p class="card-text">최종 수정일: ${answer.updateDate}</p>
								</c:if>
								<p class="card-text">내용: ${answer.content}</p>
								<button type="button" id="btn-answer-update-form"
									class="btn btn-light">수정</button>
								<button type="button" id="btn-answer-delete"
									class="btn btn-light">삭제</button>
							</div>
						</c:otherwise>
					</c:choose>

					<!-- 답변 수정 버튼을 누를 경우 답변 수정 form 표시 -->
					<div class="mb-3">
						<form id="answer-update-form" style="display: none;">
							<label for="update-id" class="form-label">작성자:</label> <input
								type="text" id="update-id" class="form-control"
								readonly="readonly" value="${answer.id}">
							<textarea class="form-control" id="answer-update-content"
								rows="5">${answer.content}</textarea>
							<a href="#" role="button" class="btn btn-secondary">취소</a>
							<button type="submit" id="btn-answer-updated"
								class="btn btn-primary" value="수정">완료</button>
						</form>
					</div>
				</div>
			</div>
		</c:if>
	</div>

	<!-- 부트스트랩 JS 및 Popper.js 추가 -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/qna.js"></script>

</body>
</html>