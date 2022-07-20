<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단바</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<br>
	<div class="top">	
		<nav class="navbar navbar-expand-lg navbar-light">
			<a class="navbar-brand" onclick="/guest/mainHome"> 
				<img src="/image/red-heart.png" width="30" height="30" class="d-inline-block align-top" alt="">
				BestCosmetic
			</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">					
					<li class="nav-item active">
						<a class="nav-link" href="/mypageView">마이페이지</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" onclick="">로그아웃</a>
					</li>
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