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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<script type="text/javascript">
  	function form_check() {
  		if($('#srchText').val().length == 0) {
  			alert("검색어를 입력해주세요");
  			$('#srchText').focus();
  			return;
  		} else { sch(); }
  	}
  	
  	function sch() {     //검색기능
       var queryString=$("#search_ck").serialize();
   	console.log(queryString);
       $.ajax({
       	url: '/guest/guestSearch',  
           type: 'POST',
           data: queryString,
           dataType: 'text',
           success: function(json) {  
           	window.location.replace("/guest/searchARs");
           }       	
       });
   }
</script> 
<style>
   	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
   	div #logo {
   		font-size: 50px;
   		font-weight: bold;
   	}
   	.myNav {
		position: fixed;
		width: 100%;
		top: 0;
		background: #E6E6FA;
		font-family: 'tway_air';
		height: 40px;
	}
	.logoNav {
		position: fixed;
		width: 100%;
		top: 40px;
		background: #E6E6FA;
		font-family: 'tway_air';
		height: 150px;
	}
	div #navbarSupportedContent {
		font-size: 15px;
	}
	div #navbarScroll {
		font-size: 20px;
		background: #E6E6FA;
	}
</style> 
</head>
<body>
	<nav class="myNav navbar-expand-lg navbar-light">
		<div class="container" id="navbarSupportedContent" >
			<ul class="navbar-nav justify-content-end" >					
				<li class="nav-item">
					<a class="nav-link" href="/member/orderDelivery" id="myTopMyPage">마이페이지</a>
				</li>
				<sec:authorize access="isAnonymous()">
				<li class="nav-item">
					<a class="nav-link" href="/guest/loginView" id="myTopLogin">로그인</a>
				</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<a class="nav-link" href="/logout" id="myTopLogout">로그아웃</a>
				</li>
				</sec:authorize>
				<li class="nav-item">
					<a class="nav-link" onclick="javascript:window.location='/member/basketView'">
						장바구니
						<c:choose>
							<c:when test="${basketCount>0}">
								<span>(${basketCount})</span>
							</c:when>
							<c:otherwise>
								<span></span>
							</c:otherwise>
						</c:choose>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/member/like" id="myTop">찜</a>
				</li>
			</ul>
		</div>
	</nav>	
	<nav class="logoNav navbar-expand-lg navbar-light">		
	    <div class="container">
		    <a class="navbar-brand" href="/" id="logo"> 
				<img src="/image/logo.PNG" width="80" height="80" alt="">
				BestCosmetic
			</a>
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarScroll">
		        <ul class="navbar-nav me-auto navbar-nav-scroll">
					<li class="nav-item dropdown">
					    <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
							상품
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
							<li><a class="dropdown-item" href="/guest/categoryAll">전체보기</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">스킨케어</a></li>
							<li><a class="dropdown-item" href="#">클렌징</a></li>
							<li><a class="dropdown-item" href="#">선케어</a></li>
							<li><a class="dropdown-item" href="#">베이스 메이크업</a></li>
							<li><a class="dropdown-item" href="/guest/categoryPoint">포인트 메이크업</a></li>
							<li><a class="dropdown-item" href="#">향수</a></li>
						</ul>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="">베스트</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">신상</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">특가</a>
					</li>
		        </ul> 
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        <form id="search_ck" name="search_ck" action="" class="form-inline my-2 my-lg-0 justify-content-end">
					<input type="hidden" name="type" value="bcg_name">					
					<input class="form-control mr-sm-2" id="srchText" name="srchText" type="search"
						placeholder="전체 상품 검색" aria-label="Search"> &nbsp;
					<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="form_check()">Search</button>
				</form>
			</div>
	    </div>
	</nav>	
</body>
</html>