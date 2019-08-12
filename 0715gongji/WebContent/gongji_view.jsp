<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>공지사항 하나씩 보기</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	
	String keyNo = request.getParameter("key");
	
	stmt.execute("update gongji set viewcnt=viewcnt+1 where id="+keyNo+";");	
	String QueryTxt;
	QueryTxt = String.format("select * from gongji where id ="+keyNo+";");
	ResultSet rset = stmt.executeQuery(QueryTxt);
	
	
%>
<%!String title;%>
<%!String content; int relevel; 
//int recnt;
%>
</head>
<body>
	<div>
	
		<table cellspacing=1 width=600 border=1 align=center>
		<%		
			while(rset.next()){
				out.println("<tr><td align=center>글번호</td>");
				out.println("<td align=left>"+rset.getInt(1)+"</td></tr>"); 
				
				out.println("<tr><td align=center>제목</td>");
				out.println("<td align=left>"+rset.getString(2)+"</td></tr>");
				title = rset.getString(2);
				
				out.println("<tr><td align=center>일자</td>");
				out.println("<td align=left>"+rset.getDate(3)+"</td></tr>");
				
				out.println("<tr><td align=center>조회수</td>");
				out.println("<td align=left>"+rset.getString(8)+"</td></tr>");
				
				out.println("<tr><td align=center>내용</td>");
				out.println("<td align=left>"+rset.getString(4)+"</td></tr>");
				content = rset.getString(4);
				relevel = rset.getInt(6);
				//recnt = rset.getInt(7);				
		}
		
			rset.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='gongjilist.jsp'">목록</button>
			<button type="button" onclick="location.href='gongji_update.jsp?key=<%=keyNo %>&title=<%=title %>&content=<%=content %>'">수정</button>
			<button type="button" onclick="location.href='gongji_reinsert.jsp?key=<%=keyNo %>&relevel=<%=relevel %>'">답글</button></td>
		</tr>
		</table>
		
		
	</div>
	
</body>
</html>