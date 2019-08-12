<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>리조트 소식</title>
<%
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = con.createStatement();
	String QueryTxt;
	QueryTxt = String.format("SELECT id, title, date, viewcnt FROM resortboarditem where board_id = 1 order by id desc");
	ResultSet rset = stmt.executeQuery(QueryTxt);
	

%>
</head>
<body>
<div style="height:103px; background-color:#200000;"></div>
<div style="padding:150px 300px 300px 150px;">
<table class="table table-striped">
	<thead class="thead-dark">
	<tr>
	   <th><p align=center>번호</p></th>
	   <th><p align=center>제목</p></th>
	   <th><p align=center>등록일</p></th>	
	   <th><p align=center>조회수</p></th>         
	</tr>
	</thead>
	<%while(rset.next()){%>
	<tr>
		<td align=center><%=rset.getInt(1) %></td>
		<td><a href=?contentPage=e_01_view.jsp&key=<%=rset.getInt(1)%>><%=rset.getString(2) %></a></td>
		<td align=center><%=rset.getDate(3) %></td>
		<td align=center><%=rset.getInt(4) %></td>				
	</tr>
	<%} %>
</table>
<%
String loginOK=null;

loginOK = (String)session.getAttribute("login_ok");
if(loginOK==null || !loginOK.equals("yes")){					
}else{
%>
	<table>
		<tr>
		<td style="align:right;"><button type="button" class="btn btn-dark" onclick="location.href='?contentPage=e_01_insert.jsp&board=1'">새 글 쓰기</button></td>
		</tr>
	</table>
<%}  %>
</div>
</body>
</html>