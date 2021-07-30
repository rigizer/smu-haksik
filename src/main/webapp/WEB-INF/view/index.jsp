<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
	
	<title>index</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

	<style>
		body {
			font-family: 'Nanum Gothic', sans-serif;
		}
	</style>
	
	<script>
		$(document).ready(function() {
			$('#code').change(function() {
				$('form').submit();
			});
		});
	</script>
</head>
<body>
	<div class="container">
		<form method="GET" id="codeForm" action="./index">
			<select class="form-select mt-4 mb-4" id="code" name="code">
				<option value="GH001" <c:if test="${code eq 'GH001'}">selected</c:if>>65번가</option>
				<option value="GH002" <c:if test="${code eq 'GH002'}">selected</c:if>>학생회관 자율식당</option>
				<option value="GH006" <c:if test="${code eq 'GH006'}">selected</c:if>>학생회관 학생식당</option>
				<option value="GH007" <c:if test="${code eq 'GH007'}">selected</c:if>>세명학사 식당</option>
				<option value="GH008" <c:if test="${code eq 'GH008'}">selected</c:if>>예지학사 식당</option>
				<option value="GH010" <c:if test="${code eq 'GH010'}">selected</c:if>>세네뜨리아</option>
			</select>
		</form>
	
		<table class="table">
			<c:if test="${!empty haksikList}">
				<c:forEach var="haksik" varStatus="i" items="${haksikList}">
					<tr>
						<c:if test="${code ne 'GH010'}">
							<c:if test="${i.index % 3 == 0}">
								<th colspan="2">${dateList[i.index / 3]}</th>
								</tr>
								<tr>
							</c:if>
							<td>
								<div class="card text-center">
									<div class="card-header">
										<h5>
											<c:if test="${i.index % 3 == 0}">아침</c:if>
											<c:if test="${i.index % 3 == 1}">점심</c:if>
											<c:if test="${i.index % 3 == 2}">저녁</c:if>
										</h5>
									</div>
									<div class="card-body">
										<p class="card-text">${haksik}</p>
									</div>
								</div>
							</td>
						</c:if>
						<c:if test="${code eq 'GH010'}">
							<th colspan="2">${dateList[i.index]}</th>
								</tr>
								<tr>
							<td>
								<div class="card text-center">
									<div class="card-header">
										<h5>종일</h5>
									</div>
									<div class="card-body">
										<p class="card-text">${haksik}</p>
									</div>
								</div>
							</td>
						</c:if>
					<tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty haksikList}">
				<tr>
					<td>(데이터가 없습니다)</td>
				</tr>
			</c:if>
		</table>
	</div>
</body>
</html>