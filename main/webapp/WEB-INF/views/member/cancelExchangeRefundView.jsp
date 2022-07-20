<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<div style="float: left">
<h1>취소/교환/반품</h1>
    <table border="1">
        <tr>
            <td>주문번호</td>
            <td>주문금액</td>
            <td>주문정보</td>
            <td>주문상태</td>
            <td>접수일자</td>
        </tr>
    <c:forEach items="${list}" var="dto">
        <tr>
            <td>${dto.bco_ordernum}</td>
            <td id="money${dto.bco_ordernum}">${dto.bco_totalprice}</td>
            <input id="realmoney${dto.bco_ordernum}" type="hidden" value="${dto.bco_totalprice}"/>
            <td><a href="#" onclick="javascript:window.open('/member/orderDetail?bco_ordernum=${dto.bco_ordernum}', '주문내역 상세', 'width=400, height=300')">${dto.bco_order_name}</a></td>
            <td>${dto.bco_order_status}</td>
            <td><fmt:formatDate value="${dto.bco_statusdate}" pattern="yyyy-MM-dd HH:mm"/></td>
        </tr>
<script>
    var money = $('#money${dto.bco_ordernum}').text();
    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    $('#money${dto.bco_ordernum}').text(money2);
    //머니값체크 , 넣은거
    var moneyValCheck =  $('#money${dto.bco_ordernum}').text();
    console.log(moneyValCheck);
    //진짜 머니 , 없는거
    var realmoneyValCheck = $('#realmoney${dto.bco_ordernum}').val();
    console.log(realmoneyValCheck);

</script>
    </c:forEach>
        <tr>
            <td colspan="5">
                <!--처음-->
                <c:choose>
                    <c:when test="${(page.curPage-1)<1}">
                        [ &lt;&lt; ]
                    </c:when>
                    <c:otherwise>
                        <a href="cancelExchangeRefund?page=1">[ &lt;&lt; ]</a>
                    </c:otherwise>
                </c:choose>

                <!--이전-->
                <c:choose>
                    <c:when test="${(page.curPage-1) < 1}">
                        [ &lt; ]
                    </c:when>
                    <c:otherwise>
                        <a href="cancelExchangeRefund?page=${page.curPage-1}">[&lt;]</a>
                    </c:otherwise>
                </c:choose>

                <!--개별 페이지-->
                <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
                    <c:choose>
                        <c:when test="${page.curPage == fEach}">
                            [${fEach} ]&nbsp;
                        </c:when>

                        <c:otherwise>
                            <a href="cancelExchangeRefund?page=${fEach}">[${fEach}]</a>&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!--다음-->
                <c:choose>
                    <c:when test="${(page.curPage +1) > page.totalPage}">
                        [&gt;]
                    </c:when>
                    <c:otherwise>
                        <a href="cancelExchangeRefund?page=${page.curPage+1}">[&gt;]</a>
                    </c:otherwise>
                </c:choose>

                <!--끝-->
                <c:choose>
                    <c:when test="${page.curPage == page.totalPage}">
                        [&gt;&gt;]
                    </c:when>
                    <c:otherwise>
                        <a href="cancelExchangeRefund?page=${page.totalPage}">[&gt;&gt;]</a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
