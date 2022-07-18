<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.study.springboot.member.dto.MemberDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
welcome : Member
<hr>
<%
	int sNum = 0;
	String sName = "";
	String sEmail = "";
	String sId = "";
	if(session.getAttribute("num") != null) {
		sNum = (int) session.getAttribute("num");
		sId = (String) session.getAttribute("id");
		sName = (String) session.getAttribute("name");
		sEmail = (String) session.getAttribute("email");
	}
%>
회원 번호 : <%= sNum %><br>
회원 아이디 : <%= sId %><br>
회원 이름 : <%= sName %><br>
회원 이메일 : <%= sEmail %><br>

<sec:authorize access="isAuthenticated()">
	<a href="/logout">로그아웃</a>
	<a href="/member/orderDelivery">주문/배송조회</a>
	<a href="/member/cancelExchangeRefund">취소/교환/반품</a>
	<a href="/member/like">찜 목록</a>
	<a href="/member/modifyMember">회원정보수정</a>
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<a href="/guest/loginView">로그인</a>
	<a href="/guest/categoryPoint">카테고리포인트</a>
</sec:authorize>
</body>
</html>