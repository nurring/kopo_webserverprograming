<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<style>
	table{
		margin: 10px;
		border-style: hidden;
        border-collapse: collapse;
	}
</style>
</head>

<body>
<%try{ %>
<%
	
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	
	String btsid = request.getParameter("studentid");
	
	String QueryTxt;
	QueryTxt = String.format("select NAME, studentid, kor, eng, mat, kor+eng+mat, round((kor+eng+mat)/3, 2) from examtable where studentid = '"+btsid+"';");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>

<form method="post">
<table cellspacing=1 width=750 border=1>
<tr>
         <th ><p align=center>이름</p></th>
         <th ><p align=center>학번</p></th>
         <th ><p align=center>국어</p></th>
         <th ><p align=center>영어</p></th>
         <th ><p align=center>수학</p></th>
         <th ><p align=center>총점</p></th>
         <th ><p align=center>평균</p></th>
      	</tr>
	
<%	while (rset.next()){ %>
		<tr>
		<td align=center><input type='hidden' name='username' value='<%=rset.getString(1) %>'><%=rset.getString(1) %></td>
		<td align=center><input type='hidden' name='userid' value='<%=rset.getInt(2) %>'><%=rset.getInt(2) %></td>
		<td align=center><input type='number' value='<%=rset.getInt(3) %>' name='kor' min="0" max="100"></td>
		<td align=center><input type='number' value='<%=rset.getInt(4) %>' name='eng' min="0" max="100"></td>
		<td align=center><input type='number' value='<%=rset.getInt(5) %>' name='mat' min="0" max="100"></td>
		<td align=center><%=rset.getInt(6) %></td>
		<td align=center><%=rset.getDouble(7) %></td>
		</tr>
	<%}%>	
</table>
		<input type="submit" value="수정" formaction="./updateDB.jsp">
		<input type="submit" value="삭제" formaction="./deleteDB.jsp">	
</form>	
			
<%
	rset.close();
	stmt.close();
	conn.close();
	
}catch (Exception e){
	out.println("오류");
}
%>
	
</body>
</html>