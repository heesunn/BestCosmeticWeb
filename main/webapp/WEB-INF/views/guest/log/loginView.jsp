<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
	if(session.getAttribute("num") != null) {
		response.sendRedirect("/");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function join() {
	window.location = '/guest/join';
}
function snsLogin(sns) {
	window.location = "/oauth2/authorization/"+sns;
}
</script>
<body>
<h1>로그인 화면</h1>
<form action="/loginDo" method="post">
	ID : <input type="text" name="j_username"><br>
	PW : <input type="password" name="j_password"><br>
	<h4>${message }</h4><br>
	<input type="submit" value="LOGIN"><br>
</form>
<button onclick="join()">회원가입</button><br>
<button onclick="snsLogin('google')">Google Login</button><br>
<button onclick="snsLogin('facebook')">Facebook Login</button><br>
<button onclick="snsLogin('kakao')">Kakao Login</button><br>
<button onclick="snsLogin('naver')">Naver Login</button>
</body>
</html>
