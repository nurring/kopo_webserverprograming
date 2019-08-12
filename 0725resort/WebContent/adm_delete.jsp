<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.ArrayList"%>
<%@ page import="javasource.testdate"%>
<html>
<head>
<title>예약 정보 삭제</title>
<%
String id = request.getParameter("key");
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05", "root",
		"dc190105");
Statement stmt = conn.createStatement();
stmt.execute("delete from reservationlist where id="+id+";");
stmt.execute("delete from reservationdate where id="+id+";");
%>
<meta http-equiv="refresh" content="1; url=?contentPage=adm_allview.jsp"> 
</head>
<body>
<h3>삭제 완료</h3>
</body>
</html>