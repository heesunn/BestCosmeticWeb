<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송준비</title>
<style>
	.stateButton {
		float : left;
		margin-top : 10px;
	}
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
<script src="http://code.jquery.com/jquery.js"></script>
<script>

// 출처 : http://tonks.tistory.com/79 
// 에러가 나온다면, 여기에 댓글을 남겨주세요. 


/* sortingNumber() : 숫자인 실수만으로 되어있을 때, 적용될 함수 */ 

function sortingNumber( a , b ){  

        if ( typeof a == "number" && typeof b == "number" ) return a - b; 

        // 천단위 쉼표와 공백문자만 삭제하기.  
        var a = ( a + "" ).replace( /[,\s\xA0]+/g , "" ); 
        var b = ( b + "" ).replace( /[,\s\xA0]+/g , "" ); 

        var numA = parseFloat( a ) + ""; 
        var numB = parseFloat( b ) + ""; 

        if ( numA == "NaN" || numB == "NaN" || a != numA || b != numB ) return false; 

        return parseFloat( a ) - parseFloat( b ); 
} 


/* changeForSorting() : 문자열 바꾸기. */ 

function changeForSorting( first , second ){  

        // 문자열의 복사본 만들기. 
        var a = first.toString().replace( /[\s\xA0]+/g , " " ); 
        var b = second.toString().replace( /[\s\xA0]+/g , " " ); 

        var change = { first : a, second : b }; 

        if ( a.search( /\d/ ) < 0 || b.search( /\d/ ) < 0 || a.length == 0 || b.length == 0 ) return change; 

        var regExp = /(\d),(\d)/g; // 천단위 쉼표를 찾기 위한 정규식. 

        a = a.replace( regExp , "$1" + "$2" ); 
        b = b.replace( regExp , "$1" + "$2" ); 

        var unit = 0; 
        var aNb = a + " " + b; 
        var numbers = aNb.match( /\d+/g ); // 문자열에 들어있는 숫자 찾기 

        for ( var x = 0; x < numbers.length; x++ ){ 

                var length = numbers[ x ].length; 
                if ( unit < length ) unit = length; 
        } 

        var addZero = function( string ){ // 숫자들의 단위 맞추기 

                var match = string.match( /^0+/ ); 

                if ( string.length == unit ) return ( match == null ) ? string : match + string; 

                var zero = "0"; 

                for ( var x = string.length; x < unit; x++ ) string = zero + string; 

                return ( match == null ) ? string : match + string; 
        }; 

        change.first = a.replace( /\d+/g, addZero ); 
        change.second = b.replace( /\d+/g, addZero ); 

        return change; 
} 


/* byLocale() */ 

function byLocale(){ 

        var compare = function( a , b ){ 

                var sorting = sortingNumber( a , b ); 

                if ( typeof sorting == "number" ) return sorting; 

                var change = changeForSorting( a , b ); 

                var a = change.first; 
                var b = change.second; 

                return a.localeCompare( b ); 
        }; 

        var ascendingOrder = function( a , b ){  return compare( a , b );  }; 
        var descendingOrder = function( a , b ){  return compare( b , a );  }; 

        return { ascending : ascendingOrder, descending : descendingOrder }; 
} 


/* replacement() */ 
 
function replacement( parent ){  
        var tagName = parent.tagName.toLowerCase(); 
        if ( tagName == "table" ) parent = parent.tBodies[ 0 ]; 
        tagName = parent.tagName.toLowerCase(); 
        if ( tagName == "tbody" ) var children = parent.rows; 
        else var children = parent.getElementsByTagName( "li" ); 

        var replace = { 
                order : byLocale(), 
                index : false, 
                array : function(){ 
                        var array = [ ]; 
                        for ( var x = 0; x < children.length; x++ ) array[ x ] = children[ x ]; 
                        return array; 
                }(), 
                checkIndex : function( index ){ 
                        if ( index ) this.index = parseInt( index, 10 ); 
                        var tagName = parent.tagName.toLowerCase(); 
                        if ( tagName == "tbody" && ! index ) this.index = 0; 
                }, 
                getText : function( child ){ 
                        if ( this.index ) child = child.cells[ this.index ]; 
                        return getTextByClone( child ); 
                }, 
                setChildren : function(){ 
                        var array = this.array; 
                        while ( parent.hasChildNodes() ) parent.removeChild( parent.firstChild ); 
                        for ( var x = 0; x < array.length; x++ ) parent.appendChild( array[ x ] ); 
                }, 
                ascending : function( index ){ // 오름차순 
                        this.checkIndex( index ); 
                        var _self = this; 
                        var order = this.order; 
                        var ascending = function( a, b ){ 
                                var a = _self.getText( a ); 
                                var b = _self.getText( b ); 
                                return order.ascending( a, b ); 
                        }; 
                        this.array.sort( ascending ); 
                        this.setChildren(); 
                }, 
                descending : function( index ){ // 내림차순
                        this.checkIndex( index ); 
                        var _self = this; 
                        var order = this.order; 
                        var descending = function( a, b ){ 
                                var a = _self.getText( a ); 
                                var b = _self.getText( b ); 
                                return order.descending( a, b ); 
                        }; 
                        this.array.sort( descending ); 
                        this.setChildren(); 
                } 
        }; 
        return replace; 
} 

