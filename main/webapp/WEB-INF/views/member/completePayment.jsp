<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    int sNum = 0;
    String sName = "";
    String sEmail = "";
    String sId = "";
    String firstEmail = "";
    String secondEmail = "";
    if(session.getAttribute("num") != null) {
        sNum = (int) session.getAttribute("num");
        sId = (String) session.getAttribute("id");
        sName = (String) session.getAttribute("name");
        sEmail = (String) session.getAttribute("email");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>취소/교환/반품</title>
    <script src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
<div style="float: top">
    <c:import url="/guest/menuTop"></c:import>
</div>
<div>
    <div style="display:inline-block; background-color: #767b86;height: 100px;width: 200px;">
        <h2>장바구니</h2>
        <h6>주문하실 상품을 선택해주세요</h6>
    </div>
    <div style="display:inline-block;background-color: #767b86;height: 100px;width: 100px;">
        <h2>&gt;&gt;</h2>
    </div>
    <div style="display:inline-block;background-color: #767b86;height: 100px;width: 200px;">
        <h2>주문/결제</h2>
    </div>
    <div style="display:inline-block;background-color: #767b86;height: 100px;width: 100px;">
        <h2>&gt;&gt;</h2>
    </div>
    <div style="display:inline-block;background-color: #3c3f45;height: 100px;width: 200px;">
        <h2>주문완료</h2>
    </div>
</div>
<hr/>
<div>
    <table cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td>주문자
                <input type="hidden" id="sId" name="sId" value="<%= sName %>">
                <input type="hidden" id="orderNum" name="orderNum" value="${orderNum}">
            </td>
            <td id="sName"><%=sName %></td>
            <td id="sEmail"><%=sEmail %></td>
        </tr>
    </table>
</div>
<div>
    <h1 style="color: blue">주문 완료 되었습니다.</h1>
    <a href="/member/orderDelivery">주문내역 보기</a>
</div>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
