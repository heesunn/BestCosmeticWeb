<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	int bcm_num = 0;
	if(session.getAttribute("num")!=null) {
		bcm_num = (int)session.getAttribute("num");
	} else {
		bcm_num = 0;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script type="text/javascript">
	function upCount(ths) {
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());
	    var result =$input.val(Number(tCount)+1);
	}
	
	function downCount(ths) {
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());
	    var result = $input.val(Number(tCount)-1);
	}

	
	function inBag() {                 //장바구니
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {
			//장바구니에 넣기
			var queryString=$("#buyInfo").serialize();
            console.log(queryString);
			$.ajax({
            	url: '/member/addBag',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                complete: function(json) {
                	if(confirm("장바구니로 이동하시겠습니까?") == true) {        
                		window.location='/member/basketView';
              		} else {        
              			return ;    
             		}
                },
				
            });
		}
	}
	
	function goPayment() {             //바로 결제하기
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {
			var queryString = "keyList="+$('#BCG_KEY').val()+"&detailkeyList="+$('#BCD_DETAILKEY').val()+"&countList="+$('#BCB_COUNT').val();
			console.log(queryString);
			$.ajax({
				url : '/member/orderList',
				type : 'POST',
				data : queryString,
				dataType: 'json',
				success : function(json) {
					sessionStorage.setItem("orderList",JSON.stringify(json));
					window.location='/member/paymentView';
				}
			});
		}
	}
	
	function likeUpdate() {     //찜 업데이트
	   	var queryString=$("#list").serialize();
  		//var queryString = "BCM_NUM=" + $("#BCM_NUM").val();
  		//queryString = queryString + "&BCG_KEY=" + $("#key${dto.bcg_key }").val();
	    console.log(queryString);
	    $.ajax({
	    	url: '/member/glike',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'text',
	        success: function(json) {  
	        	window.location.reload;
	        }       	
	    });
	}
	

	
</script>
</head>
<body>
	<div style="float: top">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	<table border="1">
		<tr>
			<td colspan="2">포인트 메이크업</td>
		</tr>
		<tr>
			<td><img src="${BCG_IMG}"></td>
			<td>
				<table>
					<thead>
						<tr>
							<td colspan="3">${BCG_NAME}</td>
							<td>
								<form id="list" name="list">
					         		<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num %>">
					         		<input type="hidden" id="key" name="BCG_KEY" value="${BCG_KEY}">
					                <c:choose>
					                    <c:when test="${ (sessionScope.num) == null}">
					                    </c:when>
					                    <c:otherwise>
					                        <c:choose>
					                            <c:when test="${like == 0}">
					                                <input type="image" src="/image/heart.png" height="20" width="20" onclick ="likeUpdate()">
					                            </c:when>
					                            <c:otherwise>
					                                <input type="image" src="/image/red-heart.png" height="20" width="20" onclick ="likeUpdate()">
					                            </c:otherwise>
					                        </c:choose>
					                    </c:otherwise>
					                </c:choose>
					         	</form>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:choose>
								<c:when test="${BCG_DISCOUNT == 0}">
									<td colspan="4"><fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</td>
								</c:when>
								<c:otherwise>
									<td colspan="2">
										<p style="text-decoration:line-through">
											<fmt:formatNumber type="number" maxFractionDigits="0" 
											value="${BCG_PRICE/(100-BCG_DISCOUNT)*100}" pattern="#,###"/>
										</p>
									</td>
									<td colspan="2">-> <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<form id="buyInfo" name="buyInfo">
						<c:if test="${fn:length(list) != 1}">								
						<tr>
						    <td colspan="4">						    	
								<select id="BCD_DETAILKEY" name="BCD_DETAILKEY">
									<c:forEach items="${list}" var="ddtos">
										<option value="${ddtos.bcd_detailkey}">											
											${ddtos.bcd_option}
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						
						</c:if>	
						<c:if test="${fn:length(list) == 1}">								
						<tr>
						    <td colspan="4">						    	
								<input type="hidden" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="0">								
							</td>
						</tr>
						</c:if>										
						<tr>
							<td colspan="2">
				                <span onclick="downCount(this);"><i class="fas fa-arrow-alt-circle-down down"></i></span>
				                	<input type="text" id="BCB_COUNT" name="BCB_COUNT" 
				                           min="1" max="${BCG_STOCK}" size="2" maxlength="2" value="1" >
				                <span onclick="upCount(this);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
				            </td> 
							<td colspan="2">총 <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</td>				            
						</tr>				
						<tr>
						    <td colspan="4">
						    	<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num%>">
						    	<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">						    	
						    </td> 
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="장바구니" onclick="inBag()"></td>
							<td colspan="2"><input type="button" value="바로구매" onclick="goPayment()"></td>
						</tr>
						</form>
					</tbody>	
				</table>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td><button onclick="detail()">상세설명</button></td>
			<td><button onclick="review()">리뷰(개수)</button></td>
			<td><button onclick="qna()">문의(문의)</button></td>
		</tr>
		<tr><td colspan="3"><hr><td></tr>
	</table>
	<div id="goodsDetailView" style="display: block">
		<table class="activePage" id="activePage">
			<tr>
				<td><img src="${BCG_IMGDETAIL}"></td>
			</tr>
			<tr>
				<!-- <a href="https://www.flaticon.com/kr/free-icons/-" title="- 아이콘">- 아이콘  제작자: Smauj - Flaticon</a> -->
				<td><input type="image" src="/image/goTop.png" width="30" height="30" alt="맨위로" onClick="javascript:window.scrollTo(0,0)" /></td>
			</tr>
		</table>
	</div>
	<div id="reViewView" style="display: none">
		<h1>리뷰창</h1>
	</div>
	<div id="qnaView" style="display: none">
		<h1>문의</h1>
	</div>
<script>
	function review() {
		$("#reViewView").css({ 'display' : 'block' });
		$("#qnaView").css({ 'display' : 'none' });
		$("#goodsDetailView").css({ 'display' : 'none' });
	}

	function qna() {
		$("#qnaView").css({ 'display' : 'block' });
		$("#reViewView").css({ 'display' : 'none' });
		$("#goodsDetailView").css({ 'display' : 'none' });
	}

	function detail() {
		$("#goodsDetailView").css({ 'display' : 'block' });
		$("#qnaView").css({ 'display' : 'none' });
		$("#reViewView").css({ 'display' : 'none' });
	}
</script>
</body>
</html>