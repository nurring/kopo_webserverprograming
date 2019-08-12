<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
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
</head>
<body>
<div class="container">
<table  class="table table-striped">
<%
String relevel= null;
while(rset.next()){ %>
<tr>
	<td>글번호</td>
	<td><%=rset.getInt(1) %></td>
</tr>
<tr>
	<td>제목</td>
	<td><%=rset.getString(2) %></td>
</tr>
<tr>
	<td>일자</td>
	<td><%=rset.getDate(3) %></td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=rset.getInt(4) %></td>
</tr>
<tr>
	<td>내용</td>
	<td><%=rset.getString(5) %></td>
</tr>
<tr>
	<td>사진</td>
	<%if (rset.getString(6)!=null){ %>
	<td><img src='image/<%=rset.getString(6) %>'></td>
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
		<td><button class="btn btn-dark" type="button" onclick="location.href='?contentPage=e_02.jsp'">목록</button>			
			<button class="btn btn-dark" type="button" onclick="location.href='?contentPage=e_02_reinsert.jsp?key=<%=id %>&relevel=<%=relevel %>'">답글</button>
		 <%
		    String loginOK=null;
			
			loginOK = (String)session.getAttribute("login_ok");
			if(loginOK==null || !loginOK.equals("yes")){					
			}else{ %>
			<button class="btn btn-dark" type="button" onclick="location.href='?contentPage=e_01_update.jsp&key=<%=id %>'">수정</button>
			<button class="btn btn-dark" type="button" onclick="location.href='?contentPage=e_01_delete.jsp&key=<%=id %>&board=2'">삭제</button></td>
			<%}  %>
		</tr>
		</table>
</div>
</body>
</html>