<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
<script src="http://code.jquery.com/jquery.js"></script>
<style>
	#adminPageDiv01{
		background-color: black;
		width: 210px;
		color: white;
		height: 100%;
	}
	.list:hover{
		color: black;
		background-color: white;
		font-weight : bold;
	}
</style>
</head>
<body>
    <div id="adminPageDiv01">
        <h1>관리자페이지</h1>
        <hr>
        <ul style="list-style-type: square">
            <li>
                회원
                <ul style="list-style-type: circle">
                    <li class="list" >회원관리</li>
                </ul>
            </li>
            <li>
                주문관리
                <ul style="list-style-type: circle">
                    <li class="list" onclick="javascript:window.location = '/admin/deliveryReady'">배송준비</li>
                    <li class="list" onclick="javascript:window.location = '/admin/inTransit'">배송중</li>
                    <li class="list" onclick="javascript:window.location = '/admin/deliveryCompleted'">배송완료</li>
                    <li class="list" >취소/교환/반품</li>
                    <li class="list" onclick="javascript:window.location = '/admin/purchaseConfirmation'">구매확정</li>
                    <li class="list" >주문리스트</li>
                </ul>
            </li>
            <li>
                상품관리
                <ul style="list-style-type: circle">
                    <li class="list" onclick="javascript:window.location='/admin/goodsList'">상품리스트</li>
                    <li class="list" onclick="javascript:window.location='/admin/goodsAdd'">상품등록</li>
                    <li class="list" onclick="javascript:window.location='/admin/stockManager'">재고관리</li>
                </ul>
            </li>
            <li>
                게시물관리
                <ul style="list-style-type: circle">
                    <li class="list" >공지사항관리</li>
                    <li class="list" >리뷰관리</li>
                    <li class="list" >FAQ</li>
                    <li class="list" >채팅문의</li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>