<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="${CP}/resources/js/jquery-3.7.0.js"></script>
<title>imgManagement</title>
<style>
  .grid-container {
	  display: grid;
	  grid-template-columns: repeat(3, 1fr);
	  gap: 10px;
	  max-width: 600px;
	  margin: auto;
	  margin-top: 100px;
  }
  .grid-item {
    width: 100%;
    padding-top: 100%;
    position: relative;
    overflow: hidden;
  }
  .grid-item img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
</style>
</head>
<body>
  <div class="grid-container">
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 1">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 2">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 3">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 4">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 5">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 6">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 7">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 8">
    </div>
    <div class="grid-item">
      <img src="${CP}/resources/img/selectButton.jpg" alt="Image 9">
    </div>
  </div>
</body>
</html>