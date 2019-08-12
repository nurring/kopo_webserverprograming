<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>관리자로그인</title>
</head>
<body>
<h1>관리자 로그인</h1>

<form method="post" action="adm_loginck.jsp">
<table border=1>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="submit" value="전송"></td>		
	</tr>
</table>
</form>
</body>
</html>