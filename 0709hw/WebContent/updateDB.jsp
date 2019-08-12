<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<%try{ %>
<h1>성적 정정 완료</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	
	String btsname = request.getParameter("username");
	btsname = new String(btsname.getBytes("8859_1"),"utf-8");
	
	String btsid = request.getParameter("userid");
	btsid = new String(btsid.getBytes("8859_1"),"utf-8");
	
	String kor = request.getParameter("kor");	
	String eng = request.getParameter("eng");	
	String mat = request.getParameter("mat");
	
	stmt.execute("UPDATE examtable SET kor = "+kor+", eng = "+eng+", mat = "+ mat+" where studentid ="+ btsid +";");
	
	String QueryTxt;
	QueryTxt = String.format("select NAME, studentid, kor, eng, mat, kor+eng+mat, round((kor+eng+mat)/3, 2) from examtable;");
	ResultSet rset = stmt.executeQuery(QueryTxt);

%>

	<table cellspacing=1 width=600 border=1">
		<tr>
         <td width=50><p align=center>이름</p></td>
         <td width=50><p align=center>학번</p></td>
         <td width=50><p align=center>국어</p></td>
         <td width=50><p align=center>영어</p></td>
         <td width=50><p align=center>수학</p></td>
         <td width=50><p align=center>총점</p></td>
         <td width=50><p align=center>평균</p></td>
      	</tr>

<%
	while (rset.next()){
		if (rset.getInt(2) == Integer.parseInt(btsid)){
			out.println("<tr bgcolor=magenta>");
		} else {
		out.println("<tr>");}
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(2)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(3)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(4)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(5)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getDouble(7)+"</p></td></tr>");
	}		
	rset.close();
	stmt.close();
	conn.close();
	
	
	
}catch (Exception e){
	out.println("테이블이 없음다~");
}
%>
	

</body>
</html>