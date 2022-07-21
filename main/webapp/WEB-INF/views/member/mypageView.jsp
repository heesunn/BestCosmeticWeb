<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        #myPageDiv01{
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
    <div id="myPageDiv01">
        <h1>마이페이지</h1>
        <hr>
        <ul style="list-style-type: square">
            <li>
                주문
                <ul style="list-style-type: circle">
                    <li class="list" onclick="javascript:window.location='/member/orderDelivery'">주문/배송조회</li>
                    <li class="list" onclick="javascript:window.location='/member/cancelExchangeRefund'">취소/교환/반품</li>
                </ul>
            </li>
            <li>
                회원
                <ul style="list-style-type: circle">
                    <li class="list" onclick="javascript:window.location='/member/like'">찜 목록</li>
                    <li class="list" onclick="javascript:window.location='/member/modifyMemberView'">회원 정보 수정</li>
                    <li class="list" onclick="javascript:window.location='/member/passwordChange'">비밀번호 변경</li>
                    <li class="list" onclick="javascript:window.location='/member/out'">회원 탈퇴</li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>
