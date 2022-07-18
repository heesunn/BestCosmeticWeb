<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역 상세</title>
<style>
	.text {
		font-size : 10px;
		margin : 0px;
		float : left;
	}
</style>
</head>
<body>
<c:forEach items="${orderDetail}" var="order">
	<img style="float : left" src="${order.bcg_img}" width="50" height="100">
	<p class="text">상품명 : ${order.bcg_name }</p><br>
	<p class="text">금액 : ${order.bcg_price }</p><br>
	<p class="text">옵션 : ${order.bcd_option }</p><br>
	<p class="text">수량 : ${order.bco_count }</p><br>
	<p class="text">결제 금액 : ${order.total_price }</p><br>
	<hr>
</c:forEach>
</body>
</html>