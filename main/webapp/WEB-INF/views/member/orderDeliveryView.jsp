<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<div>
    <c:import url="/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/mypageView"></c:import>
</div>
<div style="float: left">
    <h1>주문/배송</h1>
    <table width="500" cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td>주문번호</td>
            <td>주문금액</td>
            <td>주문정보</td>
            <td>주문상태</td>
            <td>주문변경</td>
        </tr>
        <c:forEach items="${list}" var="dto">
        <tr>
            <input type="hidden" id="ordernum${dto.bco_ordernum}"
                   name="bco_ordernum" value="${dto.bco_ordernum}">
            <td>${dto.bco_ordernum}</td>
            <td id="money${dto.bco_ordernum}">${dto.bco_totalprice}</td>
            <input id="realmoney${dto.bco_ordernum}" type="hidden" value="${dto.bco_totalprice}"/>
            <td>${dto.bco_order_name}</td>
            <td>${dto.bco_order_status}</td>
            <td>
                <c:if test="${dto.bco_order_status == '배송준비중'}">
                    <input type="button" value="취소신청" onclick="취소신청${dto.bco_ordernum}()"><br>
                    <input type="button" value="교환신청" onclick="교환신청${dto.bco_ordernum}()">
                </c:if>
                <c:if test="${dto.bco_order_status == '배송완료'}">
                    <input type="button" value="교환신청" onclick="교환신청${dto.bco_ordernum}()"><br>
                    <input type="button" value="반품신청" onclick="반품신청${dto.bco_ordernum}()"><br>
                    <input type="button" value="구매확정" onclick="구매확정${dto.bco_ordernum}()">
                </c:if>
            </td>
        </tr>

<script>
    function 취소신청${dto.bco_ordernum}() {
        console.log('취소신청');
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);

        $.ajax({
            url : '/cancellationRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    alert();
                    window.location='/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });


    }
    function 교환신청${dto.bco_ordernum}() {
        console.log('교환신청');
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/exchangeRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    alert();
                    window.location='/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
    function 반품신청${dto.bco_ordernum}() {
        console.log('반품신청')
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/refundRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    alert();
                    window.location='/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
    function 구매확정${dto.bco_ordernum}() {
        console.log("구매확정")
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/purchaseConfirmation',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    alert();
                    window.location='/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
</script>
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
                        <a href="orderDelivery?page=1">[ &lt;&lt; ]</a>
                    </c:otherwise>
                </c:choose>

                <!--이전-->
                <c:choose>
                    <c:when test="${(page.curPage-1) < 1}">
                        [ &lt; ]
                    </c:when>
                    <c:otherwise>
                        <a href="orderDelivery?page=${page.curPage-1}">[&lt;]</a>
                    </c:otherwise>
                </c:choose>

                <!--개별 페이지-->
                <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
                    <c:choose>
                        <c:when test="${page.curPage == fEach}">
                            [${fEach} ]&nbsp;
                        </c:when>

                        <c:otherwise>
                            <a href="orderDelivery?page=${fEach}">[${fEach}]</a>&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!--다음-->
                <c:choose>
                    <c:when test="${(page.curPage +1) > page.totalPage}">
                        [&gt;]
                    </c:when>
                    <c:otherwise>
                        <a href="orderDelivery?page=${page.curPage+1}">[&gt;]</a>
                    </c:otherwise>
                </c:choose>

                <!--끝-->
                <c:choose>
                    <c:when test="${page.curPage == page.totalPage}">
                        [&gt;&gt;]
                    </c:when>
                    <c:otherwise>
                        <a href="orderDelivery?page=${page.totalPage}">[&gt;&gt;]</a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

</div>
</body>
</html>
