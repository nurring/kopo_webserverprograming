<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글 삭제</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String id = request.getParameter("key");
	
	stmt.execute("DELETE FROM gongji2 WHERE id ="+ id +";");
	
%>
</head>
<body>
<h3>삭제 완료</h3>
<button type="button" onclick="location.href='gongjilist2.jsp'">목록</button>
</body>
</html>