<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
<script src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
<div id="orderDetailView주문번호">
	<c:forEach items="${orderDetail}" var="order">
		<img style="float : left" src="${order.bcg_img}" width="50" height="100">
		<p class="text">상품명 : ${order.bcg_name }</p><br>
		<p class="text">금액 : ${order.bcg_price }</p><br>
		<p class="text">옵션 : ${order.bcd_option }</p><br>
		<p class="text">수량 : ${order.bco_count }</p><br>
		<p class="text">결제 금액 : ${order.total_price }</p><br>
		<c:if test="${order.bco_order_status == '구매확정'}">
		   <form action="/member/">
				<input type="hidden" name="bcg_key" value="${order.bcg_key }">
				<input type="hidden" name="bcd_detailkey" value="${order.bcd_detailkey }">
				<input type="submit" value="리뷰쓰기">
			</form>
		</c:if>
		<c:if test="${order.bco_order_status == '배송완료'}">
		   <button onclick="javascript:window.location = '/member/orderDelivery'">구매확정 하러가기</button>
		</c:if>
		<hr>
	</c:forEach>
</div>
</body>
</html>