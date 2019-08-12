<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
<style>
body {
		  background-color: #ebebeb;
	}
</style>
</head>
<body>
<div class="container">
<table class="table table-striped">
	<thead class="thead-dark">
	<tr>
	   <th>no</th>
	   <th>제목</th>
	   <th>등록일</th>	
	   <th>view</th>         
	</tr>
	</thead>
	<%while(rset.next()){%>
	<tr>
		<td align=center><%=rset.getInt(1) %></td>
		<td><a href=e_01_view_m.jsp?key=<%=rset.getInt(1)%>><%=rset.getString(2) %></a></td>
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
		<td style="align:right;"><button type="button" class="btn btn-dark" onclick="location.href='e_01_insert_m.jsp?board=1'">새 글 쓰기</button></td>
		</tr>
	</table>
<%}  %>
</div>
</body>
</html>