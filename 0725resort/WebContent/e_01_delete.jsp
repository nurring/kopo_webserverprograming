<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>글삭제</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String id = request.getParameter("key");
	String board = request.getParameter("board");
	
	stmt.execute("DELETE FROM resortboarditem WHERE id ="+ id +";");
	
%>
</head>
<body>
<h3>삭제 완료</h3>
<%if(board.equals("1")){ %>
<meta http-equiv="refresh" content="1; url=?contentPage=e_01.jsp"> 
<%} else if(board.equals("2")){%>
<meta http-equiv="refresh" content="1; url=?contentPage=e_02.jsp"> 
<%} %>
</body>
</html>