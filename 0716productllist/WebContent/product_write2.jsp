<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<html>
<head>
<title>상품 수정 처리단</title>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	//받아오기
	String qty = request.getParameter("qty");
	String id = request.getParameter("id");	

	//db연결
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	stmt.execute("update product set qty="+qty+", qtychked='"+sdt.format(calt.getTime())+"' where id = "+id+";");
	String QueryTxt;
	QueryTxt = String.format("select * from product where id ="+id+";");
	ResultSet rset2 = stmt.executeQuery(QueryTxt);

	
	
%>
<%!int idNo;%>
<%!String nameStr;%>
</head>
<body>
	<div>
	<h1 align=center>상품 수정 완료</h1>
		<table cellspacing=1 width=600 border=1 align=center>
		<%
		int newNo = 0;
			while(rset2.next()){
				out.println("<tr><td align=center width=150>상품번호</td>");
				out.println("<td align=left>"+rset2.getInt(1)+"</td></tr>"); 
				idNo = rset2.getInt(1);
				
				out.println("<tr><td align=center>상품명</td>");
				out.println("<td align=left>"+rset2.getString(2)+"</td></tr>");		
				nameStr = rset2.getString(2);
				
				out.println("<tr><td align=center>재고 현황</td>");
				out.println("<td align=left>"+rset2.getInt(3)+"</td></tr>");				
				
				out.println("<tr><td align=center>상품 등록일</td>");
				out.println("<td align=left>"+rset2.getDate(4)+"</td></tr>");	
				
				out.println("<tr><td align=center>재고 등록일</td>");
				out.println("<td align=left>"+rset2.getDate(5)+"</td></tr>");	
				
				out.println("<tr><td align=center>상품 설명</td>");
				out.println("<td align=left>"+rset2.getString(6)+"</td></tr>");
				
				out.println("<tr><td align=center>상품 사진</td>");
				out.println("<td align=center><img src='"+rset2.getString(7)+"'></td></tr>");	
		}
			
			rset2.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='productlist.jsp'">목록</button>
			<button type="button" onclick="location.href='product_delete.jsp?key=<%=idNo %>&name=<%=nameStr %>'">삭제</button>
			<button type="button" onclick="location.href='product_update.jsp?key=<%=idNo %>'">수정</button></td>
		</tr>
		</table>	
		
	</div>

</body>
</html>