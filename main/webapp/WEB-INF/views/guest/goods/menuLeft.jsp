<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- Bootstrap CSS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    
    <style>
        #cateoryLeft{
            width: 210px;
            white-space: nowrap;
        }
        
        a {
        	color: #000000;
        	font-size: 14px;
        }

    </style>
</head>
<body>

    <div id="cateoryLeft">
 <!-- 
 		<div class="container-fluid">
  			<div class="row flex-nowrap">
				<div class="col-3 bd-sidebar sidebar-light">
 -->
					<ul class="nav flex-column nav-light" >
							<li class="nav-item active">
								<a class="nav-link" href="/guest/categoryAll" id="sidebar">전체보기</a>
							</li>
							<br>
							
							<li class="nav-item active">
								<a class="nav-link" href="" id="sidebar">스킨케어</a>
							</li>
							
							<li class="nav-item active">
								<a class="nav-link" href="" id="sidebar">클렌징</a>
							</li>
							
							<li class="nav-item active">
								<a class="nav-link" href="" id="sidebar">선케어</a>
							</li>
							
							<li class="nav-item active">
								<a class="nav-link" href="" id="sidebar">베이스메이크업</a>
							</li>
		                    
							<li class="nav-item active">
								<a class="nav-link" href="/guest/categoryPoint" id="sidebar">포인트 메이크업</a>
							</li>
		                    
		                    <li class="nav-item active">
								<a class="nav-link" href="" id="sidebar">향수</a>
							</li>
		           </ul>
	</div>

</body>
</html>
