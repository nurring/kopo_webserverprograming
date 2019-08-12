<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<meta charset="EUC-KR">
<%
	String voteid = request.getParameter("id");
	String voteage = request.getParameter("age");
	
	int voteidInt = Integer.parseInt(voteid);
	int voteageInt = Integer.parseInt(voteage);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
	Statement stmt = conn.createStatement();
	
	stmt.execute("insert into tupyo_table (id, age) values ("+ voteidInt +","+voteageInt+");");

%>
</head>
<body>

<h1>투표가 완료되었습니다.</h1>
<button type="button" onclick="history.go(-1)">뒤로가기</button>
</body>
</html>