<%@page import="com.roadscanner.domain.upload.FileUploadVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	FileUploadVO inVO = (FileUploadVO)request.getAttribute("inVO");
	int category = inVO.getCategory();
%>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>ImgManagement</title>
<style>
  .top-box {
    margin-top: 20px;
    margin-bottom: 10px;
  }
  .form-select:focus {
    box-shadow: none;
    border-color: #c1c1c1;
  }
  .btn-outline-danger {
    border-color: #E57373;
    color: #E57373;
  }
  .btn-outline-danger:hover {
    border-color: #E57373;
    background-color: #E57373;
  }
  .btn-dark {
    border-color: #616161;
    background-color: #616161;
  }
  .btn-dark:hover {
    border-color: #424242;
    background-color: #424242;  
  }
  .form-check-input {
    cursor: pointer; /* 커서 */
    width: 20px;
    height: 20px;
    margin-right: 7px;
  }
  .form-check-input:checked { /* 체크된 상태일 때 */
    border-color: #607D8B;
    background-color: #607D8B;
    box-shadow: none;
  }
  .form-check-input:not(:checked) { /* 체크 해제된 상태일 때 */
	  border-color: #dee2e6;
	  box-shadow: none;
  }
  .table-box {
    margin-top: 10px;
    margin-bottom: 10px;
  }
	.image-container {
    position: relative;
    display: inline-block;
	}
  .image-container:hover .uploaded-image {
    filter: brightness(40%);
  }
  .image-container.selected .uploaded-image {
    filter: brightness(40%);
  }
  .image-wrapper {
    margin: 0px 3px;
  }
	.uploaded-image {
	  display: block;
	  width: 300px;
    height: 200px;
	  object-fit: cover; /* 이미지를 부모 요소 크기에 맞게 확대/축소하며 가로 세로 비율을 유지 */
	  cursor: pointer;
	}
  .checkbox-local {
    position: absolute;
    top: 5px;
    left: 10px;
    z-index: 2;
    cursor: pointer;
  }
  .page-link {
	  color: #000;
  }
  .page-item.active .page-link {
		z-index: 1;
		color: white;
		border-color: #607D8B;
		background-color: #607D8B;
  }
  .page-link:focus, .page-link:hover {
    color: #000;
    box-shadow: none;
  }

  /*********************** 이미지 크게 보기 창(modal) CSS ***********************/
  .image-modal {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    z-index: 999;
    width: 1301px;
    height: 700px;
    max-width: 100%;
    max-height: 100%;
    display: none;
  }
  .btn-close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
  }
  .btn-close:focus {
    box-shadow: none;
  }
  .left {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 800px;
    height: 700px;
  }
  .right {
    overflow: auto; /* 스크롤  */
		display: flex;
		flex-direction: column; /* 내부의 요소들을 세로로 정렬 */
		justify-content: center; /* 수평 가운데 정렬 */
		align-items: center; /* 수직 가운데 정렬 */    
    width: 500px;
    height: 700px;
    padding-right: 30px;
  }
  .divider {
    width: 1px;
    background-color: #ccc;
    height: 100%;
  }
  .sort-horizon {
    display: flex;
  }
  .modalImage {
    max-width: 700px;
    max-height: 400px;
  }
  .overlay-modal {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background-color: rgba(0, 0, 0, 0.7); /* 반투명한 검은 배경 */
	  z-index: 998; /* 모달보다 아래에 위치 */
	  display: none;
	}
	.show-overlay {
	  display: block;
	}
