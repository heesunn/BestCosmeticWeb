<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>

<style>
@font-face {
    font-family: 'tway_air';
    src: url('/tway_air.ttf') format('truetype');
}
body {
    padding-top: 190px;
    padding-bottom: 120px;
}
.main {
	background-color: #E6E6FA;
	margin-left:auto; 
    margin-right:auto;
	font-family: 'tway_air';
	border-spacing: 5px;
    border-collapse: separate;
}
.mdpick {
	text-align: center; 
	width: 300px;
	background-color: #E6E6FA;
}
.NnB {
	text-align: center; 
	width: 240px;
	background-color: #E6E6FA;
}
</style>
</head>
<body style="background-color: #E6E6FA;">
	<div class="menuTop" style="float: top">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	
	<table class="main">
		<tr>
			<td colspan="4">MDPICK</td>
		</tr>		
		<tr>
			<c:forEach items="${mdlist}" var="dto" begin="0" end="3">		
				<td class="mdpick"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">	
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">						
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>	
	</table>
	<table class="main">	
		<tr>
			<td colspan="5">BEST</td>
		</tr>		
		<tr>
			<c:forEach items="${blist}" var="dto" begin="0" end="4">		
				<td class="NnB"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>		
		<tr>
			<td colspan="5">NEW</td>
		</tr>		
		<tr>
			<c:forEach items="${nlist}" var="dto" begin="0" end="4">		
				<td class="NnB"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>			
	</table>	
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>