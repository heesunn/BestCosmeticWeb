<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단바</title>
	<!-- Bootstrap CSS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	 <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
   
    <style>
    	a #myTop {
    		font-size:13px;
    	}
    	
    	div #logo {
    		font-size:30px;
    		font-weight: bold;
    	}
    </style>
   
</head>
<body>
	<br>
	<div class="top">	
		
			<nav class="navbar navbar-expand-lg navbar-light ">
				<div class="collapse navbar-collapse" >
					<form>
					<div>
						<a class="navbar-brand" href="/guest/mainHome" id="logo"> 
							<img src="/image/red-heart.png" width="40" height="40" class="d-inline-block align-top" alt="">
							BestCosmetic
						</a>
					</div>
					</form>
					<br>
					<form>
					<div>
						<ul class="navbar-nav mr-auto" >					
							<li class="nav-item active">
								<a class="nav-link" href="/guest/categoryAll">상품</a>
							</li>
							<li class="nav-item active">
								<a class="nav-link" href="">베스트</a>
							</li>
							<li class="nav-item active">
								<a class="nav-link" href="">신상</a>
							</li>
							<li class="nav-item active">
								<a class="nav-link" href="">특가</a>
							</li>
						</ul>
					</div>
					</form>
				</div>
				
				<div>
					<form class="form-inline my-2 my-lg-0">
					<div class="collapse navbar-collapse" id="navbarSupportedContent" >
						<ul class="navbar-nav mr-auto" >					
							<li class="nav-item active">
								<a class="nav-link" href="/member/mypageView" id="myTop">마이페이지</a>
							</li>
							<sec:authorize access="isAnonymous()">
							<li class="nav-item active">
								<a class="nav-link" href="/guest/loginView" id="myTop">로그인</a>
							</li>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
							<li class="nav-item active">
								<a class="nav-link" href="/logout" id="myTop">로그아웃</a>
							</li>
							</sec:authorize>
							<li class="nav-item active">
								<a class="nav-link" href="/member/basketView" id="myTop">장바구니</a>
							</li>
							<li class="nav-item active">
								<a class="nav-link" href="/member/like" id="myTop">찜</a>
							</li>
						</ul>
					</div>
					</form>
					<br>
					<form id="search_ck" name="search_ck" action="" class="form-inline my-2 my-lg-0">					
					<input class="form-control mr-sm-2" id="srch" name="srch" type="search"
						placeholder="전체 상품 검색" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" onclick="">Search</button>
					</form>
				</div>
			</nav>

	</div>
	 
	<hr/>
</body>
</html>