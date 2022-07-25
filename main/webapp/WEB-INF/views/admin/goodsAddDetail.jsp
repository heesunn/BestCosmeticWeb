<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>  
    <script>


        function add() {      	
        	var count = $('.count').length;   //<tr> 개수 카운트
        	count++;                          //추가된 <tr> 2부터 시작하도록 함
        	
            $('#BCD_option').append(          // 옵션 추가
            	'<tr class="count">' +
            		'<td>'+count+'</td>' +
            		'<td>' +
					   	'<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">' +
					    '상세품번 : <input type="text" id="BCD_DETAILKEY" name="BCD_DETAILKEY">' +
				    '</td>' +
				    '<td>' +
				    	'옵션 : <input type="text" id="BCD_OPTION" name="BCD_OPTION" >' +
				    '</td>' +
				    '<td>' +
				    	'재고수량 : <input type="text" id="BCD_STOCK" name="BCD_STOCK" >' +      
					'</td>' +
				    '<td name="del'+count+'" class="del'+count+'">' +
					    '<input type="button" value="+" onclick="add()"> ' +
					    '<input type="button" name="delRow" class="delRow" value="-">' +
				    '</td>' +                 
			    '</tr>'
			);
            
            $('.delRow').click(function(){     // 옵션 삭제          	
                $(this).parent().parent().remove();
            });
        }
        
        function form_check() {
        	var num_check = /^[0-9]*$/;
			if($('#BCD_DETAILKEY').val().length == 0) {
				alert("상세품번은 필수사항입니다.");
				return;
			}

			if (!num_check.test($('#BCD_DETAILKEY').val())) {
                alert("상세품번은 숫자만 입력 가능합니다.");
                $('#BCD_DETAILKEY').focus();
                return;
            }
			
			if($('#BCD_OPTION').val().length == 0) {
	   			alert("옵션이름은 필수사항입니다.");
	   			return;
	   		}
					
			if($('#BCD_STOCK').val().length == 0) {
	   			alert("재고수량은 필수사항입니다.");
	   			return;
	   		}
			
			if (!num_check.test($('#BCD_STOCK').val())) {
                alert("재고수량은 숫자만 입력 가능합니다.");
                $('#BCD_STOCK').focus();
                return;
            }

			submit_ajax();
			
		}
          
        function submit_ajax() {     //BC_DETAILGOODS oracle DB에 다중 insert
            var queryString=$("#AddDetailForm").serialize();
            	$.ajax({
                url : '/admin/uploadDetail',
                type : 'POST',
                data : queryString ,
                dataType : 'json',
                success : function(json) {
                    console.log(json);
                    if(json.desc == 1){
                         //alert("성공");
                         window.location.replace("/admin/goodsList");    
                    } else if (json.desc == 0) { alert("데이터베이스입력오류")
                    } else if (json.desc == -1) { alert("배열없음")
                    } else { alert(json.desc); }
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
	
    <h1>상품서브테이블 insert</h1><br/>

	상품명 : ${BCG_NAME}
	<form id="AddDetailForm">	      
		<table>		
			<thead id="BCD_option" class="BCD_option">	
			   	<tr class="count">
				   	<td>1</td>
				   	<td>
					   	<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">
					    상세품번 : <input type="text" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="0">
				    </td> 
				    <td>
				    	옵션 : <input type="text" id="BCD_OPTION" name="BCD_OPTION" value="-">
				    </td>
				    <td>
				    	재고수량 : <input type="text" id="BCD_STOCK" name="BCD_STOCK" value="0">	       
					</td> 
				    <td name="del1" class="del1">
					    <!-- 상품 디테일 목록 추가,삭제 -->
					    <input type="button" value="+" onclick="add()">
				    </td>                 
			    </tr>
		    </thead>
		    <tbody>
			    <tr>
			    	<td><input type="button" value="등록" onClick="form_check();"></td>	
			    </tr>
		    </tbody>
		</table>    
	</form>

</body>
</html>
