<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>  
    <script>
    /*
        //FormData 새로운 객체 생성 
        var formData = new FormData();
        // 넘길 데이터를 담아준다. 
        var data = {
            "BCG_NAME" : $("#BCG_NAME").val(),
            "BCD_DETAILKEY" : $("#BCD_DETAILKEY").val(),
            "BCD_OPTION" : $("#BCD_OPTION").val(),
            "BCD_STOCK" : $("#BCD_STOCK").val()
        };          
        formData.append('key', new Blob([ JSON.stringify(data) ], {type : "application/json; charset=utf-8;"}));
        console.log(formData);
	*/

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
    <h1>등록완료_상품서브테이블 insert</h1><br/>

	상품명 : ${BCG_NAME}
	<form id="AddDetailForm">	      
		<table>		
			<thead id="BCD_option" class="BCD_option">	
			   	<tr class="count">
				   	<td>1</td>
				   	<td>
					   	<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">
					    상세품번 : <input type="text" id="BCD_DETAILKEY" name="BCD_DETAILKEY">
				    </td> 
				    <td>
				    	옵션 : <input type="text" id="BCD_OPTION" name="BCD_OPTION" >
				    </td>
				    <td>
				    	재고수량 : <input type="text" id="BCD_STOCK" name="BCD_STOCK" >	       
					</td> 
				    <td name="del1" class="del1">
					    <!-- 상품 디테일 목록 추가,삭제 -->
					    <input type="button" value="+" onclick="add()">
				    </td>                 
			    </tr>
		    </thead>
		    <tbody>
			    <tr>
			    	<td><input type="button" value="등록" onClick="submit_ajax();"></td>	
			    </tr>
		    </tbody>
		</table>    
	</form>

</body>
</html>
