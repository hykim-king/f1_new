<%@include file ="login/head.jsp" %>

<%@page import="com.roadscanner.domain.upload.FileUploadVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  FileUploadVO inVO = (FileUploadVO)request.getAttribute("inVO");
  int category = inVO.getCategory();

	// 서버 측에서 사용자 세션을 확인하고, 세션이 없으면 기본 페이지로 리다이렉트합니다.
	if (session.getAttribute("user") == null) {
	  response.sendRedirect("/login");
	}
%>
<%
	String strReferer = request.getHeader("referer");
	if(strReferer == null){
%>
	<script language="javascript">
	 alert("접속을 차단합니다.");
	 document.location.href="${CP}/login";
	</script>
<%
	return;
	}
%> 
<!DOCTYPE html>
<html>
<title>ImgManagement</title>

  <%@include file ="login/navbar.jsp" %>
  
<body id="font-id">
  <div class="container" style="width:930px;">
    <!-- 카테고리 선택 -->
    <div class="top-box d-flex justify-content-start">
      <select class="form-select" id="categoryDropdown" name="category" style="width: 200px;">
       <option value="0" <% if(0 == category) out.print("selected"); %>>전체</option>
       <option value="10" <% if(10 == category) out.print("selected"); %>>기본</option>
       <option value="20" <% if(20 == category) out.print("selected"); %>>좋아요</option>
       <option value="30" <% if(30 == category) out.print("selected"); %>>싫어요</option>
      </select>
    </div>
    <!-- 카테고리 선택 end -->
    
    <!-- 전체선택, 삭제버튼, 저장버튼 -->
    <div class="d-flex justify-content-between"">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="selectAllBtn" onclick="toggleSelectAll()">
        <label for="form-check-label">전체선택</label>
      </div>
      <div>
        <button type="button" id="selectDeleteBtn" class="btn btn-outline-danger" onclick="selectDelete()">DELETE</button>
        <button type="button" id="selectSaveBtn" class="btn btn-dark" style="width: 200px; margin-left: 10px" onclick="selectSave()">SAVE</button>
      </div>
    </div>
  </div>
  <!-- container end -->
    
  <!-- 3*3 사진+체크박스 디스플레이 -->
  <div class="table-box d-flex justify-content-center">
    <table>
      <c:choose>
        <c:when test="${not empty list}">
          <c:forEach var="vo" items="${list}" varStatus="status">
            <c:if test="${status.index % 3 == 0}">
              <tr>
            </c:if>
              <td>
                <div class="image-container">
                  <div class="checkbox-local">
                    <input type="checkbox" class="form-check-input btn_check" id="${vo.name}">
                    <label for="${vo.name}"></label>
                  </div>
                  <div class="image-wrapper">
                   <img class="uploaded-image" src="${vo.url}" alt="${vo.name}">
                  </div>
                </div>
                <!-- image-container end -->
              </td>
            <c:if test="${(status.index + 1) % 3 == 0 || status.last}">
              </tr>
            </c:if>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <td rowspan="3" colspan="3">No data found</td>
        </c:otherwise>
      </c:choose>
    </table>
  </div>
  
  <!-- 페이징 -->
  <ul class="pagination justify-content-center">
    <!-- 이전 페이지 버튼 -->
    <li class="page-item ${pageNo <= 1 ? 'disabled' : ''}">
      <a class="page-link" href="${CP}/imgManagement?pageNo=${pageNo - 1}&category=${category}">
        <span>&laquo;</span>
      </a>
    </li>
    
    <!-- 페이지 번호 -->
    <c:forEach begin="1" end="${totalPages}" var="pageNum">
      <li class="page-item ${pageNo == pageNum ? 'active' : ''} ${pageNo == pageNum ? 'disabled' : ''}">
        <a class="page-link" href="${CP}/imgManagement?pageNo=${pageNum}&category=${category}">${pageNum}</a>
      </li>
    </c:forEach>
    
    <!-- 다음 페이지 버튼 -->
    <li class="page-item ${pageNo >= totalPages ? 'disabled' : ''}">
      <a class="page-link" href="${CP}/imgManagement?pageNo=${pageNo + 1}&category=${category}">
        <span>&raquo;</span>
      </a>
    </li>
  </ul>
  <!-- 페이징 end -->
  
  <!-- 모달 창 바깥 불투명 검정 배경 -->
  <div class="overlay-modal" id="overlay-modal"></div>
  
  <!-- 모달 창 -->
  <div class="image-modal" id="imageModal">
    <div class="sort-horizon">
      <div class="left">
        <img src="#" class="modalImage" id="modalImage">
        <button type="button" class="btn-close"></button>
      </div>
      <div class="divider"></div>
      <div class="right">
        <table class="table" style="width: 350px;">
          <tr>
            <td class="fw-bold">번호</td>
            <td id="idx"></td>
          </tr>
          <tr>
            <td class="fw-bold">이름</td>
            <td id="name"></td>
          </tr>
          <tr>
            <td class="fw-bold">업로더</td>
            <td id="id"></td>
          </tr>
          <tr>
            <td class="fw-bold">날짜</td>
            <td id="uploadDate"></td>
          </tr>
          <tr>
            <td class="fw-bold">크기</td>
            <td id="fileSize"></td>
          </tr>
           <tr>
            <td class="fw-bold">상태</td>
            <td id="category"></td>
          </tr>
          <tr>
            <td class="fw-bold">오류1</td>
            <td id="u1"></td>
          </tr>
          <tr>
            <td class="fw-bold">오류2</td>
            <td id="u2"></td>
          </tr>
        </table>
        <div style="margin-top:20px;">
          <button type="button" id="detailDeleteBtn" class="btn btn-outline-danger">DELETE</button>
          <button type="button" id="detailSaveBtn" class="btn btn-dark" style="width:250px; margin-left:5px;">SAVE</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 모달 창  end -->
  
<script src="${CP}/resources/js/imgMng.js"></script></body>
</body>

  <%@include file ="login/footer.jsp" %>
  <link rel="stylesheet" href="${CP}/resources/css/imgManagement.css" >
  
</html>