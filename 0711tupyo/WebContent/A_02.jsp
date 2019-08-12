<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
	Statement stmt = conn.createStatement();
	String delid = request.getParameter("huboid");
	String delname = request.getParameter("huboname");
	
	stmt.execute("DELETE FROM hubo_table WHERE id ="+ delid +";");
	stmt.execute("DELETE FROM tupyo_table WHERE id ="+ delid +";");
%>
</head>
<body>
<h1>후보 등록 결과: <%= delname %> 후보가 삭제되었습니다.</h1>
<button type="button" onclick="location.href='register.jsp'">뒤로가기</button>
</body>
</html>