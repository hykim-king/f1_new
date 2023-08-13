<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>Feedback</title>
<style>
	.barchart {
	  width: 60%
	}
	.linechart {
	  width: 60%
	}
	.feedback_table {
	  width: 60%;
	}
	table, th, td {
	  border: 1px solid #ccc;
	  border-collapse: collapse;
	  text-align: center;
	}
</style>
</head>
<body>
  <h2>Feedback</h2>
  <hr/>
  <h4>누적 오류</h4>
  <div class="barchart">
    <canvas id="feedback_barchart"></canvas>
  </div>
  
  <table class="feedback_table">
    <thead>
      <tr>
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
    </tbody>
  </table>
  
  <h4 style="margin-top:50px;">월별 오류</h4>
  
  <select id="monthDropDown" name="month">
    <option value="01">1월</option>
    <option value="02">2월</option>
    <option value="03">3월</option>
    <option value="04">4월</option>
    <option value="05">5월</option>
    <option value="06">6월</option>
    <option value="07">7월</option>
    <option value="08">8월</option>
    <option value="09">9월</option>
    <option value="10">10월</option>
    <option value="11">11월</option>
    <option value="12">12월</option>
  </select>
  
  <div class="linechart">
    <canvas id="feedback_linechart"></canvas>
  </div>
  
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>
<script>
$(document).ready(function() {
	
		// 누적 그래프, 표
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
		            'rgba(255, 99, 132, 0.2)',
		            'rgba(54, 162, 235, 0.2)',
		            'rgba(255, 206, 86, 0.2)',
		          ],
		          barThickness: 80
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
		    
	  },
	  error:function(data){//실패시 처리
		  console.log("error:"+data);
	  }
	}); // ajax

	
	
	// 월별 그래프
	
	// monthDropDown 현재 월에 해당하는 값으로 초기화
	let currentDate = new Date();
  let currentMonth = currentDate.getMonth() + 1; // 현재 날짜의 월을 가져옴 (0부터 시작하므로 +1 필요)
  $("#monthDropDown").val(currentMonth.toString().padStart(2, "0")); // 두 자리로 만들기 위해 0으로 패딩
  
  let currentYear = currentDate.getFullYear(); // 현재 연도
  let formattedDate = currentYear + '-' + currentMonth + '-01';
  
  let dateList = []; // 날짜 리스트
  let u1List = []; // 오류1 리스트
  let u2List = []; // 오류2 리스트
  
  // default 그래프
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
	              borderColor: 'rgb(75, 192, 192)',
	              fill: false,
	              tension: 0
	            },
	            {
	              data: u2List,
	              label: '결과오류',
	              borderColor: 'rgb(60, 20, 30)',
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

    
  // 초기화 시 그래프 표시
  defaultMonthlyGraph(formattedDate);
  
	// monthDropDown 선택 시 그래프 변화
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
	            borderColor: 'rgb(75, 192, 192)',
	            fill: false,
	            tension: 0
	          },
	          {
	            data: u2List,
	            label: '결과오류',
	            borderColor: 'rgb(60, 20, 30)',
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