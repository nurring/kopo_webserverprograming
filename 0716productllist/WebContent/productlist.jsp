<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>전체 상품 리스트</title>
<style type="text/css">
	table {
    border-collapse: collapse;
  }
	.line{
		position: relative;
		}
</style>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String QueryTxt;
	QueryTxt = String.format("select id, name, qty, qtychked, inserted from product;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
</head>
<body>
<div>
	<div align=center><h1>전체 상품 리스트(eclipse)</h1></div>
		<table class="parent" cellspacing=1 width=600 border=1 align=center>
			<tr>
		         <th width=100><p align=center>상품번호</p></th>
		         <th width=500><p align=center>상품명</p></th>
		         <th width=200><p align=center>재고</p></th>
		         <th width=300><p align=center>재고파악일</p></th>
		         <th width=300><p align=center>상품등록일</p></th>	         
	      	</tr>
<%
			while(rset.next()){
				out.println("<tr>");
				out.println("<td align=center>"+rset.getInt(1)+"</td>");
				out.println("<td align=center ><a href=product_view.jsp?key="+rset.getInt(1)+">"+rset.getString(2)+"</a></td>");
				out.println("<td align=center>"+rset.getInt(3)+"</td>");	
				out.println("<td align=center>"+rset.getDate(4)+"</td>");
				out.println("<td align=center>"+rset.getDate(5)+"</td>");
				out.println("</tr>");
			}
			rset.close();
			stmt.close();
			conn.close();			

%>				
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='product_insert.jsp'">신규등록</button></td>
		</tr>
		</table>
		
	</div>

</body>
</html>