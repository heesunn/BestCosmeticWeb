<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    
    function form_check() {
    	var num_check = /^[0-9]*$/;
		if($('#BCG_PRICE').val().length == 0) {
			alert("가격은 필수사항입니다.");
			return;
		}

		if (!num_check.test($('#BCG_PRICE').val())) {
            alert("가격은 숫자만 입력 가능합니다.");
            $('#BCG_PRICE').focus();
            return;
        }
		
		if($('#BCG_DISCOUNT').val().length == 0) {
   			alert("할인율은 필수사항입니다.");
   			return;
   		}
		
		if (!num_check.test($('#BCG_DISCOUNT').val())) {
            alert("할인율은 숫자만 입력 가능합니다.");
            $('#BCG_DISCOUNT').focus();
            return;
        }
				
		if($('#BCG_MDPICK').val().length == 0) {
   			alert("MD's PICK은 필수사항입니다.");
   			return;
   		}
		
		if (!num_check.test($('#BCG_MDPICK').val())) {
            alert("MD's Pick은 숫자만 입력 가능합니다.");
            $('#BCG_MDPICK').focus();
            return;
        }

		mod();
		
	}
	    function mod() {     //상품 수정
	        var queryString=$("#ModifyForm").serialize();       
	        $.ajax({
	        	url: '/admin/modify',  
	            type: 'POST',
	            data: queryString,
	            dataType: 'text',
	            success: function(json) {  
	            	alert("수정완료");
	            	window.location.replace("/admin/goodsList");           		               	           	
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
	
    <h1>상품수정</h1>
    <form id="ModifyForm" method="post">
    	<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">
	    대표사진 : <img src="${BCG_IMG}" width="100" height="100">  <br/>      		      	                   
        상품명 : <input type="text" value="${BCG_NAME}" disabled="disabled"><br/>
        카테고리 : <select disabled="disabled">
        			<option value="${BCG_CATEGORY}">${BCG_CATEGORY}</option>
        		</select> <br/>
        가격 : <input type="text" id="BCG_PRICE" name="BCG_PRICE" value="${BCG_PRICE}">원<br>
        전성분 : <br/>
        <textarea id="BCG_INFO" name="BCG_INFO" cols="50" rows="15">${BCG_INFO}</textarea><br> 
        할인율 : <input type="text" id="BCG_DISCOUNT" name="BCG_DISCOUNT" value="${BCG_DISCOUNT}">%<br>
        *기준가격에 할인율을 곱한 값이 최종가격이 되므로 유의해주세요.<br>
        MD's Pick : <input type="text" id="BCG_MDPICK" name="BCG_MDPICK" value="${BCG_MDPICK}"><br>  
        메인화면 노출 순서 : 1->2->3->4<br>           	
        <input type="button" value="수정" onclick="form_check()">
        <input type="button" value="목록" onclick="javascript:window.location='/admin/goodsList'">
    </form>
</body>
</html>
