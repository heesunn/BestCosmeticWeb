<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        #cateoryLeft{
            background-color: black;
            width: 210px;
            color: white;

        }
        .list:hover{
            color: black;
            background-color: white;
            font-weight : bold;
        }
    </style>
</head>
<body>
    <div id="cateoryLeft">
        <h3>Best Cosmetic</h3>
        <hr>

			<ul>
					<li class="list" >전체보기</li>
					<hr>
                    <li class="list" >스킨케어</li>
                    <li class="list" >클렌징</li>
                    <li class="list" >선케어</li>
                    <li class="list" >베이스 메이크업</li>
                    <li class="list" onclick="javascript:window.location='categoryPoint'">포인트 메이크업</li>
                    <li class="list" >향수</li>
           </ul>

    </div>
</body>
</html>
