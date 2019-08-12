<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
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
<title>후기 내용 보기</title>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	
	String id = request.getParameter("key");
	
	stmt.execute("update resortboarditem set viewcnt=viewcnt+1 where id="+id+";");
	ResultSet rset = stmt.executeQuery("select id,title,date,viewcnt,content,imgurl, relevel from resortboarditem where id="+id+";");
%>
<style>
img {
 max-width: 100%;
}
body {
		  background-color: #ebebeb;
	}
</style>
</head>
<body>
<div class="container">
<table  class="table">
<%
String relevel= null;
while(rset.next()){ %>
<tr>
	<th scope="row">글번호</th>
	<td><%=rset.getInt(1) %></td>
</tr>
<tr>
	<th scope="row">제목</th>
	<td><%=rset.getString(2) %></td>
</tr>
<tr>
	<th scope="row">일자</th>
	<td><%=rset.getDate(3) %></td>
</tr>
<tr>
	<th scope="row">조회수</th>
	<td><%=rset.getInt(4) %></td>
</tr>
<tr>
	<th scope="row">내용</th>
	<td><%=rset.getString(5) %></td>
</tr>
<tr>
	<th scope="row">사진</th>
	<%if (rset.getString(6)!=null){ %>
	<td><img src='/0725resort/image/<%=rset.getString(6) %>'></td>
	<%}else { %>
	<td></td>
	<%} %>
</tr>
<%
relevel=rset.getString(7);
} %>
</table>
<table>
		<tr>
		<td><button class="btn btn-dark" type="button" onclick="location.href='e_02_m.jsp'">목록</button>			
			<button class="btn btn-dark" type="button" onclick="location.href='e_02_reinsert_m.jsp?key=<%=id %>&relevel=<%=relevel %>'">답글</button>
		 <%
		    String loginOK=null;
			
			loginOK = (String)session.getAttribute("login_ok");
			if(loginOK==null || !loginOK.equals("yes")){					
			}else{ %>
			<button class="btn btn-dark" type="button" onclick="location.href='e_01_update_m.jsp?key=<%=id %>'">수정</button>
			<button class="btn btn-dark" type="button" onclick="location.href='e_01_delete_m.jsp?key=<%=id %>&board=2'">삭제</button></td>
			<%}  %>
		</tr>
		</table>
</div>
</body>
</html>