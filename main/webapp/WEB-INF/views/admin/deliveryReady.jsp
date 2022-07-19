<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송준비</title>
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
	var queryString = $("input:checkbox[name=bco_ordernum]:checked").serialize();
	console.log(queryString);
	
	$.ajax({
		url : '/admin/stateInTransit',
		type : 'POST',
		data : queryString,
		success : function(data) {
			if(data == 'success'){
				alert("선택 하신 주문의 상태가 '배송중' 으로 변경되었습니다.");
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
	<h1>배송준비</h1>
	<div>
		<form action="/admin/drSearch">
			<select name="searchType" id='serch'>
				<option value='bcm_name'>주문인</option>
				<option value='bco_recipient'>수령인</option>
				<option value='bco_ordernum'>주문번호</option>
			</select>
			<input type="text" name="searchWord">
			<input type="submit" value="검색">
		</form>
		<button onclick="javascript:window.location = '/admin/deliveryReady'">검색 초기화</button>
		<span>검색결과 : ${page.totalCount} 건</span>&nbsp;&nbsp;&nbsp;ㅣ <span>총결제금액 : <strong id="totalprice">${totalPrice }</strong></span>
		<script>
			var money = $('#totalprice').text();
			var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#totalprice').text(money2+"원");
		</script>
	</div>
	<div>
		<table id="myList" cellpadding="0" cellspacing="0" border="1">
	        <thead>
	        	<tr>
		        	<th><input type='checkbox' name='selectall' value='selectall' onclick='selectAll(this)'/></th>
		            <th>주문번호</th>
		            <th>주문일<button onclick="sortTD(2)">▲</button><button onclick="reverseTD(2)">▼</button></th>
		            <th>주문인<button onclick="sortTD(3)">▲</button><button onclick="reverseTD(3)">▼</button></th>
		            <th>수령인<button onclick="sortTD(4)">▲</button><button onclick="reverseTD(4)">▼</button></th>
		            <th>결제총액<button onclick="sortTD(5)">▲</button><button onclick="reverseTD(5)">▼</button></th>
		            <th>주문내역</th>
	            </tr>
	        </thead>
	        <tbody>
	    <c:forEach items="${deliveryReady}" var="ready">
		        <tr>
		        	<td><input type='checkbox' name='bco_ordernum' value='${ready.bco_ordernum}' onclick='checkSelectAll(event)'/></td>
		            <td>${ready.bco_ordernum}</td>
		            <td>${ready.bco_orderdate}</td>
		            <td>${ready.bcm_name}</td>
		            <td>${ready.bco_recipient}</td>
		            <td id="price${ready.bco_ordernum}">${ready.bco_totalprice}</td>
		            <td><a href="#" 
		            	onclick="javascript:window.open('http://localhost:8081/member/orderDetail?bco_ordernum=${ready.bco_ordernum}', 
		            	'주문내역 상세', 'width=400, height=300')">${ready.bco_order_name}</a>
		            </td>
		        </tr>
		        <script>
				    var money = $('#price${ready.bco_ordernum}').text();
				    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				    $('#price${ready.bco_ordernum}').text(money2+"원");
				</script>
	    </c:forEach>
	    	</tbody>
	        <tr>
	            <td colspan="7">
	                <!--처음-->
	                <c:choose>
	                    <c:when test="${(page.curPage-1)<1}">
	                        [ &lt;&lt; ]
	                    </c:when>
	                    <c:otherwise>
	                    	<c:if test="${page.searchType == null }">
	                        	<a href="deliveryReady?page=1">[ &lt;&lt; ]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="drSearch?page=1&searchType=${page.searchType}&searchWord=${page.searchWord}">[ &lt;&lt; ]</a>
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
	                        	<a href="deliveryReady?page=${page.curPage-1}">[&lt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="drSearch?page=${page.curPage-1}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&lt;]</a>
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
	                            	<a href="deliveryReady?page=${fEach}">[${fEach}]</a>&nbsp;
	                            </c:if>
	                            <c:if test="${page.searchType != null }">
	                            	<a href="drSearch?page=${fEach}&searchType=${page.searchType}&searchWord=${page.searchWord}">[${fEach}]</a>&nbsp;
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
	                        	<a href="deliveryReady?page=${page.curPage+1}">[&gt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="drSearch?page=${page.curPage+1}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&gt;]</a>
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
	                        	<a href="deliveryReady?page=${page.totalPage}">[&gt;&gt;]</a>
	                        </c:if>
	                        <c:if test="${page.searchType != null }">
	                        	<a href="drSearch?page=${page.totalPage}&searchType=${page.searchType}&searchWord=${page.searchWord}">[&gt;&gt;]</a>
	                        </c:if>
	                    </c:otherwise>
	                </c:choose>
	            </td>
	        </tr>
    	</table>
    	<script type="text/javascript">
			var myTable = document.getElementById( "myList" ); 
			var replace = replacement( myTable ); 
			function sortTD( index ){    replace.ascending( index );    } 
			function reverseTD( index ){    replace.descending( index );    } 
		</script>
    	<button onclick="submit_state()">선택한 주문 배송시작</button>
	</div>
</body>
</html>