<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로드스캐너</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/css/qna.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1>Q&A 게시판</h1>
	<form name="searchFrm">
	  <div class="row g-1 d-flex justify-content-between mt-3 mb-3">
	    <!-- 분류 셀렉트 박스 -->
	    <div class="col-auto">
	      <select class="form-select" name="category" id="category">
	        <option value="">--분류--</option>
	        <option value="공지">공지</option>
	        <option value="답변대기">답변대기</option>
	        <option value="답변완료">답변완료</option>
	      </select>
	    </div>
	    <!-- 검색 셀렉트 박스 (오른쪽 정렬) -->
	    <div class="col-auto flex-fill justify-content-end d-flex"> <!-- 검색 박스와 글쓰기 버튼을 포함한 레이아웃 -->
	      <div class="col-auto"> 
	        <select class="form-select" name="searchDiv" id="searchDiv">
	          <option value="">--전체--</option>
	          <option value="제목">제목</option>
	          <option value="내용">내용</option>
	          <option value="제목+내용">제목+내용</option>
	        </select>
	      </div>
	      <!-- 검색 박스 (우측 마진 추가) -->
	      <div class="col-auto"> 
	        <div class="input-group">
	          <span class="input-group-text" id="basic-addon1">
	            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
	            </svg>
	          </span>
	          <input type="text" class="form-control" id="searchWord" placeholder="검색어를 입력하세요.">
	        </div>
	      </div>
	    </div>
	  </div>
	</form>
    <table class="table table-hover">
        <thead>
        <tr>
            <th>번호</th>
            <th>분류</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${questions}" var="question">
            <c:choose>
                <c:when test="${question.category == 10}">
                    <tr class="table" style="background-color: #F0F0F0;">
                        <td>${question.no}</td>
                        <td><span class="badge" style="background-color: #F87217; color: white;">공지</span></td>
                        <td><a href="/qna/${question.no}" class="text-dark qna-link notice-title">${question.title}</a></td>
                        <td>${question.id}</td>
                        <td>${question.createDate}</td>
                        <td>${question.views}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td>${question.no}</td>
                        <td>
                            <c:choose>
                                <c:when test="${question.category == 20}">
                                    <span class="badge" style="background-color: #024089; color: white;">답변완료</span>
                                </c:when>
                                <c:when test="${question.category == 30}">
                                    <span class="badge" style="background-color: #E0EAF5; color: black;">답변대기</span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td><a href="/qna/${question.no}" class="text-dark qna-link">${question.title}</a></td>
                        <td>${question.id}</td>
                        <td>${question.createDate}</td>
                        <td>${question.views}</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        </tbody>
    </table>
    <!-- 글쓰기 버튼 -->
    <div class="d-flex justify-content-end">
        <a class="btn btn-outline-primary my-1" href="/qna/write">글쓰기</a>
    </div>
    <!-- 페이징 -->
    <div class="my-2">
	<nav aria-label="Page navigation">
	  <ul class="pagination justify-content-center" id="pagination">
	    <!-- 첫 페이지 버튼 -->
	    <li class="page-item ${page <= 1 ? 'disabled' : ''}">
	      <a class="page-link" href="${page > 1 ? '/qna?page=1&size=10' : '#'}" aria-label="First" style="background-color: #F0F0F0;">
	        <span aria-hidden="true">&laquo;&laquo;</span>
	      </a>
	    </li>
	    <!-- 이전 페이지 버튼 -->
	    <li class="page-item ${page <= 1 ? 'disabled' : ''}">
	      <a class="page-link" href="${page > 1 ? '/qna?page='.concat(page - 1).concat('&size=10') : '#'}" aria-label="Previous" style="background-color: #F0F0F0;">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <!-- 페이지 번호 -->
	    <c:forEach begin="1" end="${totalPages}" var="pageNum">
	      <li class="page-item ${page == pageNum ? 'active' : ''}">
	        <a class="page-link" href="/qna?page=${pageNum}&size=10">${pageNum}</a>
	      </li>
	    </c:forEach>
	    <!-- 다음 페이지 버튼 -->
	    <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
	      <a class="page-link" href="${page < totalPages ? '/qna?page='.concat(page + 1).concat('&size=10') : '#'}" aria-label="Next" style="background-color: #F0F0F0;">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	    <!-- 마지막 페이지 버튼 -->
	    <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
	      <a class="page-link" href="${page < totalPages ? '/qna?page='.concat(totalPages).concat('&size=10') : '#'}" aria-label="Last" style="background-color: #F0F0F0;">
	        <span aria-hidden="true">&raquo;&raquo;</span>
	      </a>
	    </li>
	  </ul>
	  <!-- 마지막 페이지 안내 메시지 -->
	  <c:if test="${page == totalPages}">
	    <p class="text-center">마지막 페이지입니다.</p>
	  </c:if>
	</nav>
	</div>
    <!-- // 페이징 end -->
</div>
    <script>
      const pagination = document.getElementById("pagination");
      const pageButtons = pagination.querySelectorAll(".page-item");
    
      pageButtons.forEach(button => {
        button.addEventListener("click", () => {
          pageButtons.forEach(btn => btn.classList.remove("active"));
          button.classList.add("active");
        });
      });
    </script>
</body>
</html>