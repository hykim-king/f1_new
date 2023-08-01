<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>imgManagement</title>
<style>
  .grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 50px;
    max-width: 700px;
    margin: auto;
    margin-top: 130px;
    margin-bottom: 100px;
    position: relative;
  }
  .grid-item {
    width: 100%;
    padding-top: 100%;
    position: relative;
    overflow: hidden;
    padding-left: 60;
    padding-right: 60;
  }
  .grid-item img {
    position: absolute;
    top: 0;
    left: 0;
    width: 200px;
    object-fit: cover;
    cursor: pointer;
  }
  .checkbox-local {
    position: absolute;
    top: 5px;
    left: 5px;
    z-index: 2;
    cursor: pointer;
  }
  
  /* 체크박스 선택 시 액션 CSS */
  input.btn_check{
    display:none; /* 체크하기 전 버튼 숨김 */
    }
  input.btn_check + label{
    cursor:pointer; /* 커서 */
  }
  input.btn_check + label:before{ /* 체크하기 전 label CSS */
    content:"";
    font-size: 7px;
    text-align: center;
    display:inline-block;
    width:20px;
    height:20px;
    border:2px solid #212529;
    border-radius: 4px;
    position: absolute;
    left: 0;
    top:0;
  }
  input.btn_check:checked + label:before{ /* 체크 후 label CSS */
    content:"";
    background-color:#212529;
    border-color:#212529;
    background-image: url('${CP}/resources/img/checkmark.png');
    background-repeat: no-repeat;
    background-position: 50%;
    background-size: 16px 16px;
  }
  
    
  .delete-save-button {
    position: absolute;
    top: -75px;
    left: -5px;
    gap: 15px;
    padding: 10px;
    cursor: pointer;
    z-index: 3;
  }
  .select-all-button {
    position: absolute;
    top: -75px;
    left: 82%;
    padding: 10px;
    cursor: pointer;
    z-index: 3;
  }
  .modal-delete-save-button {
    gap: 15px;
    padding-bottom: 20px;
    cursor: pointer;
  }
  
  /* 이미지 크게 보기 창(modal) CSS */
  .image-modal {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    z-index: 999;
	  width: 1301px;
	  height: 800px;
	  max-width: 100%;
	  max-height: 100%;
	  display: none;
  }
  .image-modal-close {
    position: absolute;
    top: 3px;
    right: 3px;
    cursor: pointer;
  }
  .left {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 900px;
    height: 800px;
  }
  .right {
    overflow: auto;
    align-items: center;
    width: 400px;
    padding: 30px;
    height: 800px;
  }
  .divider {
    width: 1px;
    background-color: #ccc;
    height: 100%;
  }
  .sort-horizon {
    display: flex;
  }
</style>
</head>
<body>

  <div class="grid-container">
  
    <div class="delete-save-button">
      <button type="button" id="deleteButton1" class="btn btn-outline-danger" onclick="selectDelete()">DELETE</button>
      <button type="button" id="saveButton1" class="btn btn-dark" style="width: 200px;" onclick="selectSave()">SAVE</button>
    </div>
    <div class="select-all-button">
      <input type="checkbox" id="selectAllBtn" onclick="toggleSelectAll()" style="display: none;">
      <label for="selectAllBtn" class="btn btn-link" style="color: #212529;">SELECT_ALL</label>
    </div>
    
    <!-- 9*9 사진+체크박스 디스플레이 -->
	  <c:forEach var="i" begin="1" end="9">
	    <div class="grid-item">
	      <img src="${CP}/resources/img/selectButton.jpg" alt="Image${i}" onclick="showImageModal('${CP}/resources/img/selectButton.jpg')">
	      <div class="checkbox-local">
	        <input type="checkbox" class="btn_check" id="btn_check${i}">
	        <label for="btn_check${i}"></label>
	      </div>
	    </div>
	  </c:forEach>
	  
  </div>
  
  <!-- 이미지 크게 보기 창 -->
  <div class="image-modal" id="imageModal">
	  <div class="sort-horizon">
	    <div class="left">
		    <img src="" id="modalImage" style="max-width: 900px; max-height: 800px;">
		    <span class="image-modal-close" onclick="hideImageModal()">&times;</span>
	    </div>
	    <div class="divider"/>
	    <div class="right">
	      <p style="height: 650px;">이곳에 파일 정보를 입력하세요.</p>
	      <div class="modal-delete-save-button">
	        <button type="button" id="deleteButton2" class="btn btn-outline-danger" style="margin-left: 4px; height: 45px;" onclick="detailDelete()">DELETE</button>
	        <button type="button" id="saveButton2" class="btn btn-dark" style="width: 250px; height: 45px;" onclick="detailSave()">SAVE</button>
	      </div>
	    </div>
	  </div>
  </div>
  
<script>
  // SELECT_ALL 버튼 눌러 전체 선택
  function toggleSelectAll() {
    var checkboxes = document.querySelectorAll(".btn_check");
    var selectAllBtn = document.getElementById("selectAllBtn");
    var checked = selectAllBtn.checked;
    
    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i].checked = checked;
    }
  }
  
  // DELETE 버튼 눌러 삭제 후 새로고침
  function selectDelete() { //선택 삭제
    var checkboxes = document.querySelectorAll(".btn_check:checked");
    if (checkboxes.length === 0) {
      alert("선택된 이미지가 없습니다.");
      return;
    }
    
    if (confirm("삭제하시겠습니까?")) {
      alert("삭제되었습니다.");
      location.reload();
    }
  }
  
  function detailDelete() { //상세보기 삭제
	    if (confirm("삭제하시겠습니까?")) {
	      alert("삭제되었습니다.");
	      hideImageModal();
	    }
	  }
  
  // SAVE 버튼 눌러 저장 후 새로고침
  function selectSave() { //선택 저장
    var checkboxes = document.querySelectorAll(".btn_check:checked");
    if (checkboxes.length === 0) {
      alert("선택된 이미지가 없습니다.");
      return;
    }
    
    if (confirm("저장하시겠습니까?")) {
      alert("저장되었습니다.");
      location.reload();
    }
  }
  
  function detailSave() { //상세보기 저장
	    if (confirm("저장하시겠습니까?")) {
	      alert("저장되었습니다.");
	      hideImageModal();
	    }
	  }
  
  // 이미지 크게 보기 창 보이기
	function showImageModal(imageSrc) {
	  var modal = document.getElementById("imageModal");
	  var modalImage = document.getElementById("modalImage");
	
	  // 이미지 경로 설정에 context path 추가
	  modalImage.src = imageSrc;
	
	  modal.style.display = "block";
	}
  
  // 이미지 크게 보기 창 닫기
  function hideImageModal() {
    var modal = document.getElementById("imageModal");
    modal.style.display = "none";
  }
</script>
</body>
</html>