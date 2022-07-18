<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 상품리스트</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	
	function del() {     //상품 삭제 : 여러개 한번에 삭제 가능
        var queryString=$("#ModifyDelete").serialize();
        $.ajax({
        	url: '/admin/delete',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) { }
        });
        del2();
    }
	
	function del2() {     //상품 삭제 시 옵션까지 삭제
        var queryString=$("#ModifyDelete").serialize();       
        $.ajax({
        	url: '/admin/deleteDetail',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	window.location.replace("/admin/goodsList");           		               	           	
            }
        });
    }	
	
	function opAdd() {     //옵션추가 : 1개만 선택 가능
        var queryString=$("#ModifyDelete").serialize();
        $.ajax({
        	url: '/admin/opSelect',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {
            	window.location.replace("/admin/goodsAddDetail");   
            }
        });
    }
	
	function mod() {     //상품 수정 : 1개만 선택 가능
        var queryString=$("#ModifyDelete").serialize();
        $.ajax({
        	url: '/admin/opSelect',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {
            	window.location.replace("/admin/goodsModify");   
            }
        });
    }
	
	function sch() {     //검색기능
        var queryString=$("#adminSch").serialize();
        $.ajax({
        	url: '/admin/adminSearch',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	window.location.replace("/admin/searchRs");
            }       	
        });
    }
</script>
</head>
<body>	
	<table border="1">
		<tr>
			<td colspan="10">관리자 - 상품리스트</td>
			<td><button onclick="location.href='/admin/goodsList'">전체보기</button></td>
		</tr>
		<form id="adminSch" name="adminSch">		
			<tr>
				<td colspan="11">							
					<select id="type" name="type">
						<option value="bcg_key">품번</option>
						<option value="bcg_name">품명</option>						
					</select>
					<input type="text" id="srchText" name="srchText">
					<input type="button" value="검색" onclick="sch()">
				</td>
			</tr>
		</form>		
		<form id="ModifyDelete" method="post">
			<tr>
				<td colspan="9">총 ${page.totalCount}개</td>
				<td colspan="2">
					<input type="button" value="옵션추가" onclick="opAdd()">
					<input type="button" value="수정" onclick="mod()">
					<input type="button" value="삭제" onclick="del()">
				</td>
			</tr>
			<c:if test="${page.totalCount>0}"> 
			<tr>
				<td></td>
				<td>대분류</td>
				<td>품번</td>
				<td>품명</td>
				<td>판매가</td>
				<td>출시일</td>
				<td>재고량</td>
				<td>판매량</td>
				<td>찜</td>
				<td>할인율</td>
				<td>MD's Pick</td>			
			</tr>
			</c:if>
			<c:if test="${page.totalCount==0}"> 
				<tr><td colspan="11">검색어와 일치하는 상품이 없습니다.</td></tr>
			</c:if> 
			<c:forEach items="${list}" var="dto">
			<tr>
				<td> 
					<input type="checkbox" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
					<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${dto.bcg_name}">
					<input type="hidden" id="BCG_CATEGORY" name="BCG_CATEGORY" value="${dto.bcg_category}">
					<input type="hidden" id="BCG_PRICE" name="BCG_PRICE" value="${dto.bcg_price}">
					<input type="hidden" id="BCG_DISCOUNT" name="BCG_DISCOUNT" value="${dto.bcg_discount}">
					<input type="hidden" id="BCG_MDPICK" name="BCG_MDPICK" value="${dto.bcg_mdpick}">
					<input type="hidden" id="BCG_IMG" name="BCG_IMG" value="${dto.bcg_img}"> 
					<input type="hidden" id="BCG_INFO" name="BCG_INFO" value="${dto.bcg_info}"> 
				</td>
				<td> ${dto.bcg_category} </td>
				<td> ${dto.bcg_key} </td>
				<td> <a href="">${dto.bcg_name}</a> </td>							
				<td> ${dto.bcg_price}원 </td>							
				<td> <fmt:formatDate value="${dto.bcg_date}" pattern="yyyy-MM-dd" var="bcg_date" /> ${bcg_date} </td>							
				<td> ${dto.bcg_stock} </td>							
				<td> ${dto.bcg_sale} </td>							
				<td> ${dto.bcg_like} </td>							
				<td> ${dto.bcg_discount}% </td>							
				<td> 
					<c:if test="${dto.bcg_mdpick != 0}"> ${dto.bcg_mdpick} </c:if> 
					<c:if test="${dto.bcg_mdpick == 0}"> - </c:if> 
				</td>	
			</tr>
			</c:forEach>	
		</form>	
		<c:if test="${page.totalCount>0}"> 
		<tr>
			<td colspan="11">
				<!-- 처음 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					[ &lt;&lt; ]
				</c:when>
				<c:otherwise>
					<a href="goodsList?page=1">[ &lt;&lt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 이전 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					[ &lt; ]
				</c:when>
				<c:otherwise>
					<a href="goodsList?page=${page.curPage - 1}">[ &lt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
					<c:choose>
					<c:when test="${page.curPage == fEach}">
						[ ${fEach} ] &nbsp;
					</c:when>
					<c:otherwise>
						<a href="goodsList?page=${fEach}">[ ${fEach} ]</a> &nbsp;
					</c:otherwise>
					</c:choose>
				</c:forEach>	
				
				<!-- 다음 -->
				<c:choose>
				<c:when test="${(page.curPage + 1) > page.totalPage}">
					[ &gt; ]
				</c:when>
				<c:otherwise>
					<a href="goodsList?page=${page.curPage + 1}">[ &gt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 끝 -->
				<c:choose>
				<c:when test="${page.curPage == page.totalPage}">
					[ &gt;&gt; ]
				</c:when>
				<c:otherwise>
					<a href="goodsList?page=${page.totalPage}">[ &gt;&gt; ]</a>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:if>
	</table>				
</body>
</html>