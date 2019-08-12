<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head></head>
<body>
<h1> JSP Database 실습 1</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
		
	stmt.execute("UPDATE counter SET cntcnt=cntcnt+1;");
	
	String QueryTxt;
	QueryTxt = String.format("select * from counter;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
	
	while (rset.next()){
		out.println("현재 홈페이지 방문 조회수는 "+rset.getInt(1)+"입니다.");
	}
	rset.close();
	stmt.close();
	conn.close();
%>


</body>
</html>