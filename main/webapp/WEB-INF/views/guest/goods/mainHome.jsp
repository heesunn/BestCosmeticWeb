<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
	int i = 0;
	int j = 4;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>

<script>
	function next() {
		<% 
			i = i+5;
			j = j+5;
		%>
	}
</script>
</head>
<body>
	<div style="float: top">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	
	<table border="1">
		<tr>
			<td colspan="5">MDPICK</td>
		</tr>		
		<tr>
			<c:forEach items="${list}" var="dto" begin="1" end="4">		
				<td> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="300" width="300">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>		
		<tr>
			<td colspan="5">BEST</td>
		</tr>		
		<tr>
			<td><input type='image' class='leftBtn' src='/image/leftBtn.png'></td>
			<c:forEach items="${list}" var="dto" begin="<%=i%>" end="<%=j%>">		
				<td> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="250" width="250">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
			<td><input type='image' class='rightBtn' src='/image/rightBtn.png' onclick="next()"></td>
		</tr>		
		<tr>
			<td colspan="5">NEW</td>
		</tr>		
		<tr>
			<td><input type='image' class='leftBtn' src='/image/leftBtn.png'></td>
			<c:forEach items="${list}" var="dto" begin="<%=i%>" end="<%=j%>">		
				<td> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="250" width="250">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
			<td><input type='image' class='rightBtn' src='/image/rightBtn.png' onclick="next()"></td>
		</tr>			
	</table>	
</body>
</html>