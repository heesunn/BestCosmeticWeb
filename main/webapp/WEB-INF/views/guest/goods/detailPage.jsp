<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	int bcm_num = 0;
	String bcm_name = ""; 
	if(session.getAttribute("num")!=null) {
		bcm_num = (int)session.getAttribute("num");
		bcm_name = (String)session.getAttribute("name");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script type="text/javascript">
	//수량버튼 +
	function upCount(ths) {            
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());	
	    if(${fn:length(list)}==1) {                     //상세옵션이 따로 없을 경우
		    var option = ${list.get(0).bcd_stock};	    //상세테이블 리스트의 0번 인덱스의 재고량. 걍 &{BCG_STOCK}으로 해도됨
	    	if(tCount==option) {
		    	alert("재고수량을 초과하였습니다.");
			    return;
	    	} else {
		    	var result = $input.val(Number(tCount)+1);
		    	sum(tCount+1);
		    }	
	    } else {                                        //상세옵션이 따로 있을 경우
	    	var index = $('#BCD_DETAILKEY').find("option:selected").data("nm");   //상세옵션중 선택된 옵션의 data-nm값(인덱스값)
	    	var option = ${list.get(index).bcd_stock};	                          //리스트 중 해당 인덱스의 재고량
	    	if(tCount==option) {
		    	alert("재고수량을 초과하였습니다.");
			    return;
	    	} else {
		    	var result = $input.val(Number(tCount)+1);
		    	sum(tCount+1);
		    }	
	    }    
	}
	
	//수량버튼 -
	function downCount(ths) {                
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());
	    if (tCount==1) {
	    	alert("수량은 1개 이하로 고를 수 없습니다.");
		    return;
	    } else {
	    	var result = $input.val(Number(tCount)-1);
	    	sum(tCount-1);
	    }
	}
	
	function sum(count) {                         //가격 총 합계
		var totalPrice = ${BCG_PRICE}*count;
		if(totalPrice > 999) {
			document.getElementById("totalPrice").innerHTML = thousandSeparatorCommas(totalPrice);
		} else {
			document.getElementById("totalPrice").innerHTML = "총 "+totalPrice+"원";
		}				
	}
	
	function thousandSeparatorCommas(number) {    //총 합계에 콤마찍기
		 var string = "" + number;                       // 문자로 바꾸기. 
		 string = string.replace( /[^-+\.\d]/g, "" )     // ±기호와 소수점, 숫자들만 남기고 전부 지우기. 
		 var regExp = /^([-+]?\d+)(\d{3})(\.\d+)?/;      // 필요한 정규식. 
		 while (regExp.test(string)) string = string.replace( regExp, "총 " + "$1" + "," + "$2" + "$3" + "원");  // 쉼표 삽입. 
		 return string; 
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
	
	function uploadQnA() {                 //문의하기
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {
			var queryString=$("#uploadQ").serialize();
            console.log(queryString);
			$.ajax({
            	url: '/member/uploadQnA',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                complete: function(json) {
                	alert("등록 완료");
                	window.location.reload;
                },				
            });
		}
	}
</script>
<style type="text/css">
	.starPoint {
	    font-size: 1em;
	    color: rgba(250, 208, 0, 0.99);
	}
</style>
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
									<td>
										<p style="text-decoration:line-through">
											<fmt:formatNumber type="number" maxFractionDigits="0" 
											value="${BCG_PRICE/(100-BCG_DISCOUNT)*100}" pattern="#,###"/>
										</p>
									</td>
									<td>-></td>
									<td colspan="2"><fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<form id="buyInfo" name="buyInfo">
						<c:if test="${fn:length(list) != 1}">								
						<tr>
						    <td colspan="4">						    	
								<select id="BCD_DETAILKEY" name="BCD_DETAILKEY">
									<c:forEach items="${list}" var="ddtos" varStatus="status">
										<option value="${ddtos.bcd_detailkey}" data-nm="${status.index}">											
											${ddtos.bcd_option} (남은수량 : ${ddtos.bcd_stock})
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
				                           	size="2" maxlength="2" value="1" readonly>
				                <span onclick="upCount(this);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
				            </td> 
							<td colspan="2"><div id="totalPrice">총 <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</div></td>				            
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
		<h1>리뷰창 : ${BCG_NAME}</h1>
		<table border="1">
			<c:if test="${reviewPage.totalCount==0}"> 
				<tr><td colspan="11">리뷰가 없습니다.</td></tr>
			</c:if> 
			<c:forEach items="${reviewList}" var="dto">			
			<tr class="starPoint">				
				<td> 
					<c:if test="${dto.bcr_score==0}">☆☆☆☆☆</c:if>
					<c:if test="${dto.bcr_score==1}">★☆☆☆☆</c:if>
					<c:if test="${dto.bcr_score==2}">★★☆☆☆</c:if>
					<c:if test="${dto.bcr_score==3}">★★★☆☆</c:if>
					<c:if test="${dto.bcr_score==4}">★★★★☆</c:if>
					<c:if test="${dto.bcr_score==5}">★★★★★</c:if>
				</td>
			</tr>
			<tr>				
				<td> ${dto.bcm_name} <fmt:formatDate value="${dto.bcr_date}" pattern="yyyy-MM-dd" var="bcr_date" />${bcr_date} </td>
			</tr>
			<tr>
				<c:if test="${dto.bcr_photo==null}"><td> ${dto.bcr_content} </td></c:if>
				<c:if test="${dto.bcr_photo!=null}">
					<td><img src="${dto.bcr_photo}" width="150" height="150"> </td>
					<td> ${dto.bcr_content} </td>							
				</c:if>			
			</tr>
			</c:forEach>
			<c:if test="${reviewPage.totalCount>0}"> 
			<tr>
				<td colspan="11">
					<!-- 처음 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage - 1) < 1}">
						[ &lt;&lt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=1">[ &lt;&lt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 이전 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage - 1) < 1}">
						[ &lt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.curPage - 1}">[ &lt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 개별 페이지 -->
					<c:forEach var="fEach" begin="${reviewPage.startPage}" end="${reviewPage.endPage}" step="1">
						<c:choose>
						<c:when test="${reviewPage.curPage == fEach}">
							[ ${fEach} ] &nbsp;
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${fEach}">[ ${fEach} ]</a> &nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>	
					
					<!-- 다음 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage + 1) > reviewPage.totalPage}">
						[ &gt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.curPage + 1}">[ &gt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 끝 -->
					<c:choose>
					<c:when test="${reviewPage.curPage == reviewPage.totalPage}">
						[ &gt;&gt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.totalPage}">[ &gt;&gt; ]</a>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div id="qnaView" style="display: none">
		<h1>문의창 : ${BCG_NAME}</h1>
		<table border="1">
			<c:if test="${questionPage.totalCount==0}"> 
				<tr><td colspan="11">문의가 없습니다.</td></tr>
			</c:if> 
			<form id="uploadQ" name="uploadQ">
			    <tr>
			    	<td>
			    		<textarea id="BCQ_CONTENT" name="BCQ_CONTENT" cols="50" rows="5"></textarea>
			    		<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">
						<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">
						<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num%>">
						<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="<%=bcm_name%>">
						<br>
						비밀글설정 <input type="checkbox" name="BCQ_SECRET" id="BCQ_SECRET">
	    			</td>
	    			<td><input type="button" value="등록" onclick="uploadQnA()"></td>
	    		</tr>
    		</form>
			<c:forEach items="${questionList}" var="dto">
				<c:if test="${dto.bca_content==null}"> <tr><td>답변대기중</td></tr> </c:if>
				<c:if test="${dto.bca_content!=null}"> <tr><td>답변완료</td></tr> </c:if>
				<tr> <td> ${dto.bcm_name} ${dto.bcq_date}</td> </tr>
				<c:if test="${dto.bcq_secret eq 'off'}">
					<tr> <td> ${dto.bcq_content} </td> </tr>
				</c:if>	
				<c:if test="${dto.bcq_secret eq 'on'}">
					<c:if test="${dto.bcm_name eq (sessionScope.name)}"> <tr> <td> ${dto.bcq_content} </td> </tr> </c:if>
					<c:if test="${dto.bcm_name ne (sessionScope.name)}"> <tr> <td> '비밀글입니다' </td> </tr>  </c:if>
				</c:if>	
				<c:if test="${dto.bca_content!=null}">
					<tr> <td>${dto.bca_date}</td> </tr>
					<tr> <td>${dto.bca_content}</td> </tr>
				</c:if>
			</c:forEach>
			<c:if test="${questionPage.totalCount>0}"> 
			<tr>
				<td colspan="11">
					<!-- 처음 -->
					<c:choose>
					<c:when test="${(questionPage.curPage - 1) < 1}">
						[ &lt;&lt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=1">[ &lt;&lt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 이전 -->
					<c:choose>
					<c:when test="${(questionPage.curPage - 1) < 1}">
						[ &lt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.curPage - 1}">[ &lt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 개별 페이지 -->
					<c:forEach var="fEach" begin="${questionPage.startPage}" end="${questionPage.endPage}" step="1">
						<c:choose>
						<c:when test="${questionPage.curPage == fEach}">
							[ ${fEach} ] &nbsp;
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${fEach}">[ ${fEach} ]</a> &nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>	
					
					<!-- 다음 -->
					<c:choose>
					<c:when test="${(questionPage.curPage + 1) > questionPage.totalPage}">
						[ &gt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.curPage + 1}">[ &gt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 끝 -->
					<c:choose>
					<c:when test="${questionPage.curPage == questionPage.totalPage}">
						[ &gt;&gt; ]
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.totalPage}">[ &gt;&gt; ]</a>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:if>
		</table>
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
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>