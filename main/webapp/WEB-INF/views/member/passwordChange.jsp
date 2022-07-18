<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
	int bcm_num = (int) session.getAttribute("num");
	String id = (String) session.getAttribute("id");
	if(id.length() > 10) {
		response.sendRedirect("/member/orderDelivery");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function formTest() {
	if ($('#cPw').val().length == 0) {
		alert("현재 비밀번호를 입력하세요.");
		$('#cPw').focus();
		return;
	}
	if ($('#nPw').val().length == 0){
		alert("새로운 비밀번호를 입력하세요.");
		$('#nPw').focus();
		return;
	}
	var pwCheck = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    if (!pwCheck.test($('#nPw').val())) {
    	alert("비밀번호는 숫자,영문,특수문자를 포함한 8~16자리여야합니다.");
        $('#nPw').focus();
        return;
    }
    if($('#nPw').val() != $('#nPwConfirm').val()){
    	alert("비밀번호가 일치하지 않습니다.");
        $('#nPwConfirm').focus();
        return;
    }
    if($('#cPw').val() == $('#nPw').val()){
    	alert("새로운 비밀번호와 이전 비밀번호가 같습니다.");
        $('#nPw').focus();
        return;
    }
    passwordCheck();
}
</script>
<script>
function submit_ajax() {
	var queryString=$("#pwChange").serialize();
	alert(queryString);
	$.ajax({
		url : '/member/pwChange',
		type : 'POST',
		data : queryString,
		success : function(data) {
			if(data == "성공") {
				alert("비밀번호를 변경했습니다. 변경한 비밀번호로 다시 로그인해주세요.");
				window.location = "/logout";
			}
			else if(data == "에러") {
				alert("비밀번호 변경중 에러가 발생했습니다, 관리자에게 문의하세요.");
			}
			else {
				alert(data);
			}
		}
	});
}
function passwordCheck() {
	var queryString=$("#pwChange").serialize();
	$.ajax({
		url : '/member/pwCheck',
		type : 'POST',
		data : queryString,
		success : function(data) {
			if(data == "불일치") {
				alert("현재 비밀번호가 일치하지않습니다.");
				$('#cPw').focus();
				return;
			}
			else if(data == "일치") {
				submit_ajax();
			}
		}
	});
}
</script>
<body>
<div>
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<div style="float: left">
	<form id="pwChange">
		<input type="hidden" name="bcm_num" value="<%= bcm_num%>">
		현재 비밀번호 : <input type="password" id="cPw" name="cPw" maxlength="16" placeholder="현재 비밀번호" ><br>
		새로운 비밀번호 : <input type="password" id="nPw" name="nPw" maxlength="16" placeholder="password" > <br/>
	    새로운 비밀번호 확인 : <input type="password" id="nPwConfirm" name="nPwConfirm" maxlength="16" placeholder="password확인"> <br/>
	    <button type="button" onclick="formTest()">비밀번호 변경</button>
	</form>
</div>
</body>
</html>