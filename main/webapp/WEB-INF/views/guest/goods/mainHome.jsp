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
body {
    padding-top: 120px;
    padding-bottom: 120px;
    background: #E6E6FA;
}
.main {
	background-color: #E6E6FA;
	margin-left:auto; 
    margin-right:auto;
}
.mdpick {
	text-align: center; 
	width: 300px;
	background-color: white;
}
.NnB {
	text-align: center; 
	width: 240px;
	background-color: white;
}
</style>
</head>
<body>
	<div class="menuTop" style="float: top">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	
	<table class="main">
		<tr>
			<td colspan="5">MDPICK</td>
		</tr>		
		<tr>
			<c:forEach items="${mdlist}" var="dto" begin="0" end="3">		
				<td class="mdpick"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="300" width="300">
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
						<img src="${dto.bcg_img}" height="240" width="240">
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
						<img src="${dto.bcg_img}" height="240" width="240">
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