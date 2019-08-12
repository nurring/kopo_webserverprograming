<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>새 공지 입력 처리단</title>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	//db연결
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	//파라미터 받아오기	
	String title = request.getParameter("title");	
	String content = request.getParameter("content");
	String id = request.getParameter("id");	
	String rootid = request.getParameter("key");	
	String relevel = request.getParameter("relevel");
	String recnt = request.getParameter("recnt");	
	out.print(rootid);
	//int rootidint = Integer.parseInt(rootid);
	
	title = new String(title.getBytes("8859_1"),"utf-8");
	content = new String(content.getBytes("8859_1"),"utf-8");
	ResultSet rset2 = null;
	
	if( id == null ){ //새글 작성
		stmt.execute("insert into gongji (title, date, content, rootid, relevel, recnt) values ('"+title+"','"+sdt.format(calt.getTime())+"','"+content+"',"+rootid+","+relevel+","+recnt+");");
		if( rootid == null ){
			stmt.execute("UPDATE gongji SET rootid = LAST_INSERT_ID() WHERE id = LAST_INSERT_ID();");
		}	
		String QueryTxt;
		QueryTxt = String.format("select * from gongji where id =(select max(id) from gongji);");
		rset2 = stmt.executeQuery(QueryTxt);
	} else if ( id != null){ //글 수정 (id값 받아옴)
		stmt.execute("update gongji set title='"+title+"', content='"+content+"' where id = "+id+";"); //수정일자로 업데이트 되지 않게 설정했으유
		String QueryTxt;
		QueryTxt = String.format("select * from gongji where id ="+id+";");
		rset2 = stmt.executeQuery(QueryTxt);
	}	
%>
</head>
<body>
	<div>
	<h1 align=center>완료</h1>
		<table cellspacing=1 width=600 border=1 align=center>
		<%!String title;%>
		<%!String content;%>
		<%
		int newNo = 0;
			while(rset2.next()){
				out.println("<tr><td align=center>글번호</td>");
				out.println("<td align=left>"+rset2.getInt(1)+"</td></tr>");
				newNo = rset2.getInt(1);
				
				out.println("<tr><td align=center>제목</td>");
				out.println("<td align=left>"+rset2.getString(2)+"</td></tr>");
				title = rset2.getString(2);
				
				out.println("<tr><td align=center>일자</td>");
				out.println("<td align=left>"+rset2.getDate(3)+"</td></tr>");
				
				out.println("<tr><td align=center>내용</td>");
				out.println("<td align=left>"+rset2.getString(4)+"</td></tr>");
				content = rset2.getString(4);
		}
		
			rset2.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='gongjilist.jsp'">목록</button>
		<button type="button" onclick="location.href='gongji_update.jsp?key=<%=newNo %>&title=<%=title %>&content=<%=content %>'">수정</button></td>
		</tr>
		</table>
		
		
	</div>
</body>
</html>