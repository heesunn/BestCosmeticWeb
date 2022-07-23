<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

function AnswerAdd(BCG_KEY,BCM_NUM,BCQ_CONTENT) {
    var url= "/admin/answer?"+"BCG_KEY="+BCG_KEY+"&BCM_NUM="+BCM_NUM+"&BCQ_CONTENT="+BCQ_CONTENT;
    var url2= "BCG_KEY="+BCG_KEY+"&BCM_NUM="+BCM_NUM+"&BCQ_CONTENT="+BCQ_CONTENT;
    console.log(url);
    $.ajax({
        url : '/admin/answer',
        type : 'POST',
        data : url2,
        success : function(json) {
            window.open(url, "", "width=600, height=400");
        }
    });
 }
</script>
</head>
<body>
<table border="1">
		<tr>
			<td colspan="9">관리자 - 상품문의리스트</td>
		</tr>
		
		<form id="questionList" method="post">
			<tr>
				<td colspan="9">총 ${page.totalCount}개</td>
			</tr>
			<c:if test="${page.totalCount>0}"> 
			<tr>
				<td>품번</td>
				<td>품명</td>
				<td>회원번호</td>
				<td>회원이름</td>
				<td>질문일</td>
				<td>질문내용</td>
				<td>답변일</td>
				<td>답변내용</td>		
			</tr>
			</c:if>

			<c:forEach items="${list}" var="dto">
			<tr>
					<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
					<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="${dto.bcm_num}">
					<input type="hidden" id="BCQ_CONTENT" name="BCQ_CONTENT" value="${dto.bcq_content}">
					<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${dto.bcg_name}">
					<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="${dto.bcm_name}">
					<input type="hidden" id="BCQ_DATE" name="BCQ_DATE" value="${dto.bcq_date}">
					<input type="hidden" id="BCA_DATE" name="BCA_DATE" value="${dto.bca_date}">
				<td> ${dto.bcg_key}</td>
				<td> ${dto.bcg_name} </td>
				<td> ${dto.bcm_num}</td>							
				<td> ${dto.bcm_name} </td>							
				<td> <fmt:formatDate value="${dto.bcq_date}" pattern="yyyy-MM-dd" var="bcq_date" /> ${bcq_date} </td>							
				<td> ${dto.bcq_content} </td>
				<c:if test="${dto.bca_content != null}">	
					<td> <fmt:formatDate value="${dto.bca_date}" pattern="yyyy-MM-dd" var="bca_date" /> ${bca_date} </td>								
					<td> ${dto.bca_content}</td>
				</c:if>							
				<c:if test="${dto.bca_content == null}">
					<td colspan="2"> 
						<input type="button" value="답변등록" onclick="AnswerAdd('${dto.bcg_key}','${dto.bcm_num}', '${dto.bcq_content}');">
					</td>
				</c:if>
				
					
					<!--  
					<td> 
						<input type="text" id="BCA_CONTENT" name="BCA_CONTENT">
						<input type="button" value="답변등록" onclick="AnswerAdd()">
						<input type="button" value="답변등록" onclick="AnswerAdd(BCG_KEY.value, BCM_NUM.value, BCQ_CONTENT.value);">
						<input type="button" value="답변등록" onclick="AnswerAdd(\''+${dto.bcg_key}+'\',\'+${dto.bcm_num}+'\', \'+${dto.bcq_content}+ '\');">
					</td>
					-->
									
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
				<c:when test="${(page.curPage + 1) > questionPage.totalPage}">
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