<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>

<%
	
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	
	String btsid = request.getParameter("memberid");
	String btsname = request.getParameter("membername");
	
	String QueryTxt;
	QueryTxt = String.format("select * from examtable where studentid = '"+btsid+"';");
	ResultSet rset = stmt.executeQuery(QueryTxt);
	
	out.print("<h1> 방탄소년단 "+btsname+" 성적표(얼굴은 만점)</h1>");
%>


<table cellspacing=1 width=600 border=1>
<tr>
         <td width=50><p align=center>이름</p></td>
         <td width=50><p align=center>학번</p></td>
         <td width=50><p align=center>국어</p></td>
         <td width=50><p align=center>영어</p></td>
         <td width=50><p align=center>수학</p></td>
      	</tr>
<%
	while (rset.next()){
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");		
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>

</body>
</html>