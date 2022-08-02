<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>푸시 보내기</h2>

    <form action="/admin/FCMSender" method="post">
        <input type="text" name="notiTitle" placeholder="알림 타이틀" /> <br />
        <textarea name="notiBody" rows="4" cols="50" placeholder="알림 서브타이틀" ></textarea> <br />
        <textarea name="message" rows="4" cols="50" placeholder="알림 메세지" ></textarea> <br />
        <input type="submit" value="보내기" />
    </form>

</body>
</html>
