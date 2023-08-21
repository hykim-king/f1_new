<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로드스캐너 - 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/qna.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4">Q&A 게시판</h1>

<%--    <form class="mb-3">--%>
<%--        <div class="input-group">--%>
<%--            <select name="searchType" class="form-select">--%>
<%--                <option value="title">제목</option>--%>
<%--                <option value="content">내용</option>--%>
<%--                <option value="both">제목 + 내용</option>--%>
<%--            </select>--%>
<%--            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요">--%>
<%--            <button type="submit" class="btn btn-primary">검색</button>--%>
<%--        </div>--%>
<%--    </form>--%>

    <form class="mb-3" name="searchFrm" action="/qna" method="get">
        <div class="row g-1 d-flex justify-content-between mt-3 mb-3">
            <div class="col-auto flex-fill justify-content-end d-flex">

                <!-- 분류 셀렉트 박스 -->
                <div class="col-auto mx-1">
                    <select name="category" id="category" class="form-select" style="border-color:secondary; outline:none; box-shadow:none;">
                        <option value="">전체</option>
                        <option value="10" ${category == 10 ? 'selected' : ''}>공지</option>
                        <option value="20" ${category == 20 ? 'selected' : ''}>답변완료</option>
                        <option value="30" ${category == 30 ? 'selected' : ''}>답변대기</option>
                    </select>
                </div>

                <!-- 검색 박스와 글쓰기 버튼을 포함한 레이아웃 -->
                <!-- 검색 셀렉트 박스 (오른쪽 정렬) -->
                <div class="col-auto">
                    <select name="searchType" class="form-select" style="border-color:secondary; outline:none; box-shadow:none;">
                        <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                        <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                        <option value="both" ${searchType == 'both' ? 'selected' : ''}>제목+내용</option>
                    </select>
                </div>

                <!-- 검색 박스 (우측 마진 추가) -->
                <div class="col-auto mx-1">
                    <div class="input-group">
                        <span class="input-group-text" id="basic-addon1">
                        <svg
                                xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                        </svg>
                        </span>
                        <input type="text" name="keyword" class="form-control" style="border-color:secondary; outline:none; box-shadow:none;" placeholder="검색어를 입력하세요">
                    </div>
                </div>
                <div>
                    <button type="submit" class="btn btn-secondary">검색</button>
                </div>
            </div>
        </div>
    </form>


   <table class="table table-hover">
       <thead class="table-group-divider" style="border-color: #DCDCDC;">
           <tr>
               <th class="text-center">번호</th>
               <th class="text-center">분류</th>
               <th class="text-center">제목</th>
               <th class="text-center">작성자</th>
               <th class="text-center">작성일</th>
               <th class="text-center">조회수</th>
           </tr>
        </thead>
        <tbody class="table-group-divider" style="border-color: #DCDCDC;">
            <c:forEach items="${questions}" var="question">
                <c:choose>
                    <c:when test="${question.category == 10}">
                        <tr class="table" style="background-color: #F0F0F0;">
                            <td class="text-center">${question.no}</td>
                            <td class="text-center">
                            <span class="badge" style="background-color: #F87217; color: white;">공지</span></td>
                            <td><a href="/qna/${question.no}"
                                class="text-dark qna-link notice-title">${question.title}</a></td>
                            <td class="text-center">${question.id}</td>
                            <td class="text-center">${question.createDate}</td>
                            <td class="text-center">${question.views}</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td class="text-center">${question.no}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${question.category == 20}">
                                        <span class="badge"
                                            style="background-color: #024089; color: white;">답변완료</span>
                                    </c:when>
                                    <c:when test="${question.category == 30}">
                                        <span class="badge"
                                            style="background-color: #E0EAF5; color: black;">답변대기</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td><a href="/qna/${question.no}" class="text-dark qna-link">${question.title}</a></td>
                            <td class="text-center">${question.id}</td>
                            <td class="text-center">${question.createDate}</td>
                            <td class="text-center">${question.views}</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </tbody>
    </table>
    <!-- 글쓰기 버튼 -->
    <div class="d-flex justify-content-end">
        <a href="/qna/save" class="btn btn-outline-secondary my-1"
            role="button">글쓰기</a>
    </div>

    <!-- 페이징 -->
    <div class="pagination">
      <c:if test="${pagination.hasPrev}">
          <a href="?page=1&size=${pagination.size}&searchType=${searchType}&keyword=${keyword}&category=${category}">처음</a>
          <a href="?page=${pagination.startPage - 1}&size=${pagination.size}&searchType=${searchType}&keyword=${keyword}&category=${category}">이전</a>
      </c:if>
      <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
          <c:choose>
              <c:when test="${i == page}">
                  <span>${i}</span> <!-- 현재 페이지 -->
              </c:when>
              <c:otherwise>
                  <a href="?page=${i}&size=${pagination.size}&searchType=${searchType}&keyword=${keyword}&category=${category}">${i}</a>
              </c:otherwise>
          </c:choose>
      </c:forEach>
      <c:if test="${pagination.hasNext}">
          <a href="?page=${pagination.endPage + 1}&size=${pagination.size}&searchType=${searchType}&keyword=${keyword}&category=${category}">다음</a>
          <a href="?page=${pagination.totalPage}&size=${pagination.size}&searchType=${searchType}&keyword=${keyword}&category=${category}">마지막</a>
      </c:if>
    </div>
    <!-- // 페이징 end -->
</body>
</html>