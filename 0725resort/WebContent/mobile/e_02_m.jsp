<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page
	import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar"%>
<html>
<head>
<title>후기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<%
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt = new SimpleDateFormat("YYYY-MM-dd");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05", "root", "dc190105");
	Statement stmt = con.createStatement();
	String QueryTxt;
	QueryTxt = String.format(
			"SELECT id, relevel, title, date, viewcnt FROM resortboarditem where board_id = 2 ORDER BY rootid DESC, relevel ASC;");
	ResultSet rset = stmt.executeQuery(QueryTxt);

	int relevelnum = 0;
	String relevel;
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
			<%
				while (rset.next()) {
			%>
			<tr>
				<td align=center><%=rset.getInt(1)%></td>
				<td>
					<%
						relevel = rset.getString(2);
							relevelnum = relevel.length();
							if (relevelnum != 0) {
								while (relevelnum != 0) {
									out.print("　　");
									relevelnum--;
								}
								out.print(">[RE] ");
							}
					%> <a href=e_02_view_m.jsp?key=<%=rset.getInt(1)%>><%=rset.getString(3)%></a>
				</td>
				<td align=center><%=rset.getDate(4)%></td>
				<td align=center><%=rset.getInt(5)%></td>
			</tr>
			<%
				}
			%>
		</table>
		<table>
			<tr>
				<td><button type="button" class="btn btn-dark"
						onclick="location.href='e_01_insert_m.jsp?board=2'">새글
						쓰기</button></td>
			</tr>
		</table>
	</div>
</body>
</html>