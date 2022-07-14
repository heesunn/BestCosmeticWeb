<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function snsLogin(sns) {
	window.location = "/oauth2/authorization/"+sns;
}
function goLogin() {
	var queryString=$("#loginForm").serialize();
	$.ajax({
		type : 'post',
		url : 'j_spring_security_check',
		data : queryString,
		success : function(result) {
			console.log(result);
		},
		error : function(request, status, error) {
			console.log(error)
		}
	})
}
</script>
<body>
<h1>로그인 화면</h1>
<form id="loginForm">
	ID : <input type="text" name="j_username" value="${username }"><br>
	PW : <input type="text" name="j_password"><br>
	<input type="button" onclick="goLogin()" value="LOGIN"><br>
</form>
<button onclick="snsLogin('google')">Google Login</button><br>
<button onclick="snsLogin('facebook')">Facebook Login</button><br>
<button onclick="snsLogin('kakao')">Kakao Login</button><br>
<button onclick="snsLogin('naver')">Naver Login</button>
</body>
</html>
