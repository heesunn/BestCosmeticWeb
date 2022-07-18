<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
	int bcm_num = (int) session.getAttribute("num");
%>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<style>
	#qq {
		font-size : 20px;
		float : left;
	}
</style>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function deleteCheck() {
	if($('#agree').is(':checked')) {
		if(confirm("정말 탈퇴 하시겠습니까?")) {
			var queryString = "bcm_num=<%=bcm_num%>";
			$.ajax({
				url : '/member/memberDelete',
				type : 'POST',
				data : queryString,
				success : function(data) {
					if(data == "탈퇴완료") {
						alert("탈퇴가 완료되었습니다, 이용해주셔서 감사합니다.");
						window.location = "/logout";
					}
					else if(data == "탈퇴에러") {
						alert("처리도중 에러가 발생했습니다, 관리자에게 문의하세요.");
					}
				}
			});
		}
		else {}
	}
	else {
		alert("회원 탈퇴 동의를 체크 해주세요.");
		return;
	}
}
</script>
</head>
<body>
<div>
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<div>
	<p style="font-size : 20px">회원 탈퇴</p><br>
	저희 BestCosmetic 을 이용해 주셔서 감사합니다.<br>
	회원탈퇴 시 모든 회원정보와 구매내역 등이 자동으로 삭제 처리되며, 복구가 불가합니다.<br>
	<span style="color:blue">자동 삭제 항목</span><span style="color:red">(복구 불가능)</span> : 회원정보, 상품구매 등의 모든 내역<br><br>
	<hr>
	<input type="checkbox" id="agree"> <p style="float: left">회원 탈퇴에 대한 동의<span style='color:red'>(필수)</span></p><br>
	<hr>
	<p id="qq">위 내용을 모두 확인하였으며, 모든 정보는 복구가 불가능합니다.<br>
	회원 탈퇴에 동의하시겠습니까?</p><br>
	<button onclick="deleteCheck()">회원탈퇴하기</button>
</div>
</body>
</html>