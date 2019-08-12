<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>상품 하나씩 보기</title>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String keyNo = request.getParameter("key");
	
	String QueryTxt;
	QueryTxt = String.format("select * from product where id ="+keyNo+";");
	ResultSet rset = stmt.executeQuery(QueryTxt);
	
	
%>
<%!int qty;%>
<%!String nameStr;%>
</head>
<body>
	<div>	
	<div align=center><h1>상품 상세</h1></div>
		<table cellspacing=1 width=800 border=1 align=center>
		<%		
			while(rset.next()){
				out.println("<tr><td align=center width=150>상품번호</td>");
				out.println("<td align=left>"+rset.getInt(1)+"</td></tr>"); 
				
				out.println("<tr><td align=center>상품명</td>");
				out.println("<td align=left>"+rset.getString(2)+"</td></tr>");				
				nameStr = rset.getString(2);
				
				out.println("<tr><td align=center>재고 현황</td>");
				out.println("<td align=left>"+rset.getInt(3)+"</td></tr>");
				qty = rset.getInt(3);
				
				out.println("<tr><td align=center>상품 등록일</td>");
				out.println("<td align=left>"+rset.getDate(4)+"</td></tr>");	
				
				out.println("<tr><td align=center>마지막 재고 수정일</td>");
				out.println("<td align=left>"+rset.getDate(5)+"</td></tr>");	
				
				out.println("<tr><td align=center>상품 설명</td>");
				out.println("<td align=left>"+rset.getString(6)+"</td></tr>");
				
				out.println("<tr><td align=center>상품 사진</td>");
				out.println("<td align=center><img src='"+rset.getString(7)+"'></td></tr>");	
				
				
		}
		
			rset.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=800 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='productlist.jsp'">목록</button>
			<button type="button" onclick="location.href='product_delete.jsp?key=<%=keyNo %>&name=<%=nameStr %>'">삭제</button>
			<button type="button" onclick="location.href='product_update.jsp?key=<%=keyNo %>'">수정</button></td>
		</tr>
		</table>
		
		
	</div>
	
</body>
</html>