</style>
</head>
<body>
  <div class="container" style="width:930px;">
    <div class="top-box d-flex justify-content-start">
	    <select class="form-select" id="categoryDropdown" name="category" style="width: 200px;">
	     <option value="0" <% if(0 == category) out.print("selected"); %>>전체</option>
	     <option value="10" <% if(10 == category) out.print("selected"); %>>기본</option>
	     <option value="20" <% if(20 == category) out.print("selected"); %>>좋아요</option>
	     <option value="30" <% if(30 == category) out.print("selected"); %>>싫어요</option>
	    </select>
    </div>
    
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
  </div> <!-- container end -->
    
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
			          </div> <!-- image-container end -->
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
	<!-- 페이징 -->

  
  <!----------------------------- 이미지 크게 보기 창 ----------------------------->
  <div class="overlay-modal" id="overlay-modal"></div>
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
	          <td>번호</td>
	          <td id="idx"></td>
	        </tr>
	        <tr>
	          <td>이름</td>
	          <td id="name"></td>
	        </tr>
	        <tr>
	          <td>업로더</td>
	          <td id="id"></td>
	        </tr>
	        <tr>
	          <td>날짜</td>
	          <td id="uploadDate"></td>
	        </tr>
	        <tr>
	          <td>크기</td>
	          <td id="fileSize"></td>
	        </tr>
	         <tr>
	          <td>상태</td>
	          <td id="category"></td>
	        </tr>
	        <tr>
	          <td>오류1</td>
	          <td id="u1"></td>
	        </tr>
	        <tr>
	          <td>오류2</td>
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
  
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>  
<script>
	// 체크박스 클릭 시 이미지에 스타일 추가
  $('.btn_check').on('change', function () {
    if ($(this).is(':checked')) {
      $(this).closest('.image-container').addClass('selected');
    } else {
      $(this).closest('.image-container').removeClass('selected');
    }
  });

	
	/* 전체 선택 */
	function toggleSelectAll() {
		let checkboxes = document.querySelectorAll(".btn_check");
		let selectAllBtn = document.getElementById("selectAllBtn");
		let checked = selectAllBtn.checked;
		
	  for (let i = 0; i < checkboxes.length; i++) {
		  checkboxes[i].checked = checked;
		  let imageContainer = checkboxes[i].closest('.image-container');
		  if (checked) {
		    imageContainer.classList.add('selected');
		  } else {
		    imageContainer.classList.remove('selected');
		  }
		} // for
	} // toggleSelectAll()


	/* 선택 삭제 */
	function selectDelete() {  	  
		let checkboxes = [];
		
		// 선택된 체크박스의 idx 추출
		$(".btn_check:checked").each(function() {
		  let name = $(this).attr("id");
		  checkboxes.push(name);
		});
	  console.log("checkboxes: " + checkboxes)
	  
		if (checkboxes.length === 0) {    
			alert("선택된 이미지가 없습니다.");
			return;
		}
	  
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				  type: "POST",
				  url:"${CP}/doDeleteMultiple",
				  asyn:"true",
				  traditional: true, // 배열 데이터 전송을 위해 traditional 옵션을 설정
			    data: { checkboxes: checkboxes },
				  success:function(data){//통신 성공
					  console.log("data: " + data)
			         if("1" == data) {
			           alert("삭제되었습니다.");
			           location.reload();
			         } else {
			           alert("삭제를 실패했습니다.");
			         }
				  },
				  error:function(data){//실패시 처리
				    console.log("error:"+data);
				  }
			}); // ajax
		} // if
	} // selectDelete()
 
	
	/* 선택 저장 */
	function selectSave() {
		let checkboxes = [];
	 
		// 선택된 체크박스의 idx 추출
		$(".btn_check:checked").each(function() {
			let name = $(this).attr("id")
			checkboxes.push(name);
		});
		console.log("checkboxes: " + checkboxes)
	 
		if (checkboxes.length === 0) {    
		    alert("선택된 이미지가 없습니다.");
		    return;
		}
	  
		if (confirm("저장하시겠습니까?")) {
			$.ajax({
			    type: "POST",
			    url:"${CP}/checkedUpdateMultiple",
			    asyn:"true",
			    traditional: true, // 배열 데이터 전송을 위해 traditional 옵션을 설정
			    data: { checkboxes: checkboxes },
			    success:function(data){ //통신 성공
			    	console.log("data: " + data)
			         if("1" == data) {
			           alert("수정되었습니다.");
			           location.reload();
			         } else {
			           alert("수정을 실패했습니다.");
			         }
			    },
			    error:function(data){ //실패시 처리
			      console.log("error:"+data);
			    }
			}); // ajax
		} // if
	} // selectSave()


