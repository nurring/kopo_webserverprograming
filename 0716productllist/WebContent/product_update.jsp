<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>상품 수정</title>
<%
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	String id = request.getParameter("key");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	String QueryTxt;
	QueryTxt = String.format("select * from product where id ="+id+";");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
</head>
<body>
<%!String nameStr = ""; %>
<%!int qty = 0; %>
<form method="post" action= "product_write2.jsp">
	<table cellspacing=1 width=800 border=1 align=center">
		<%while(rset.next()){ %>
				<tr>
				<td align=center width=150>상품번호</td>
				<td align=left><input type="hidden" style="width:500px" name="id" value="<%=rset.getInt(1) %>"><%=rset.getInt(1) %></td>
				</tr>
				
				<tr><td align=center>상품명</td>
				<td align=left>><%=rset.getString(2) %></td>
				</tr>
				<%nameStr = rset.getString(2); %>
				
				<tr>
				<td align=center>재고 현황</td>
				<td align=left><input type="number" name="qty" value="<%=rset.getInt(3) %>" ></td>
				</tr>
				<%qty = rset.getInt(3); %>
				
				<tr><td align=center>상품 등록일</td>
				<td align=left><%=rset.getDate(4) %></td></tr>
				
				<tr><td align=center>마지막 재고 수정일</td>
				<td align=left><%=rset.getDate(5) %></td></tr>
				
				<tr><td align=center>상품 설명</td>
				<td align=left><%=rset.getString(6) %></td></tr>
				
				<tr><td align=center>상품 사진</td>
				<td align=center><img src='<%=rset.getString(7)%>'></td></tr>
				
				<tr>
    			<td colspan="2" align="right">
    			<button type="button" onclick="location.href='productlist.jsp'">취소</button>
    			<input type="submit" value="수정">
    			<button type="button" onclick="location.href='product_delete.jsp?key=<%=id %>&name=<%=nameStr %>'">삭제</button>
    		</td>
    	</tr>
		<%		
				
		}
		
			rset.close();
			stmt.close();
			conn.close();	
		%>
		</table>
	

</form>
</body>
</html>