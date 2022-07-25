<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String name = (String)session.getAttribute("name");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Bootstrap CSS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	 <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	
	<style>
		#dd {
			float: right;
		}
	</style>
</head>
<body>
<div class="adminTop">
			<nav class="navbar navbar-expand-lg navbar-light ">
				<div class="collapse navbar-collapse" >
					<form>
						<a class="navbar-brand" href="/" > 
							BestCosmetic
						</a>
					</form>
					<br>
					<form class="my-2 my-lg-0">
					<div id="dd">
						<ul>					
							<li>
								<p>관리자 <%=name %>님<a class="nav-link" href="/logout">로그아웃</a></p>
							</li>
						</ul>
					</div>
					</form>
				</div>
			</nav>
	</div>
	<hr>
</body>
</html>