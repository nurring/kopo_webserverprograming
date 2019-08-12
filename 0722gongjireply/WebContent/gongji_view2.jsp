<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>Insert title here</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	
	String id = request.getParameter("key");
	
	stmt.execute("update gongji2 set viewcnt=viewcnt+1 where id="+id+";");	
	String QueryTxt;
	QueryTxt = String.format("select * from gongji2 where id ="+id+";");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
<%!String title;%>
<%!String content ; String relevel=null; String imgurl=null;
//int recnt;
%>
</head>
<body>
<div>
	
		<table cellspacing=1 width=600 border=1 align=center style='table-layout:fixed;'>
		<%		
			while(rset.next()){
				out.println("<tr height=50><td align=center width=50>글번호</td>");
				out.println("<td align=left>"+rset.getInt(1)+"</td></tr>"); 
				
				out.println("<tr height=50><td align=center>제목</td>");
				out.println("<td align=left>"+rset.getString(2)+"</td></tr>");
				title = rset.getString(2);
				
				out.println("<tr height=50><td align=center>일자</td>");
				out.println("<td align=left>"+rset.getDate(3)+"</td></tr>");
				
				out.println("<tr height=50><td align=center>조회수</td>");
				out.println("<td align=left>"+rset.getInt(7)+"</td></tr>");
				
				out.println("<tr height=50><td align=center>내용</td>");
				out.println("<td align=left style='word-break:break-all;'>"+rset.getString(4)+"</td></tr>");
				
				out.println("<tr><td align=center>사진</td>");
				out.println("<td align=left><img src='"+rset.getString(8)+"'></td></tr>");
				content = rset.getString(4);
				relevel = rset.getString(6);	
				imgurl = rset.getString(8);
		}
		
			rset.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='gongjilist2.jsp'">목록</button>
			<button type="button" onclick="location.href='gongji_update2.jsp?key=<%=id %>'">수정</button>
			<button type="button" onclick="location.href='gongji_reinsert2.jsp?key=<%=id %>&relevel=<%=relevel %>'">답글</button>
			<button type="button" onclick="location.href='gongji_delete2.jsp?key=<%=id %>'">삭제</button></td>
		</tr>
		</table>
		
		
	</div>
</body>
</html>