<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>로그인체크</title>
<meta http-equiv="refresh" content="1; url=main.jsp"> 
</head>
<body>
<%
session.invalidate();
out.println("<h2>로그아웃 되었습니다. 1초 뒤 메인페이지로 이동합니다.</h2>");
%>

</body>
</html>