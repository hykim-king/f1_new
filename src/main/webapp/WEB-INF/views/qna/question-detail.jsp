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
                            <c:if test="${question.imageUrl != null}">
                                <input type="image" id="detailImage" src="${question.imageUrl}" style="width: 500px;">
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
    

        <!-- 답변 -->
        <div class="mb-5" id="answer-detail">
            <!-- 답변이 있는 경우 답변 내용을 표시 -->
            <c:if test="${answer != null}">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title mb-0">답변</h4>
                    </div>
                    <div class="row m-2">
                        <div class="col">
                            <p class="card-text"><b>작성자: ${user.id}</b>&emsp;( 작성일: ${answer.createDate} )
                                <c:if test="${answer.updateDate != null}">&ensp;( 최종 수정일: ${answer.updateDate} )</c:if>
                            </p>
                        </div>
                    </div>
                    <div class="row mx-2 mb-1">
                        <div class="col">
                            <div class="card">
                                <div class="card-body py-2">
                                    <p class="card-text">${answer.content}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 관리자일 경우에만 수정/삭제 버튼을 표시, 일반 유저일 경우 추가 여백을 부여 -->
                    <c:choose>
                        <c:when test="${user.grade == 2}">
                            <div class="row m-2 mt-1">
                                <div class="col-auto">
                                    <button type="button" id="btn-answer-update-form" class="btn"
                                            style="background-color: #DCDCDC;">수정</button>
                                    <button type="button" id="btn-answer-delete" class="btn"
                                            style="background-color: #DCDCDC;">삭제</button>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="mb-3"></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <!-- 답변이 없을 경우 관리자에게만 답변 등록 form을 보여줌 -->
        <c:if test="${answer == null && user.grade == 2 && question.category != 10}">
            <form id="answer-form" class="pb-0 mb-0">
                <div class="mb-5">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title mb-0">답변</h4>
                        </div>
                        <div class="mt-2 mb-2 mx-4">
                            <textarea class="form-control" id="answer-content"
                                      rows="5" placeholder="내용을 입력하세요."></textarea>
                        </div>
                        <div class="mb-2 mx-4">
                            <button type="reset" id="btn-answer-reset" class="btn btn-secondary">취소</button>
                            <button type="submit" id="btn-answer-save" class="btn"
                                    style="background-color: #DCDCDC;" value="등록">등록</button>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>

        <!-- 관리자일 경우에만 답변 수정 form 표시 -->
        <c:if test="${user.grade == 2}">
            <form id="answer-update-form" class="pb-0 mb-0"
                  style="display: none;">
                <div class="mb-5">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title mb-0">답변</h4>
                        </div>

                        <div class="row mt-2 mx-2">
                            <p for="update-id" class="card-text"><b>작성자: ${answer.id}</b></p>
                        </div>

                        <div class="mt-2 mb-2 mx-4">
                            <textarea class="form-control" id="answer-update-content"
                                      rows="5" placeholder="내용을 입력하세요.">${answer.content}</textarea>
                        </div>
                        <div class="mb-2 mx-4">
                            <a href="/qna/${question.no}" style="text-decoration: none; color: inherit;">
                              <button type="button" class="btn" style="background-color: #DCDCDC;">취소</button>
                            </a>
                            <button type="submit" id="btn-answer-updated" class="btn"
                                    style="background-color: #DCDCDC;" value="수정">완료</button>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>

    </div>

<!-- 부트스트랩 JS 및 Popper.js 추가 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/qna.js"></script>

</body>
</html>