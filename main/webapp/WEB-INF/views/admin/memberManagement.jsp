<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
    <h1>회원관리</h1>
    <form id="searchForm">
        <select id="searchType" name="searchType">
            <option id="" value="sTitlecontent" selected>이름</option>
            <option id="sTitle" value="sTitle" >아이디</option>
            <option id="sContent" value="sContent">회원번호</option>
        </select>
        <input type="text" id="searchWord" name="searchType">
        <input type="button" value="검색" onclick="search_form();">
    </form>
    <p>
        검색결과 : <span style="color: red">${page.totalCount}</span>명,
        총 회원수 : <span style="color: red">${page.totalCount}</span>명
    </p>
    <table cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td>번호</td>
            <td>이름</td>
            <td>아이디</td>
            <td>가입일</td>
            <td>주문수</td>
            <td>주문총액</td>
            <td>CRM</td>
        </tr>
        <c:forEach items="${list}" var="dto">
            <tr>
                <td>${dto.bcm_num}</td>
                <td>${dto.bcm_name}</td>
                <c:if test="${dto.bcm_id == null}">
                    <td>sns회원</td>
                </c:if>
                <c:if test="${dto.bcm_id != null}">
                    <td>${dto.bcm_id}</td>
                </c:if>
                <td>${dto.bcm_joined_on}</td>
                <td>${dto.order_count}</td>
                <td>${dto.total_price}</td>
                <td><input type="button" value="보기" onclick=""></td>
            </tr>
        </c:forEach>
            <tr>
                <td colspan="7">
                    <!--처음-->
                    <c:choose>
                        <c:when test="${(page.curPage-1)<1}">
                            [ &lt;&lt; ]
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/memberManagement?page=1">[ &lt;&lt; ]</a>
                        </c:otherwise>
                    </c:choose>

                    <!--이전-->
                    <c:choose>
                        <c:when test="${(page.curPage-1) < 1}">
                            [ &lt; ]
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/memberManagement?page=${page.curPage-1}">[&lt;]</a>
                        </c:otherwise>
                    </c:choose>

                    <!--개별 페이지-->
                    <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
                        <c:choose>
                            <c:when test="${page.curPage == fEach}">
                                [${fEach} ]&nbsp;
                            </c:when>

                            <c:otherwise>
                                <a href="/admin/memberManagement?page=${fEach}">[${fEach}]</a>&nbsp;
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!--다음-->
                    <c:choose>
                        <c:when test="${(page.curPage +1) > page.totalPage}">
                            [&gt;]
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/memberManagement?page=${page.curPage+1}">[&gt;]</a>
                        </c:otherwise>
                    </c:choose>

                    <!--끝-->
                    <c:choose>
                        <c:when test="${page.curPage == page.totalPage}">
                            [&gt;&gt;]
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/memberManagement?page=${page.totalPage}">[&gt;&gt;]</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
    </table>
</body>
</html>
