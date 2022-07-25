<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
<script src="http://code.jquery.com/jquery.js"></script>
 	<!-- Bootstrap CSS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<style>
	<style>
        #adminPageDiv01{
            width: 210px;
            white-space: nowrap;
        }
        
        a {
        	color: #000000;
        	font-size: 14px;
        }
	
</style>
</head>
<body>
    <div id="adminPageDiv01">
    <a href="/admin">관리자페이지</a>
    <br>
        <ul class="nav flex-column nav-light">
            <li>
                회원
                <ul>
                    <li class="nav-item active" onclick="javascript:window.location='/admin/memberManagement'">회원관리</li>
                </ul>
            </li>
            <li>
                주문관리
                <ul>
                    <li class="nav-item active">
                    	<a href='/admin/deliveryReady'>배송준비</a></li>
                    <li class="nav-item active">
                     	<a href='/admin/inTransit'></a>배송중</li>
                    <li class="nav-item active">
                    	<a href='/admin/deliveryCompleted'>배송완료</a></li>
                    <li class="nav-item active"> 
                    	<a href='/admin/cancelExchangeRefundAdmin'>취소/교환/반품</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/purchaseConfirmation'>구매확정</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/orderListAdmin'>주문리스트</a></li>
                </ul>
            </li>
            <li>
                상품관리
                <ul>
                    <li class="nav-item active" onclick="javascript:window.location='/admin/goodsList'">상품리스트</li>
                    <li class="nav-item active" onclick="javascript:window.location='/admin/goodsAdd'">상품등록</li>
                    <li class="nav-item active" onclick="javascript:window.location='/admin/stockManager'">재고관리</li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>