$(document).ready(function() {

	/* 드롭다운으로 카테고리 선택 */
	$("#categoryDropdown").change(function() {  
		let selectedCategory = $(this).val();   
		window.location.href = "${CP}/imgManagement?pageNo=1&category=" + selectedCategory;
	}); // categoryDropdown()

/////////////////////////////////////////////////////////////////////////////////////

  let name; // 클릭한 이미지의 이름을 저장하는 변수 
  
	/* 모달 창 닫기 클릭 시 호출될 함수 등록 */
	$(document).on('click', '.btn-close', hideImageModal);
  
	/* esc 키 눌렀을 때 모달 창 닫기 */
	$(document).on('keydown', function (e) {
	  if (e.key === "Escape") {
	    hideImageModal();
	  }
	});
  
	/* 이미지 모달 숨기기 */
	function hideImageModal() {
		let modal = document.getElementById("imageModal");
		let overlay = document.getElementById("overlay-modal");
		modal.style.display = "none";
		overlay.classList.remove("show-overlay");
	} // hideImageModal()
  
	/* 이미지 모달 창 클릭 시 호출될 함수 등록 */
	$(document).on('click', '.uploaded-image', showModalOnClick);
  
	/* 이미지 모달 창 클릭 시 호출될 함수 */
	function showModalOnClick() {
	  let imageSrc = $(this).attr('src');
	  showImageModal(imageSrc);
	} // showModalOnClick()

  /* 이미지 크게 보기 창 보이기 */
  function showImageModal(imageSrc) {
    let modal = document.getElementById("imageModal");
    let modalImage = document.getElementById("modalImage");
    let overlay = document.getElementById("overlay-modal");
    
    modal.style.display = "block"; // 모달 창 보이기
    overlay.classList.add("show-overlay"); // 모달 창 밖 overlay 효과

    // 이미지 경로 설정에 context path 추가
    modalImage.src = imageSrc;

    // 이미지 상세 조회
    let firstIdx = imageSrc.lastIndexOf('/') + 1;
    let lastIdx = imageSrc.length;
    name = imageSrc.slice(firstIdx, lastIdx); // url에서 이름 추출

    $.ajax({
      type: "GET",
      url: "${CP}/doSelectOne",
      asyn: "true",
      dataType: "json",
      data: {
        name: name
      },
      success: function(data) { //통신 성공
    	  let category_val;
    	  if (data.category === 10) {
    		  category_val = "기본"
    	  } else if (data.category === 20) {
    		  category_val = "좋아요"
    	  } else if (data.category === 30) {
          category_val = "싫어요"
    	  }
      
        $("#idx").text(data.idx);
        $("#name").text(data.name);
        $("#id").text(data.id);
        $("#uploadDate").text(data.uploadDate);
        $("#fileSize").text(data.fileSize);
        $("#category").text(category_val);
        $("#u1").text((data.u1 === 0) ? "오류없음" : "오류있음");
        $("#u2").text((data.u2 === 0) ? "오류없음" : "오류있음");
      },
      error: function(data) { //실패시 처리
        console.log("error:" + data);
      }
    }); // ajax
  } // showImageModal()
  
  
  /* 상세보기 저장 */
  $('#detailSaveBtn').on('click', function() {
    if (confirm("저장하시겠습니까?")) {
      $.ajax({
        type: "POST",
        url: "${CP}/checkedUpdate",
        asyn: "true",
        dataType: "html",
        data: {
          name: name
        },
        success: function(data) { //통신 성공
          let parsedJson = JSON.parse(data);
          if ("1" == parsedJson.msgId) {
            alert(parsedJson.msgContents);
            hideImageModal();
            location.reload();
          } else {
            alert(parsedJson.msgContents);
          }
        },
        error: function(data) { //실패시 처리
          console.log("error:" + data);
        }
      }); // ajax
    } // if
  }); // detailSave()

  
  /* 상세보기 삭제 */
  $('#detailDeleteBtn').on('click', function() {
    if (confirm("삭제하시겠습니까?")) {
      $.ajax({
        type: "GET",
        url: "${CP}/doDelete",
        asyn: "true",
        dataType: "html",
        data: {
          name: name
        },
        success: function(data) { //통신 성공
          let parsedJson = JSON.parse(data);
          if ("1" == parsedJson.msgId) {
            alert(parsedJson.msgContents);
            hideImageModal();
            location.reload();
          } else {
            alert(parsedJson.msgContents);
          }
        },
        error: function(data) { //실패시 처리
          console.log("error:" + data);
        }
      }); // ajax
    } // if
  }); // detailDelete()
}); // document.ready
</script>
</body>
</html>