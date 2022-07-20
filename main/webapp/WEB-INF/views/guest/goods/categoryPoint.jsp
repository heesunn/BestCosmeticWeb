<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% 
	int num = 0;
	if(session.getAttribute("num")!= null) {
		num = (int)session.getAttribute("num");
	} else {
		num = 0;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 - 포인트메이크업</title>
<script>

function sch() {     //검색기능
    var queryString=$("#categorySch").serialize();
    $.ajax({
    	url: '/guest/categorySearch',  
        type: 'POST',
        data: queryString,
        dataType: 'text',
        success: function(json) {  
        	window.location.replace("/guest/searchCRs");
        }       	
    });
}

function logCk() {        //로그인 여부체크 아직 안됨.
	var loginCk = '<%=num%>';
	console.log(loginCk);
	if(loginCk==0) {
		window.location='/guest/loginView';
	} else { 
		likeUpdate${dto.bcg_key}();
	}
}
</script>
</head>
<body>
	<div style="float: top">
       <c:import url="/guest/menuTop"></c:import>
   </div>
   
   <div style="float: left">
       <c:import url="/guest/menuLeft"></c:import>
   </div>
   
   <form id="categorySch" name="categorySch">	
			<tr>
				<td>							
					<select id="type" name="type">
						<option value="bcg_name">품명</option>						
					</select>
					<input type="text" id="srchText" name="srchText">
					<input type="button" value="검색" onclick="sch()">
				</td>
			</tr>
	</form>		
   
   <table border="1">
      <tr>
         <td colspan="4">포인트 메이크업</td>
      </tr>
      <tr>
         <td colspan="4">총 ${page.totalCount}개</td>
      </tr>
      
      
      <c:set var="i" value="0" />
      <c:set var="j" value="4" />
      <c:forEach items="${list}" var="dto">
      <c:if test="${i%j == 0 }">   
      <tr>
      </c:if>
         <td> 
         	<!-- NEW 뱃지 -->
         	<c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
         	<fmt:formatDate value="${now}" pattern="yyMMdd" var="today" /><!-- 현재시간을 숫자로 -->
         	<fmt:formatDate  value="${dto.bcg_date}" pattern="yyMMdd" var="dtoDate" /><!-- 게시글 작성날짜를 숫자로 -->
         		<c:if test="${today - dtoDate le 30}"><!-- 30일동안은 new 표시 -->
            		<span>new</span>
         		</c:if>
         		
         	<!-- BEST 뱃지 -->
			<fmt:formatNumber value="${dto.bcg_sale }" var="sale"/>
         	<c:if test="${sale >= 10}">
         		<span>best</span>
         	</c:if>
            <img src="${dto.bcg_img}" height="200" width="200"><br/>
            ${dto.bcg_name}<br/>
            ${dto.bcg_price}원 
         	<form id="list${dto.bcg_key}" name="list${dto.bcg_key}">
         		<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=num %>">
         		<input type="hidden" id="key${dto.bcg_key }" name="BCG_KEY" value="${dto.bcg_key }">   
         		<input type="image" src="/image/heart.png" height="20" width="20" onclick ="logCk()">        			
         	</form>
         </td>
      <c:if test="${i%j == j-1 }">   
      </tr>   
      </c:if>
      <c:set var="i" value="${i+1 }" />
      <script>
      function likeUpdate${dto.bcg_key}() {     //찜 업데이트
    	  var queryString=$("#list${dto.bcg_key}").serialize();     		
	      $.ajax({
		      url: '/member/glike',  
	          type: 'POST',
	          data: queryString,
	          dataType: 'text',
	          success: function(json) {  
	        	  //alert("찜했습니다");
	        	  //window.location.replace("/guest/categoryPoint");
	          }       	
	      });		  
      }
      </script>
      </c:forEach>
      
         
      <tr>
         <td colspan="4">
            <!-- 처음 -->
            <c:choose>
            <c:when test="${(page.curPage - 1) < 1}">
               [ &lt;&lt; ]
            </c:when>
            <c:otherwise>
               <a href="categoryPoint?page=1">[ &lt;&lt; ]</a>
            </c:otherwise>
            </c:choose>
            
            <!-- 이전 -->
            <c:choose>
            <c:when test="${(page.curPage - 1) < 1}">
               [ &lt; ]
            </c:when>
            <c:otherwise>
               <a href="categoryPoint?page=${page.curPage - 1}">[ &lt; ]</a>
            </c:otherwise>
            </c:choose>
            
            <!-- 개별 페이지 -->
            <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
               <c:choose>
               <c:when test="${page.curPage == fEach}">
                  [ ${fEach} ] &nbsp;
               </c:when>
               <c:otherwise>
                  <a href="categoryPoint?page=${fEach}">[ ${fEach} ]</a> &nbsp;
               </c:otherwise>
               </c:choose>
            </c:forEach>   
            
            <!-- 다음 -->
            <c:choose>
            <c:when test="${(page.curPage + 1) > page.totalPage}">
               [ &gt; ]
            </c:when>
            <c:otherwise>
               <a href="categoryPoint?page=${page.curPage + 1}">[ &gt; ]</a>
            </c:otherwise>
            </c:choose>
            
            <!-- 끝 -->
            <c:choose>
            <c:when test="${page.curPage == page.totalPage}">
               [ &gt;&gt; ]
            </c:when>
            <c:otherwise>
               <a href="categoryPoint?page=${page.totalPage}">[ &gt;&gt; ]</a>
            </c:otherwise>
            </c:choose>
         </td>
      </tr>
   </table>
</body>
</html>