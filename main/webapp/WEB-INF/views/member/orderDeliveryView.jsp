<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>주문배송</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<style>
	.orderInfo {
		display : none;
	}
	.text {
		font-size : 16px;
		margin : 0px;
		float : left;
		padding-top : 0px;
		border : 0;
	}
	#pimg {
		float : left;
	}
	/*popup*/
	.popup_layer {position:fixed;top:0;left:0;z-index: 10000; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.4); }
	/*팝업 박스*/
	.popup_box{position: relative;top:50%;left:50%; overflow: auto; height: 600px; width:500px;transform:translate(-50%, -50%);z-index:1002;box-sizing:border-box;background:#fff;box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-webkit-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-moz-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);}
	/*버튼영역*/
	.popup_box .popup_btn {display:table;table-layout: fixed;width:100%;height:70px;background:#ECECEC;word-break: break-word;}
	.popup_box .popup_btn a {position: relative; display: table-cell; height:70px;  font-size:17px;text-align:center;vertical-align:middle;text-decoration:none; background:#ECECEC;}
	.popup_box .popup_btn a:before{content:'';display:block;position:absolute;top:26px;right:29px;width:1px;height:21px;background:#fff;-moz-transform: rotate(-45deg); -webkit-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);}
	.popup_box .popup_btn a:after{content:'';display:block;position:absolute;top:26px;right:29px;width:1px;height:21px;background:#fff;-moz-transform: rotate(45deg); -webkit-transform: rotate(45deg); -ms-transform: rotate(45deg); -o-transform: rotate(45deg); transform: rotate(45deg);}
	.popup_box .popup_btn a.close_day {background:#5d5d5d;}
	.popup_box .popup_btn a.close_day:before, .popup_box .popup_btn a.close_day:after{display:none;}
	/*오버레이 뒷배경*/
	.popup_overlay{position:fixed;top:0px;right:0;left:0;bottom:0;z-index:1001;;background:rgba(0,0,0,0.5);}
	/*popup*/
</style>
<body>
<div style="float: top">
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<div style="float: left">
    <h1>주문/배송</h1>
    <table border="1">
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
            <td><a href="#" 
		    	onclick="javascript:openPop${dto.bco_ordernum}()">${dto.bco_order_name}</a>
		    </td>
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
            url : '/member/cancellationRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                   
                    window.location='/member/cancelExchangeRefund';
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
            url : '/member/exchangeRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    
                    window.location='/member/cancelExchangeRefund';
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
            url : '/member/refundRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    window.location='/member/cancelExchangeRefund';
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
            url : '/member/purchaseConfirmation',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                	
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
<script>
	function openPop${dto.bco_ordernum}() {
  	
		var queryString = 'bco_ordernum=${dto.bco_ordernum}';

		$.ajax({
		url : '/member/orderDetail',
			type : 'POST',
			data : queryString,
			success : function(data) {
				var text = "";
				for(var i=0; i<data.length; i++) {
					var bcg_price = data[i].bcg_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					var total_price = data[i].total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					text += '<img id="pimg" src="'+data[i].bcg_img+'" width="100" height="115">';
					text += '<p class="text">상품명 : '+data[i].bcg_name+'</p><br>';
					text += '<p class="text">금액 : <span>'+bcg_price+'</span>원</p><br>';
					text += '<p class="text">옵션 : '+data[i].bcd_option+'</p><br>';
					text += '<p class="text">수량 : '+data[i].bco_count+'</p><br>';
					text += '<p class="text">결제 금액 : <span>'+total_price+'</span>원</p><br>';
					if(data[i].bco_order_status == '구매확정') {
						text += '<form action="/member/reviewWrite">';
						text += '<input type="hidden" name="bcg_img" value="'+data[i].bcg_img+'">';
						text += '<input type="hidden" name="bcg_name" value="'+data[i].bcg_name+'">';
						text += '<input type="hidden" name="bcg_key" value="'+data[i].bcg_key+'">';
						text += '<input type="hidden" name="bcd_detailkey" value="'+data[i].bcd_detailkey+'">';
						text += '<input type="submit" value="리뷰쓰기">';
						text += '</form>';
					}
					text += '<hr>';
					console.log(text);
					$('#infoDiv').empty().append(text);
				}
				document.getElementById("popup_layer").style.display = "block";
			}
		});
	}
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
	<script>
    	function closePop() {
	        document.getElementById("popup_layer").style.display = "none";
	        $('#infoDiv').empty();
	    }
   	</script>
   	<div class="popup_layer" id="popup_layer" style="display: none;">
		<div class="popup_box">
		<!--팝업 컨텐츠 영역-->
			<div id="infoDiv">
				
			</div>
			<!--팝업 버튼 영역-->
			<div class="popup_btn" style="float: bottom; margin-top: 50px;">
				<a href="javascript:closePop();">닫기</a>
			</div>
		</div>
	</div>
</div>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
