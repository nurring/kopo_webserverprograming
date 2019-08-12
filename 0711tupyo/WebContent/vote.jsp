<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String QueryTxt;
	QueryTxt = String.format("select * from hubo_table;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
</head>
<body>
<form method="post" action="./B_02.jsp">
	<select name="id" required>
	    <option value="">기호</option>
<%
			while(rset.next()){
				out.println("<option value='"+rset.getInt(1)+"'>"+rset.getInt(1)+"번 "+rset.getString(2)+"</option>");
			}
%>	    
	</select>

	<select name="age" required>
	    <option value="">투표자 연령 조사</option>
	    <option value="10">10대</option>
	    <option value="20">20대</option>
	    <option value="30">30대</option>
	    <option value="40">40대</option>
	    <option value="50">50대</option>
	    <option value="60">60대</option>
	    <option value="70">70대</option>
	    <option value="80">80대</option>
	    <option value="90">90대</option>
	</select>
	<input type="submit" value="투표하기">
</form>	
</body>
</html>