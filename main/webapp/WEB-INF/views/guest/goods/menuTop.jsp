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
	<script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
   	<script type="text/javascript">
   	function form_check() {
   		if($('#srchText').val().length == 0) {
   			alert("검색어를 입력해주세요");
   			$('#srchText').focus();
   			return;
   		}
   		sch();
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
    	a #myTop {
    		font-size:13px;
    	}
    	
    	div #logo {
    		font-size:30px;
    		font-weight: bold;
    	}
    	.menuTop {
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			background: #E6E6FA;
			font-weight: bold;
			height: 120px;
		}
    </style>
   
</head>
<body>
	<br>
	<div class="menuTop">
		<nav class="navbar navbar-expand-lg navbar-light ">
			<div class="collapse navbar-collapse" >
				<form>
				<div>
					<a class="navbar-brand" href="/" id="logo"> 
						<img src="/image/logo.PNG" width="50" height="50" class="d-inline-block align-top" alt="">
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
							<a class="nav-link" href="/member/orderDelivery" id="myTopMyPage">마이페이지</a>
						</li>
						<sec:authorize access="isAnonymous()">
						<li class="nav-item active">
							<a class="nav-link" href="/guest/loginView" id="myTopLogin">로그인</a>
						</li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
						<li class="nav-item active">
							<a class="nav-link" href="/logout" id="myTopLogout">로그아웃</a>
						</li>
						</sec:authorize>
						<li class="nav-item active">
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
						<li class="nav-item active">
							<a class="nav-link" href="/member/like" id="myTop">찜</a>
						</li>
					</ul>
				</div>
				</form>
				<br>
				
				<form id="search_ck" name="search_ck" action="" class="form-inline my-2 my-lg-0">
				<input type="hidden" name="type" value="bcg_name">					
				<input class="form-control mr-sm-2" id="srchText" name="srchText" type="search"
					placeholder="전체 상품 검색" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" onclick="form_check()">Search</button>
				</form>
			</div>
		</nav>
	</div>
</body>
</html>