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
	String addname = request.getParameter("huboname");
	addname = new String(addname.getBytes("8859_1"),"utf-8");
	
	//중간에 빈 숫자 찾아서 번호 넣어주는 연산
		int max = 0;	
		ResultSet rset2 = stmt.executeQuery("select * from hubo_table where id='1';");
		if(rset2.next()){
		       rset2 = stmt.executeQuery("select min(id+1) from hubo_table where (id+1) not in (select id from hubo_table);");
		       rset2.next();
		       max = rset2.getInt(1);
		    }
		 else{ max = 1; }

	stmt.execute("insert into hubo_table (id, name) values ("+ max +",'"+addname+"');");
	
%>
</head>
<body>
<h1>후보 등록 결과: <%= addname %> 후보가 등록되었습니다.</h1>
<button type="button" onclick="location.href='register.jsp'">뒤로가기</button>


</body>
</html>