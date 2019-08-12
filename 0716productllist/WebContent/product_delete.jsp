<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>상품 삭제</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String idNo = request.getParameter("key");
	String nameStr = request.getParameter("name");
	
	stmt.execute("DELETE FROM product WHERE id ="+ idNo +";");
	
%>
</head>
<body>
<h3>[<%= nameStr %>] 삭제 완료</h3>
<button type="button" onclick="location.href='productlist.jsp'">목록</button>
</body>
</html>