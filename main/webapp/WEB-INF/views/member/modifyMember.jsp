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
<div>
    <c:import url="/menuTop"></c:import>
</div>
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
                    <c:choose>
                        <c:when test="${user.bcm_phonenum1 == null}">
                            <option value="">::선택::</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${user.bcm_phonenum1}">${user.bcm_phonenum1}</option>
                        </c:otherwise>
                    </c:choose>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="019">019</option>
                    <option value="010">010</option>
                </select>
                &nbsp;-&nbsp;
                <input type="text" id="bcm_phonenum2" size="4" name="bcm_phonenum2" value="${user.bcm_phonenum2}">
                &nbsp;-&nbsp;
                <input type="text" id="bcm_phonenum3" size="4" name="bcm_phonenum3" value="${user.bcm_phonenum3}">
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td>
                <input type="text" name="bcm_zipcode" id="sample2_postcode" placeholder="우편번호" disabled value="${user.bcm_address1}">
                <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
                <input type="text" name="bcm_address1" id="sample2_address" placeholder="주소" disabled value="${user.bcm_address2}"><br>
                <input type="text" name="bcm_address2" id="sample2_detailAddress" placeholder="상세주소" value="${user.bcm_address3}">
                <input type="text" name="bcm_address3" id="sample2_extraAddress" placeholder="참고항목" disabled value="${user.bcm_address4}">
            </td>
        </tr>
    </table>
    <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>
<%--    <div>--%>
<%--        <p>${user.bcm_num}</p>--%>
<%--        <p>${user.bcm_id}</p>--%>
<%--        <p>${user.bcm_pw}</p>--%>
<%--        <p>${user.bcm_name}</p>--%>
<%--        <p>${user.bcm_phonenum1}</p>--%>
<%--        <p>${user.bcm_phonenum2}</p>--%>
<%--        <p>${user.bcm_phonenum3}</p>--%>
<%--        <p>${user.bcm_address1}</p>--%>
<%--        <p>${user.bcm_address2}</p>--%>
<%--        <p>${user.bcm_address3}</p>--%>
<%--        <p>${user.bcm_address4}</p>--%>
<%--    </div>--%>
    <input type="button" value="수정" onclick="">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 600; //우편번호서비스가 들어갈 element의 width
        var height = 800; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</body>
</html>