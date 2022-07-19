<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 상품 옵션 삭제</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	
	function optionDelete() {     //재고수정
	    var queryString=$("#optionDelete").serialize();     
	    $.ajax({
	        url: '/admin/optionDelete',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'json',
	        success: function(json) {  
	            if(json.desc == 1){
	                window.location.replace("/admin/opDelete");    
	            } else if (json.desc == 0){
	                alert("데이터베이스입력오류")
	            } else if (json.desc == -1) {
	                alert("배열없음")
	            } else {
	                alert(json.desc);
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
	
	<table border="1">
		<tr>
			<td colspan="5">관리자 - 옵션삭제</td>
		</tr>
		<form id="optionDelete" method="post">
		<tr>
			<td colspan="4"> </td>
            <td>
           		<button onclick="optionDelete()">삭제</button>
			</td>
		</tr>   
		<tr>
            <td></td>
            <td>품번</td>
            <td>상세품번</td>
            <td>옵션</td>
            <td>재고수량</td>       	       
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
            <td>
				<input type="checkbox" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="${dto.bcd_detailkey}">
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
				<input type="hidden" id="BCD_OPTION" name="BCD_OPTION" value="${dto.bcd_option}">
				<input type="hidden" id="BCD_STOCK" name="BCD_STOCK" value="${dto.bcd_stock}">
            </td>      
            <td> ${dto.bcg_key} </td>   
            <td> ${dto.bcd_detailkey} </td>   
            <td> ${dto.bcd_option} </td>            
            <td> ${dto.bcd_stock} </td>              
		</tr>
		</c:forEach>   
		</form>   
		<tr>
			<td colspan="4"></td>
			<td> <input type="button" value="목록" onclick="javascript:window.location='/admin/goodsList'"> </td>
		</tr>
	</table>
</body>
</html>