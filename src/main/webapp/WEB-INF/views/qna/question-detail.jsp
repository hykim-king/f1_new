<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>로드스캐너</title>

    <!-- 부트스트랩 CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container mt-4">
        <h1 class="mb-4">Q&A 게시판</h1>
        <div class="card mb-5">
            <input type="hidden" id="no" value="${question.no}">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                        <h2 class="card-title mb-0 me-auto">${question.title}</h2>
                        <h6 class="card-title mb-0">조회수: ${question.views}</h6>
                    </div>
                </div>

                <div class="row m-2 mb-0">
                    <div class="col">
                        <p class="card-text"><b>작성자: ${question.id}</b>&emsp;( 작성일: ${question.createDate} )
                        <c:if test="${question.updateDate != null}">&ensp;( 최종 수정일: ${question.updateDate} )</c:if>
                        </p>
                    </div>
                </div>
                <div class="row m-2">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <c:if test="${question.idx != null}">
                                    <input type="image" id="detailImage" src="${img}" style="width: 500px;">
                                </c:if>
                                <p class="card-text">${question.content}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mx-2 mb-2">
                    <div class="col-auto">
                        <a href="/qna/update/${question.no}" class="btn"
                            style="background-color: #DCDCDC;">수정</a>
                        <button type="button" id="btn-delete" class="btn"
                            style="background-color: #DCDCDC;">삭제</button>
                    </div>
                    <div class="col-auto ms-auto">
                        <a href="/qna" class="btn btn-primary">목록</a>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <!-- 답변 -->
    <c:if test="${user.grade == 2}">
        <!-- 관리자일 경우 답변 등록 폼 노출 -->
        <c:if test="${question.category != 10}">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title mb-0">답변</h4>
                </div>
                <div class="card-body" id="answer-section">
                    <c:choose>
                        <c:when test="${answer == null}">
                            <!-- 답변이 없을 경우 답변 등록 폼을 표시 -->
                                <form id="answer-form"  class="pb-0 mb-0">
                                    <div class="d-flex align-items-center mx-4">
                                        <label for="id" class="form-label">작성자:</label>
                                        <input type="text" id="id" class="form-control" value="${user.id}" readonly="readonly">
                                    </div>
                                    <div class="mb-2 mx-4">
                                        <textarea class="form-control" id="answer-content" rows="5" placeholder="답변을 입력하세요"></textarea>
                                    </div>
                                </form>
                                <div class="mb-2 mx-4">
                                    <button type="submit" id="btn-answer-save" class="btn"
                                        style="background-color: #DCDCDC;" value="저장">등록</button>
                                    <button type="reset" id="btn-answer-reset" class="btn btn-secondary">취소</button
                                </div>
                            </div>
                        </c:when>

                        <c:otherwise>
                        <!-- 답변이 있는 경우 답변 내용을 표시 -->
                        <div class="row m-2">
                            <div class="col">
                            <div class="mb-3" id="answer-detail">
                                <p class="card-text">작성자: ${user.id} </b>&emsp;( 작성일: ${answer.createDate} )</p>
                                <c:if test="${answer.updateDate != null}">&ensp;( 최종 수정일: ${answer.updateDate} )</c:if>
                                <p class="card-text">내용: ${answer.content}</p>
                                <button type="button" id="btn-answer-update-form" class="btn btn-light">수정</button>
                                <button type="button" id="btn-answer-delete" class="btn btn-light">삭제</button>
                            </div>
                        </div>
                        </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- 답변 수정 버튼을 누를 경우 답변 수정 form 표시 -->
                    <div class="mb-3">
                        <form id="answer-update-form" style="display: none;">
                            <label for="update-id" class="form-label">작성자:</label>
                            <input type="text" id="update-id" class="form-control" readonly="readonly" value="${user.id}">
                            <textarea class="form-control" id="answer-update-content" rows="5">${answer.content}</textarea>
                            <a href="/qna/${question.no}" role="button" class="btn btn-secondary">취소</a>
                            <button type="submit" id="btn-answer-updated" class="btn btn-primary" value="수정">완료</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
    </c:if>
</div>

    <!-- 부트스트랩 JS 및 Popper.js 추가 -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/js/qna.js"></script></body>
</html>