<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
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
            <td><a href="#" 
		    	onclick="javascript:openPop${dto.bco_ordernum}()">${dto.bco_order_name}</a>
		    </td>
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
				<script>
					function openPop${dto.bco_ordernum}() {
		    	
						var queryString = 'bco_ordernum=${dto.bco_ordernum}';
	
						$.ajax({
		    				url : '/member/orderDetail',
		    				type : 'POST',
		    				data : queryString,
		    				success : function(data) {
		    					console.log(data.length);
		    					var text = "";
		    					for(var i=0; i<data.length; i++) {
		    						text += '<img id="pimg" src="'+data[i].bcg_img+'" width="100" height="115">';
		    						text += '<p class="text">상품명 : '+data[i].bcg_name+'</p><br>';
		    						text += '<p class="text">금액 : <span id="iprice">'+data[i].bcg_price+'</span>원</p><br>';
		    						text += '<p class="text">옵션 : '+data[i].bcd_option+'</p><br>';
		    						text += '<p class="text">수량 : '+data[i].bco_count+'</p><br>';
		    						text += '<p class="text">결제 금액 : <span id="itotalprice">'+data[i].total_price+'</span>원</p><br>';
		    						text += '<c:if test="'+data[i].bco_order_status+' == '+구매확정+'}">';
		    						text += '<form action="/member/">';
		    						text += '<input type="hidden" name="bcg_key" value="'+data[i].bcg_key+'">';
		    						text += '<input type="hidden" name="bcd_detailkey" value="'+data[i].bcd_detailkey+'">';
		    						text += '<input type="submit" value="리뷰쓰기">';
		    						text += '</form>';
		    						text += '</c:if>';
		    						text += '<c:if test="'+data[i].bco_order_status+' == '+배송완료+'}">';
		    						text += '<button>구매확정 하러가기</button>';
		    						text += '</c:if>';
		    						text += '<hr>';
		    						console.log(text);
		    						$('#infoDiv').empty().append(text);
		    					}
		    					var moneys = $('#iprice').text();
		    				    var moneys2 = moneys.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    				    $('#iprice').text(moneys2);
		    				    
		    				    var totalMoneys = $('#itotalprice').text();
		    				    var totalMoneys2 = totalMoneys.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    				    $('#itotalprice').text(totalMoneys2);
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
</body>
</html>
