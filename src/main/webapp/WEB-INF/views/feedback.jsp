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
        <td>0건</td>
      </tr>
      <tr>
        <td>결과 오류</td>
        <td>0건</td>
      </tr>
      <tr>
        <td>기타 등등</td>
        <td>0건</td>
      </tr>
    </tbody>
  </table>
  
  <div class="linechart">
    <canvas id="feedback_linechart"></canvas>
  </div>
  
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>
<script>
$.ajax({
  type: "GET",
  url:"/roadscanner/totalFeedback",
  asyn:"true",
  dataType:"html",
  data:{ 
  },
  success:function(data){//통신 성공
	  console.log("success data:"+data);
	  
	  // feedback_barchart
	  new Chart(document.getElementById("feedback_barchart"), {
		    type: 'bar',
		    data: {
		      labels: ['인식 오류', '결과 오류', '기타 등등'],
		      datasets: [{
		        data: [20, 15, 8],
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
		            callback: function(value) {
		              return value + '건';
		            }
		          }
		        }
		      }
		    }
		  }); // feedback_barchart
  },
  error:function(data){//실패시 처리
	  console.log("error:"+data);
  }
}); // ajax


  

new Chart(document.getElementById("feedback_linechart"), {
    type: 'line',
    data: {
      labels: ['1분기', '2분기', '3분기', '4분기'],
      datasets: [{
        data: [10, 8, 6, 2],
        label: 'feedback',
        borderColor: 'rgb(75, 192, 192)',
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
            callback: function(value) {
              return value + '건';
            }
          }
        }
      }
    }
  }); // feedback_linechart

</script>
</body>
</html>