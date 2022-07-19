<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 재고관리</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	function upCount(ths) {
		var $input = $(ths).parents("td").find("input[name='count']");
	    var tCount = Number($input.val());
	    var result =$input.val(Number(tCount)+1);
	}

	function downCount(ths) {
		var $input = $(ths).parents("td").find("input[name='count']");
	    var tCount = Number($input.val());
	    var result = $input.val(Number(tCount)-1);
	}
	
	function sch() {             //검색기능
	    var queryString=$("#adminSch").serialize();
	    $.ajax({
	        url: '/admin/stockManager',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'text',
	        success: function(json) {  
	            window.location.replace("/admin/optionList");
	        }          
	    });
	}	
	
	function stockModify() {     //재고수정
	    var queryString=$("#stockModify").serialize();     
	    $.ajax({
	        url: '/admin/stockUpdate',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'json',
	        success: function(json) {  
	            console.log(json);
	            if(json.desc == 1){
	                alert("성공");
	                window.location.replace("/admin/goodsList");    
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
			<td colspan="3">관리자 - 재고관리</td>
			<td><input type="button" value="수정" onclick="stockModify()"></td>
		</tr>
		<form id="adminSch" name="adminSch">      
		<tr>
            <td colspan="4">                     
               <input type="text" id="BCG_KEY" name="BCG_KEY">
               <input type="button" value="품번검색" onclick="sch()">
            </td>
		</tr>
		</form>    
		<c:if test="${BCG_KEY!= 0}">
		<form id="stockModify" method="post">
		<tr>
            <td>품번</td>
            <td>상세품번</td>
            <td>옵션</td>
            <td>재고수량</td>   
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
			<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
			<input type="hidden" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="${dto.bcd_detailkey}">
			<input type="hidden" id="BCD_OPTION" name="BCD_OPTION" value="${dto.bcd_option}">
			<input type="hidden" id="BCD_STOCK" name="BCD_STOCK" value="${dto.bcd_stock}">                    
            <td> ${dto.bcg_key} </td>   
            <td> ${dto.bcd_detailkey} </td>   
            <td> ${dto.bcd_option} </td>            
            <td>
                <span onclick="downCount(this);"><i class="fas fa-arrow-alt-circle-down down"></i></span>
                <input type="text" name="count" id="count"
                                    min="1" max="${dto.bcd_stock}" size="2" maxlength="2" value="${dto.bcd_stock}" >
                <span onclick="upCount(this);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
            </td>                  
		</tr>
		</c:forEach>   
		</form>   
		</c:if>   
	</table>            
</body>
</html>