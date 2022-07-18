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
</head>
<body>
<table>
	<tr>
		<td><div>Best코스메틱</div></td>
		<td><div>관리자 페이지</div></td>
		<td><div>관리자 <%=name %>님 <a href="/logout">(로그아웃)</a></div></td>
	</tr>
</table>
</body>
</html>