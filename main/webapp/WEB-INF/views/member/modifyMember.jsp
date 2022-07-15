<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    int sNum = 0;
    String sName = "";
    String sEmail = "";
    String sId = "";
    String firstEmail = "";
    String secondEmail = "";
    if(session.getAttribute("num") != null) {
        sNum = (int) session.getAttribute("num");
        sId = (String) session.getAttribute("id");
        sName = (String) session.getAttribute("name");
        sEmail = (String) session.getAttribute("email");
    }
    int idx = sEmail.indexOf("@");
    firstEmail = sEmail.substring(0,idx);
    secondEmail = sEmail.substring(idx+1);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div style="float: left">
    <c:import url="/mypageView"></c:import>
</div>
<div style="float: left">
    <h1>회원 정보 수정</h1>
    <h5>필수 입력사항</h5>
    <table cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td>아이디</td>
            <td>${user.bcm_id}</td>
        </tr>
        <tr>
            <td>이름</td>
            <td><%= sName %></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="text" id="firstEmail" name="firstEmail" value="<%=firstEmail%>">@
                <input type="text" id="secondEmail" name="secondEmail" value="<%=secondEmail%>">
                <select id="selectEmail" name="selectEmail">
                    <option value="1" selected>직접입력</option>
                    <option value="naver.com">naver.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="hotmail.com">hotmail.com</option>
                    <option value="nate.com">nate.com</option>
                    <option value="yahoo.co.kr">yahoo.co.kr</option>
                    <option value="empas.com">empas.com</option>
                    <option value="dreamwiz.com">dreamwiz.com</option>
                    <option value="freechal.com">freechal.com</option>
                    <option value="lycos.co.kr">lycos.co.kr</option>
                    <option value="korea.com">korea.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="hanmir.com">hanmir.com</option>
                    <option value="paran.com">paran.com</option>
                </select>
                <script type="text/javascript">
                    //이메일 입력방식 선택
                    $('#selectEmail').change(function(){
                        $("#selectEmail option:selected").each(function () {

                            if($(this).val()== '1'){ //직접입력일 경우
                                $("#secondEmail").val('');                        //값 초기화
                                $("#secondEmail").attr("disabled",false); //활성화
                            }else{ //직접입력이 아닐경우
                                $("#secondEmail").val($(this).text());      //선택값 입력
                                $("#secondEmail").attr("disabled",true); //비활성화
                            }
                        });
                    });
                </script>
            </td>
        </tr>
    </table>
    <br>
    <h5>선택 입력사항</h5>
    <table cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td>휴대폰</td>
            <td>
                <select id="bcm_phonenum1" name="bcm_phonenum1">
                    <c:when test="${user.bcm_phonenum1 == null}">
                        <option value="">::선택::</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${user.bcm_phonenum1}">${user.bcm_phonenum1}</option>
                    </c:otherwise>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="019">019</option>
                    <option value="010">010</option>
                </select>
                -<input type="text" id="bcm_phonenum2" size="4" name="bcm_phonenum2" value="${user.bcm_phonenum2}">-
                <input type="text" id="bcm_phonenum3" size="4" name="bcm_phonenum3" value="${user.bcm_phonenum3}">
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td>주소 입력란</td>
        </tr>
    </table>
    <div>

        <p>${user.bcm_num}</p>
        <p>${user.bcm_id}</p>
        <p>${user.bcm_pw}</p>
        <p>${user.bcm_name}</p>
        <p>${user.bcm_phonenum1}</p>
        <p>${user.bcm_phonenum2}</p>
        <p>${user.bcm_phonenum3}</p>
        <p>${user.bcm_address1}</p>
        <p>${user.bcm_address2}</p>
        <p>${user.bcm_address3}</p>
        <p>${user.bcm_address4}</p>
    </div>
    <input type="button" value="수정" onclick="">
</div>
</body>
</html>