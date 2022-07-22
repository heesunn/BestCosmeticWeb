<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int bcm_num = 0;
	String bcm_name = ""; 
	if(session.getAttribute("num")!=null) {
		bcm_num = (int)session.getAttribute("num");
		bcm_name = (String)session.getAttribute("name");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function Add() {	//BC_QUESTION oracle DB에 update
		var queryString=$("#answer").serialize();	
		console.log(queryString);
        $.ajax({
        	url: '/admin/answerSuccess',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	opener.parent.location.reload();
            	window.close();           		               	           	
            }
        });
	}
</script>
</head>
<body>
	<table>
		<tr>
			<td>
				답변
			</td>
			<td>
				<form id="answer">
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY }">
				<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="${BCM_NUM }">
				<input type="hidden" id="BCQ_CONTENT" name="BCQ_CONTENT" value="${BCQ_CONTENT }">
				<textarea id="BCA_CONTENT" id="BCA_CONTENT" name="BCA_CONTENT" cols="50" rows="15"></textarea>
				<input type="button" value="등록" onclick="Add()">
				</form>
			</td>
		</tr>
	</table>
</body>
</html>