function getTextByClone( tag ){  
        var clone = tag.cloneNode( true ); // 태그의 복사본 만들기. 
        var br = clone.getElementsByTagName( "br" ); 
        while ( br[0] ){ 
                var blank = document.createTextNode( " " ); 
                clone.insertBefore( blank , br[0] ); 
                clone.removeChild( br[0] ); 
        } 
        var isBlock = function( tag ){ 
                var display = ""; 
                if ( window.getComputedStyle ) display = window.getComputedStyle ( tag, "" )[ "display" ]; 
                else display = tag.currentStyle[ "display" ]; 
                return ( display == "block" ) ? true : false; 
        }; 
        var children = clone.getElementsByTagName( "*" ); 
        for ( var x = 0; x < children.length; x++){ 
                var child = children[ x ]; 
                if ( ! ("value" in child) && isBlock(child) ) child.innerHTML = child.innerHTML + " "; 
        } 
        var textContent = ( "textContent" in clone ) ? clone.textContent : clone.innerText; 
        return textContent; 
}
function checkSelectAll(event)  {
	  // 전체 체크박스
	const checkboxes = document.querySelectorAll('input[name="bco_ordernum"]');
	  // 선택된 체크박스
	const checked = document.querySelectorAll('input[name="bco_ordernum"]:checked');
	  // select all 체크박스
	const selectAll = document.querySelector('input[name="selectall"]');
	  
	if(checkboxes.length === checked.length)  {
		selectAll.checked = true;
	}else {
	  	selectAll.checked = false;
	}
}
function selectAll(selectAll)  {
	const checkboxes = document.getElementsByName('bco_ordernum');
	
	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked;
	})
}
function submit_state() {
	var queryString = $('#stateChangeTotalList').serialize();
	queryString += "&";
	queryString += $("input:checkbox[name=bco_ordernum]:checked").serialize();
	
	$.ajax({
		url : '/admin/stateChange',
		type : 'POST',
		data : queryString,
		success : function(data) {
			if(data == 'success'){
				alert("주문 상태가 변경되었습니다.");
				window.location.reload();
			}
			else {
				alert("데이터베이스 에러.");
			}
		}
	});
}
</script>
</head>
<body>
	<div style="float: top">
    	<c:import url="/admin/adminTop"></c:import>
	</div>
	<div style="float: left">
    	<c:import url="/admin/adminPageView"></c:import>
	</div>
	<h1>주문리스트</h1>
	<div>
		<form action="/admin/olSearch">
			<select name="searchType" id='serch'>
				<option value='bcm_name'>주문인</option>
				<option value='bco_recipient'>수령인</option>
				<option value='bco_ordernum'>주문번호</option>
				<option value='bco_order_status'>주문상태</option>
			</select>
			<input type="text" name="searchWord">
			<input type="submit" value="검색">
		</form>
		<button onclick="javascript:window.location = '/admin/orderListAdmin'">검색 초기화</button>
		<span>검색결과 : ${page.totalCount} 건</span>&nbsp;&nbsp;&nbsp;ㅣ <span>총결제금액 : <strong id="totalprice">${totalPrice }</strong></span>
		<script>
			var money = $('#totalprice').text();
			var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#totalprice').text(money2+"원");
		</script>
	</div>
	<div>
		<table id="myList" border="1">
	        <thead>
	        	<tr>
		        	<th><input type='checkbox' name='selectall' value='selectall' onclick='selectAll(this)'/></th>
		            <th>주문번호</th>
		            <th>주문일<button onclick="sortTD(2)">▲</button><button onclick="reverseTD(2)">▼</button></th>
		            <th>주문인<button onclick="sortTD(3)">▲</button><button onclick="reverseTD(3)">▼</button></th>
		            <th>수령인</th>
		            <th>결제총액<button onclick="sortTD(5)">▲</button><button onclick="reverseTD(5)">▼</button></th>
		            <th>주문내역</th>
		            <th>주문상태</th>
	            </tr>
	        </thead>
	        <tbody>
	    	<c:forEach items="${orderListAdmin}" var="list">
		        <tr>
		        	<td><input type='checkbox' name='bco_ordernum' value='${list.bco_ordernum}' onclick='checkSelectAll(event)'/></td>
		            <td>${list.bco_ordernum}</td>
		            <td><fmt:formatDate value="${list.bco_orderdate}" pattern="yyyy-MM-dd HH:mm"/></td>
		            <td>${list.bcm_name}</td>
		            <td>${list.bco_recipient}</td>
		            <td id="price${list.bco_ordernum}">${list.bco_totalprice}</td>
		            <td><a href="#" 
		            	onclick="openPop${list.bco_ordernum}()">${list.bco_order_name}</a>
		            </td>
		            <td>${list.bco_order_status}</td>
		        </tr>
		        <script>
				    var money = $('#price${list.bco_ordernum}').text();
				    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				    $('#price${list.bco_ordernum}').text(money2+"원");
				</script>
				<script>
					function openPop${list.bco_ordernum}() {
		    	
						var queryString = 'bco_ordernum=${list.bco_ordernum}';
	
						$.ajax({
		    				url : '/member/orderDetail',
		    				type : 'POST',
		    				data : queryString,
		    				success : function(data) {
		    					console.log(data.length);
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
		    						text += '<hr>';
		    						$('#infoDiv').empty().append(text);
		    					}
		    					document.getElementById("popup_layer").style.display = "block";
		    				}
						});
					}
	    		</script>
			</c:forEach>
	    	</tbody>
	        <tr>
	            <td colspan="8">
	                <!--처음-->
	                <c:choose>
	                    <c:when test="${(page.curPage-1)<1}">
	                        [ &lt;&lt; ]
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${page.searchType == null }">
	                        	<a href="orderListAdmin?page=1">[ &lt;&lt; ]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="olSearch?page=1&searchType=${page.searchType}&searchWord=${page.searchWord}">[ &lt;&lt; ]</a>
	                        </c:if>
	                    </c:otherwise>
	                </c:choose>
	
	                <!--이전-->
	                <c:choose>
	                    <c:when test="${(page.curPage-1) < 1}">
	                        [ &lt; ]
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${page.searchType == null }">
	                        	<a href="orderListAdmin?page=${page.curPage-1}">[&lt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="olSearch?page=${page.curPage-1}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&lt;]</a>
	                        </c:if>
	                    </c:otherwise>
	                </c:choose>
	
	                <!--개별 페이지-->
	                <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
	                    <c:choose>
	                        <c:when test="${page.curPage == fEach}">
	                            [${fEach} ]&nbsp;
	                        </c:when>
	
	                        <c:otherwise>
	                        	<c:if test="${page.searchType == null }">
	                            	<a href="orderListAdmin?page=${fEach}">[${fEach}]</a>&nbsp;
	                            </c:if>
	                            <c:if test="${page.searchType != null }">
	                            	<a href="olSearch?page=${fEach}&searchType=${page.searchType}&searchWord=${page.searchWord}">[${fEach}]</a>&nbsp;
	                            </c:if>
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	
	                <!--다음-->
	                <c:choose>
	                    <c:when test="${(page.curPage +1) > page.totalPage}">
	                        [&gt;]
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${page.searchType == null }">
	                        	<a href="orderListAdmin?page=${page.curPage+1}">[&gt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="olSearch?page=${page.curPage+1}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&gt;]</a>
	                        </c:if>
	                    </c:otherwise>
	                </c:choose>
	
	                <!--끝-->
	                <c:choose>
	                    <c:when test="${page.curPage == page.totalPage}">
	                        [&gt;&gt;]
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${page.searchType == null }">
	                        	<a href="orderListAdmin?page=${page.totalPage}">[&gt;&gt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="olSearch?page=${page.totalPage}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&gt;&gt;]</a>
	                        </c:if>
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
    	<script type="text/javascript">
			var myTable = document.getElementById( "myList" ); 
			var replace = replacement( myTable ); 
			function sortTD( index ){    replace.ascending( index );    } 
			function reverseTD( index ){    replace.descending( index );    } 
		</script>
		<form id="stateChangeTotalList">
			<select name="status" id='serch'>
				<option value='배송준비중'>배송준비중</option>
				<option value='배송중'>배송중</option>
				<option value='배송완료'>배송완료</option>
				<option value='구매확정'>구매확정</option>
				<option value='취소신청'>취소신청</option>
				<option value='취소완료'>취소완료</option>
				<option value='교환신청'>교환신청</option>
				<option value='교환상품회수중'>교환상품회수중</option>
				<option value='반품신청'>반품신청</option>
				<option value='반품회수중'>반품회수중</option>
				<option value='반품완료'>반품완료</option>
			</select>
			<input type="button" onclick="submit_state()" value="변경">
		</form>
	</div>
</body>
</html>