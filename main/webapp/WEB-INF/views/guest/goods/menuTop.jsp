<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단바</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
		  integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
</head>
<body>
	<br>
	<div class="top">	
		<nav class="navbar navbar-expand-lg navbar-light">
			<a class="navbar-brand" href=""> 
				<img src="" width="30" height="30" class="d-inline-block align-top" alt="">
				BestCosmetic
			</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">					
					<li class="nav-item active">
						<a class="nav-link" href="/member/orderDelivery">마이페이지</a>
					</li>
					<sec:authorize access="isAuthenticated()">
					<li class="nav-item active">
						<a class="nav-link" onclick="javascript:window.location='/logout'">로그아웃</a>
					</li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<a class="nav-link" onclick="javascript:window.location='/guest/loginView'">로그인</a>
					</sec:authorize>
				</ul>
			</div>
		</nav>
		<div>		
			<form id="search_ck" name="search_ck" action="" class="form-inline my-2 my-lg-0">					
				<input class="form-control mr-sm-2" id="srch" name="srch" type="search"
					placeholder="전체 상품 검색" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" onclick="">Search</button>
			</form>
		</div>
	 
		<hr/>
</body>
</html>