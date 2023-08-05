<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>

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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="${CP}/resources/js/jquery-3.7.0.js"></script>
    <title>회원 관리</title>
</head>
<body>
    <div class="container">
    
   
  <!-- 일반회원 --------------------------------------------------------------->
<form>    
        <!-- 제목 -->
        <div class="page-header">
            <h2 class="text-center">회원 관리</h2>
        </div>
        <!-- 제목 end --------------------------------------------------------------->


        <!-- 회원 정보 테이블 -->
        <table class="table table-hover" id="memberTable">
            <thead class="table-light">
                <tr>
                    <th class="text-center"></th>
                    <th class="text-center">NO</th>
                    <th class="text-center">아이디</th>
                    <th class="text-center">이메일</th>
                </tr>
            </thead>
            <tbody> 
                
                <c:forEach var="list" items="${list}">
                <c:set var="i" value="${1+i}"></c:set> 
                <c:set var="j" value="${(select-1)*5+i}"></c:set>    
                    <tr>
                        <td><input type="checkbox" name="delcheckbox" value ="${list.id}"></td>
                        <td class="text-center col-sm-1">${j}</td>
                        <td class="text-center col-sm-5">${list.id}</td>
                        <td class="text-center col-sm-6">${list.email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 회원 정보 테이블 end ------------------------------------------------------------>
        
        <!-- 검색 폼 -->
        <div class="row mb-3">
            <div class="col">
                    <div class="form-group">
                        <input type="text" id="searchid" name="keyword" class="form-control" placeholder="아이디 검색">
                    </div>
                    <button type="submit" id= "searchidbtn" class="btn btn-primary ml-2">검색</button>
                    <button type="button" id= "deletebtn" class="btn btn-primary ml-2">삭제</button>        
            </div>
        </div>
        <!-- 검색 폼 end ------------------------------------------------------------>

        <!-- pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
	            <c:if test="${page.prev}">
		            <li class="page-item"><a class="page-link" aria-label="Previous" href="/memberAdmin?num=${page.startPageNum - 5}">이전</a></li>
		        </c:if>
		        
		        <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">      
		              <c:if test="${select != num}">
		                <li class="page-item"><a class="page-link" href="/memberAdmin?num=${num}">${num}</a></li>
		              </c:if>
		              
		              <c:if test="${select == num}">
		                <li class="page-item"><a class="page-link" href="/memberAdmin?num=${num}">${num}</a></li>
		              </c:if>
		        </c:forEach>
		        
		        <c:if test="${page.next}">  
		            <li class="page-item"><a class="page-link" href="/memberAdmin?num=${page.endPageNum + 1}">다음</a></li>
		        </c:if>
                
            </ul>
        </nav>
        <!-- pagination end ------------------------------------------------------->
    
  </form>
 
   <!-- 일반회원 end--------------------------------------------------------------->    
     
        
  
<!-- container end ------------------------------------------------------------------->
    </div>
</body>
<script>
$("#searchidbtn").on("click",function(){
	let keyword = $("#searchid").val();
	console.log(keyword);

	location.href = "/memberAdmin?num=1"+ "&keyword=" + keyword;
	});
</script>

<script>
$("#deletebtn").on("click",function(){
	console.log("haha");
	
	$("input[name='delcheckbox']").each(function(){
	    if( $(this).is(":checked") == true ){
	      var tmpVal = $(this).val();
	      console.log(tmpVal);
	      
		      // AJAX 요청을 보냅니다.
		          $.ajax({
		              type: "POST",
		              url:"${CP}/withdraw",
		              dataType:"html",
		              data: {
		              id: tmpVal
		              },
		              success:function(data) {
		               let parsedJSON = JSON.parse(data);
		                 
		                   if("10" == parsedJSON.msgId){
		                	  $('#messagebox').attr('value', parsedJSON.msgContents);
		                	  location.reload();
		                  } 
		                                        
		                  if("20" == parsedJSON.msgId){
		                	  $('#messagebox').attr('value',parsedJSON.msgContents);
		                	  location.reload();
		                  }
		              },
		              error: function(data) {
		                  console.log("error:" + data);
	              }
	          }); // --ajax
	       
	    }
	  }); //--체크박스 체크
	location.reload();
});
</script>          
</html>
