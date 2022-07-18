<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<body>
<div>
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<div style="float: left">
    <table border="1">
		<tr>
			<td colspan="4">찜 목록</td>
		</tr>
		<tr>
			<td colspan="4">총 ${page.totalCount}개</td>
		</tr>
		
		<c:set var="i" value="0" />
		<c:set var="j" value="4" />
		<c:forEach items="${likeList}" var="like">
		<c:if test="${i%j == 0 }">		
		<tr>
		</c:if>
			<td> 
				<form id="deleteForm${like.bcg_key}">
					<input type="hidden" name="bcm_num" value="${like.bcm_num}">
					<input type="hidden" name="bcg_key" value="${like.bcg_key}">
					<button style="float: right" onclick="찜목록삭제${like.bcg_key}()">x</button><br/><!-- 포지션 앱솔루트 탑 0px 레프트 200px -->
				</form>
				<img src="${like.bcg_img}" onclick="상세페이지()" height="200" width="200">&nbsp;
			</td>
		<c:if test="${i%j == j-1 }">
		</tr>	
		</c:if>
		<c:set var="i" value="${i+1 }" />
			<script>
				function 상세페이지() {
	
				}
				function 찜목록삭제${like.bcg_key}() {
	
    				var queryString = $('#deleteForm${like.bcg_key}').serialize();

    				$.ajax({
        				url : '/member/likeDelete',
        				type : 'POST',
        				data : queryString,
        				success : function(data) {
            				if(data == 'success'){
                				window.location.reload();
            				}
            				else {
            					alert("에러가 발생했습니다.");
            				}
        				}
    				});
				}
			</script>
		</c:forEach>
			
		<tr>
			<td colspan="3">
				<!-- 처음 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					[ &lt;&lt; ]
				</c:when>
				<c:otherwise>
					<a href="like?page=1">[ &lt;&lt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 이전 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					[ &lt; ]
				</c:when>
				<c:otherwise>
					<a href="like?page=${page.curPage - 1}">[ &lt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
					<c:choose>
					<c:when test="${page.curPage == fEach}">
						[ ${fEach} ] &nbsp;
					</c:when>
					<c:otherwise>
						<a href="like?page=${fEach}">[ ${fEach} ]</a> &nbsp;
					</c:otherwise>
					</c:choose>
				</c:forEach>	
				
				<!-- 다음 -->
				<c:choose>
				<c:when test="${(page.curPage + 1) > page.totalPage}">
					[ &gt; ]
				</c:when>
				<c:otherwise>
					<a href="like?page=${page.curPage + 1}">[ &gt; ]</a>
				</c:otherwise>
				</c:choose>
				
				<!-- 끝 -->
				<c:choose>
				<c:when test="${page.curPage == page.totalPage}">
					[ &gt;&gt; ]
				</c:when>
				<c:otherwise>
					<a href="like?page=${page.totalPage}">[ &gt;&gt; ]</a>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</div>
</body>
</html>