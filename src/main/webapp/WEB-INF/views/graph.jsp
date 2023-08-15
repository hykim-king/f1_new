<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>Feedback Graph</title>
<style>
  h2 {
    margin: 20px;
  }
  .accordion-button {
    font-size: 20px;
    font-weight: bold;
    background-color: #F5F5F5;
    border: none;
  }
  .accordion-button:hover {
    background-color: #EEEEEE;
  }
  .accordion-button:not(.collapsed), .accordion-button:focus {
    background-color: #E0E0E0;
    border: none;
    color: black;
    box-shadow: none;
  }
  .accordion-item {
    border: none; /* 선 제거 */
  }
	.barchart {
	  width: 60%;
	  margin-bottom: 20px;
	}
	.form-select:focus {
    box-shadow: none;
    border-color: #c1c1c1;
  }
	.linechart {
	  width: 60%;
	  margin: 0 auto; /* 가운데 정렬 */
	}
</style>
</head>
<body>
	<div class="container">
	  <h2>Feedback</h2>
	  <div class="accordion accordion-flush" id="accordion">
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		               싫어요 피드백 누적 개수
		      </button>
		    </h2>
		    <div id="collapseOne" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		        <div class="d-flex justify-content-center align-items-center flex-column">
				      <div class="barchart">
						    <canvas id="feedback_barchart"></canvas>
						  </div>
						  <table class="table table-bordered text-center" style="width: 60%;">
						    <thead>
						      <tr class="table-secondary">
						        <th>분류</th>
						        <th>누적 개수</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr>
						        <td>인식 오류</td>
						        <td id="u1"></td>
						      </tr>
						      <tr>
						        <td>결과 오류</td>
						        <td id="u2"></td>
						      </tr>
						      <tr  class="table-light">
						        <td>전체</td>
						        <td id="total"></td>
						      </tr>
						    </tbody>
						  </table>
					  </div>
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
	                 월별 싫어요 피드백 개수 변화
		      </button>
		    </h2>
		    <div id="collapseTwo" class="accordion-collapse collapse">
		      <div class="accordion-body">
		          <div class="container" style="width:60%; margin-bottom:10px;">
				        <select class="form-select" id="monthDropDown" name="month" style="width:100px;">
							  </select>
						  </div>
						  <div class="linechart">
						    <canvas id="feedback_linechart"></canvas>
						  </div>
		      </div>
		    </div>
		  </div>
	  </div>
	</div>  

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>  
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>
<script>
$(document).ready(function() {
	
		/* 누적 그래프, 표 */
		$.ajax({
	  type: "GET",
	  url:"${CP}/totalFeedback",
	  asyn:"true",
	  dataType:"json",
	  data:{ 
	  },
	  success:function(data){//통신 성공
		  //console.log("success data:"+data);
		  //console.log("data.u1" + data.u1);
		  //console.log("data.u2" + data.u2);
		  
		  // feedback_barchart
		  new Chart(document.getElementById("feedback_barchart"), {
		      type: 'bar',
		      data: {
		        labels: ['인식 오류', '결과 오류'],
		        datasets: [{
		          data: [data.u1, data.u2],
		          label: 'feedback',
		          backgroundColor: [
		            '#C8E6C9',
		            '#BBDEFB',
		          ],
		          barThickness: 75
		        }]
		      },
		      options: {
		        plugins: {
		          legend: { display: false },
		          tooltip: {
		            mode: 'index',
		            intersect: false,
		          },
		          interaction: {
		            mode: 'nearest',
		            intersect: true
		          }
		        },
		        scales: {
		          y: {
		            beginAtZero: true,
		            display: true,
		            ticks: {
		            	stepSize: 1, // 눈금 간격 설정
		              callback: function(value) {
		                return value + '건';
		              }
		            }
		          }
		        }
		      }
		    }); // feedback_barchart
		    
		    $("#u1").text(data.u1 + "건");
		    $("#u2").text(data.u2 + "건");
		    
		    let total = parseInt(data.u1) + parseInt(data.u2);
		    $("#total").text(total + "건");
		    
	  },
	  error:function(data){//실패시 처리
		  console.log("error:"+data);
	  }
	}); // ajax

	
	
	/* 셀렉트박스, 월별 그래프 */
	let currentDate = new Date();
	let currentYear = currentDate.getFullYear(); // 현재 연도
  let currentMonth = currentDate.getMonth() + 1; // 현재 날짜의 월을 가져옴 (0부터 시작하므로 +1 필요)
  
  // 셀렉트박스 옵션을 현재 월까지로
  for (var i = 1; i <= currentMonth; i++) {
		let optionValue = (i < 10 ? "0" : "") + i; // 10보다 작으면 앞에 0붙임
		let optionText = i + "월";
		$("#monthDropDown").append($("<option>").attr("value", optionValue).text(optionText));
	}
  
  // 셀렉트박스 현재 월에 해당하는 값으로 초기화
  $("#monthDropDown").val(currentMonth.toString().padStart(2, "0")); // 두 자리로 만들기 위해 0으로 패딩
  
  // 현재 연도와 현재 월을 조합하여 날짜 문자열 생성 (예: "2023-08-01")
  let formattedDate = currentYear + '-' + currentMonth + '-01';
  let dateList = []; // 날짜 리스트
  let u1List = []; // 오류1 리스트
  let u2List = []; // 오류2 리스트
  
  // default 그래프 (현재 월에 해당하는 그래프)
  function defaultMonthlyGraph(uploadDate) {
	  $.ajax({
	      type: "GET",
	      url:"${CP}/monthlyFeedback",
	      asyn:"true",
	      dataType:"json",
	      data:{
	        uploadDate: formattedDate // 생성한 날짜 문자열을 전달
	      },
	      success:function(data){//통신 성공
	        //console.log("success data:"+data);    
	        for (var i = 0; i < data.length; i++) {
	          dateList.push(data[i].uploadDate);
	        }
	        for (var i = 0; i < data.length; i++) {
	          u1List.push(data[i].u1);
	        }
	        for (var i = 0; i < data.length; i++) {
	          u2List.push(data[i].u2);
	        }
	        
	        // 이전 차트 파괴
	        if (window.myChart) {
	            window.myChart.destroy();
	        }
	        // 새로운 차트 생성
	        let ctx = document.getElementById('feedback_linechart').getContext('2d');
	        window.myChart = new Chart(ctx, {
	          type: 'line',
	          data: {
	            labels: dateList,
	            datasets: [{
	              data: u1List,
	              label: '인식오류',
	              borderColor: '#C8E6C9',
	              fill: false,
	              tension: 0
	            },
	            {
	              data: u2List,
	              label: '결과오류',
	              borderColor: '#BBDEFB',
	              fill: false,
	              tension: 0
	            }]
	          },
	          options: {
	            plugins: {
	              legend: { display: false },
	              tooltip: {
	                mode: 'index',
	                intersect: false,
	              },
	              interaction: {
	                mode: 'nearest',
	                intersect: true
	              }
	            },
	            scales: {
	              y: {
	                display: true,
	                ticks: {
	                  stepSize: 1, // 눈금 간격 설정
	                  callback: function(value) {
	                    return value + '건';
	                  }
	                }
	              }
	            }
	          }
	        }); // feedback_linechart        
	      }, // success
	      error:function(data){//실패시 처리
	        console.log("error:"+data);
	      }
	    }); // ajax            
    } // defaultMonthlyGraph

    
  // 초기화 시 default그래프 표시
  defaultMonthlyGraph(formattedDate);
  
	// 셀렉트박스 선택 시 그래프 변화
	$("#monthDropDown").change(function() {
		// 선택한 월 값
		let selectedMonth = $("#monthDropDown").val();
        
		// 현재 연도와 선택한 월을 조합하여 날짜 문자열 생성 (예: "2023-08-01")
		let currentDate = new Date();
		let currentYear = currentDate.getFullYear(); // 현재 연도
		let formattedDate = currentYear + '-' + selectedMonth + '-01';
		
	  let dateList = []; // 날짜 리스트
	  let u1List = []; // 오류1 리스트
	  let u2List = []; // 오류2 리스트
	  
	  $.ajax({
	    type: "GET",
	    url:"${CP}/monthlyFeedback",
	    asyn:"true",
	    dataType:"json",
	    data:{
	    	uploadDate: formattedDate // 생성한 날짜 문자열을 전달
	    },
	    success:function(data){//통신 성공
	      //console.log("success data:"+data);    
	      for (var i = 0; i < data.length; i++) {
	        dateList.push(data[i].uploadDate);
	      }
	      for (var i = 0; i < data.length; i++) {
	        u1List.push(data[i].u1);
	      }
	      for (var i = 0; i < data.length; i++) {
	        u2List.push(data[i].u2);
	      }
	      
	      // 이전 차트 파괴
        if (window.myChart) {
            window.myChart.destroy();
        }
        // 새로운 차트 생성
        let ctx = document.getElementById('feedback_linechart').getContext('2d');
        window.myChart = new Chart(ctx, {
	        type: 'line',
	        data: {
	          labels: dateList,
	          datasets: [{
	            data: u1List,
	            label: '인식오류',
	            borderColor: '#C8E6C9',
	            fill: false,
	            tension: 0
	          },
	          {
	            data: u2List,
	            label: '결과오류',
	            borderColor: '#BBDEFB',
	            fill: false,
	            tension: 0
	          }]
	        },
	        options: {
	          plugins: {
	            legend: { display: false },
	            tooltip: {
	              mode: 'index',
	              intersect: false,
	            },
	            interaction: {
	              mode: 'nearest',
	              intersect: true
	            }
	          },
	          scales: {
	            y: {
	              display: true,
	              ticks: {
	                stepSize: 1, // 눈금 간격 설정
	                callback: function(value) {
	                  return value + '건';
	                }
	              }
	            }
	          }
	        }
	      }); // feedback_linechart
	      
	    }, // success
	    error:function(data){//실패시 처리
	      console.log("error:"+data);
	    }
	  }); // ajax
		 
	}); // monthDropDown
	
}); // document.ready
</script>
</body>
</html>