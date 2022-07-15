<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
        //처음 시작시 네이버캡챠 생성
        $(document).ready(function() {
            $.ajax({
                url : "/naverCaptcha",
                dataType:"json",
                success : function(data) {
                    $("#key").val(data.key);
                    $("#div01").html("<img src="+data.captchaImageName+"'/captchaImage'>");
                }
            });
        });
    </script>
    <script>
        //시작후 캡챠 리셋
        function codeReset() {
            $.ajax({
                url : "/naverCaptcha",
                dataType:"json",
                success : function(data) {
                    $("#key").val(data.key);
                    $("#div01").html("<img src="+data.captchaImageName+"'/captchaImage'>");
                }
            });
        }
    </script>
    <script>
        var isIdChecked = false;

        function idCheck() {
            if ($('#id').val().length == 0){
                $("#p1").html("아이디를 입력하세요");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length < 4) {
                $("#p1").html("아이디는 4자리 이상이어야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length >11) {
                $("#p1").html("아이디는 10자리 이하이어야 합니다.");
                $('#id').focus();
                return;
            }
            var idCheck = /^[a-zA-Z0-9]*$/;
            if (!idCheck.test($('#id').val())) {
                $("#p1").html("아이디는 영문 대/소문자와 숫자만 사용가능합니다.");
                $('#id').focus();
                return;
            }
            var queryString=$("#id").serialize();
            $.ajax({
                url : '/idCheck',
                type : 'POST',
                data : queryString,
                dataType: 'json',
                success : function(json) {
                    console.log(json);
                    if(json.userjson == null){
                        $("#p1").html("사용가능한 아이디입니다.");
                        isIdChecked = true;
                    }else {
                        $("#p1").html("중복된 아이디입니다.");
                        isIdChecked = false;
                    }
                }
            });
        }

        function form_check(){
            if ($('#id').val().length == 0){
                $("#p1").html("아이디를 입력하세요");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length < 4) {
                $("#p1").html("아이디는 4자리 이상이어야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length >11) {
                $("#p1").html("아이디는 10자리 이하이어야 합니다.");
                $('#id').focus();
                return;
            }
            var idCheck = /^[a-zA-Z0-9]*$/;
            if (!idCheck.test($('#id').val())) {
                $("#p1").html("아이디는 영문 대/소문자와 숫자만 사용가능합니다.");
                $('#id').focus();
                return;
            }
            if (isIdChecked==false){
                $("#p1").html("아이디 중복확인을 하셔야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#pw').val().length == 0){
                $("#p1").html("비밀번호를 입력하세요");
                $('#pw').focus();
                return;
            }
            var pwCheck = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
            if (!pwCheck.test($('#pw').val())) {
                $("#p1").html("비밀번호는 숫자,영문,특수문자를 포함한 8~16자리여야합니다.");
                $('#pw').focus();
                return;
            }
            //비밀번호와 비밀번호 확인 같은지 확인
            if($('#pw').val() != $('#pwConfirm').val()){
                $("#p1").html("비밀번호가 일치하지 않습니다.");
                $('#pwConfirm').focus();
                return;
            }
            if ($('#name').val().length == 0){
                $("#p1").html("이름을 입력하세요");
                $('#name').focus();
                return;
            }
            if ($('#name').val().length < 2){
                $("#p1").html("이름은 두자리 이상이어야 합니다.");
                $('#name').focus();
                return;
            }
            var nameCheck =/^[가-힣]*$/;
            if (!nameCheck.test($('#name').val())) {
                $("#p1").html("이름은 한글만 사용가능합니다.");
                $('#name').focus();
                return;
            }
            //secondEmail 잠시 활성화
            $("#secondEmail").attr("disabled",false);
            var firstEmailCheck =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
            var secondEmailCheck =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
            if ($('#firstEmail').val().length == 0){
                $("#p1").html("이메일을 입력하세요");
                $('#firstEmail').focus();
                return;
            }
            if (!firstEmailCheck.test($('#firstEmail').val())) {
                $("#p1").html("이메일 형식에 맞지 않습니다");
                $('#firstEmail').focus();
                return;
            }
            if ($('#secondEmail').val().length == 0){
                $("#p1").html("이메일을 입력하세요");
                $('#secondEmail').focus();
                return;
            }
            if (!secondEmailCheck.test($('#secondEmail').val())) {
                $("#p1").html("이메일 형식에 맞지 않습니다");
                $('#secondEmail').focus();
                return;
            }

            //네이버캡챠 result check
            var form01Data = $("#JoinForm").serialize();
            $.ajax({
                url : "/naverCaptcha",
                data : form01Data,
                success : function(data) {
                    console.log(data);
                    if(data=="true"){
                        submit_ajax();
                    }else{
                        $("#p1").html("보안코드를 다시입력해주세요");
                        //이메일 다시 비활성화
                        $("#secondEmail").attr("disabled",true);
                    }
                }
            });
        }

        function submit_ajax() {
            var queryString=$("#JoinForm").serialize();
            $.ajax({
                url : '/joinProcess',
                type : 'POST',
                data : queryString,
                dataType: 'json',
                success : function(json) {
                    console.log(json);
                    if(json.desc == "1"){
                        alert("회원가입되었습니다.")
                        $("#secondEmail").attr("disabled",true);
                        window.location.replace('/login');
                    } else if (json.desc == "0") {
                        $("#p1").html("데이터베이스입력에러");
                        $("#secondEmail").attr("disabled",true);
                    } else if (json.desc == "-1") {
                        $("#p1").html("회원가입 에러가 발생하면 문의부탁드립니다.");
                        $("#secondEmail").attr("disabled",true);
                    } else {
                        $("#secondEmail").attr("disabled",true);
                        $("#p1").html(json.desc);
                    }
                }
            });
        }
    </script>
</head>
<body>
    <h1>회원가입</h1>
    <form id="JoinForm">
        아이디 : <input type="text" id="id" name="id" placeholder="id" >
                <input type="button" value="중복확인" onclick="idCheck()"><br/>
        비밀번호 : <input type="password" id="pw" name="pw" placeholder="password" > <br/>
        비밀번호 확인 : <input type="password" id="pwConfirm" name="pwConfirm" placeholder="confirm password"> <br/>
        이름 : <input type="text" id="name" name="name" placeholder="name" > <br>
        이메일 : <input type="text" id="firstEmail" name="firstEmail" placeholder="email">@ <br>
                <input type="text" id="secondEmail" name="secondEmail" disabled value="naver.com">
        <select id="selectEmail" name="selectEmail">
            <option value="1">직접입력</option>
            <option value="naver.com" selected>naver.com</option>
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

        <div id="div01"><!--네이버캡챠 들어가는 곳--></div>
        <input type="hidden" id="key" name="key">
        <input type="text" name="value" placeholder="보안코드를 입력하세요">
        <img src="/image/icons-reset.png" onclick="codeReset()"/>
        <br/>
        <h4 id="p1" style="color: red"></h4>
        <input type="button" value="가입하기" onclick="form_check()">
    </form>
</body>
</html>
