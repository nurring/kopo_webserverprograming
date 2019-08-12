<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.*" %>
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
<title>예약리스트</title>
<%
	Calendar cal; 
	cal = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("dd");
	String today;
	today = sdt.format(cal.getTime());
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	ResultSet rset = null;
	
	rset = stmt.executeQuery("SELECT "+
							"cal.onemonth, "+
							"DAYOFWEEK(cal.onemonth) AS DAY, "+
							"IFNULL((SELECT insert(a.NAME,2,(char_LENGTH(a.NAME)-2),'**') FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "+ 
									"right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 1 AND staydate = cal.onemonth),'예약 가능')AS VIP, "+
							"IFNULL((SELECT insert(a.NAME,2,(char_LENGTH(a.NAME)-2),'**') FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "+
									"right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 2 AND staydate = cal.onemonth),'예약 가능')AS REGULAR, "+
							"IFNULL((SELECT insert(a.NAME,2,(char_LENGTH(a.NAME)-2),'**') FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "+
									"right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 3 AND staydate = cal.onemonth),'예약 가능')AS REASONABLE "+			 
							"from "+
							"(	SELECT dt+ INTERVAL lv - 1 DAY onemonth "+
								"from (SELECT ordinal_position lv, concat(DATE_FORMAT(NOW(), '%Y%m'),'"+today+"') dt "+
								"FROM information_schema.COLUMNS "+
								"WHERE table_schema = 'mysql' "+
								"AND TABLE_NAME = 'user') a "+
								"WHERE lv <= DAY(LAST_DAY(dt)) "+
							")	cal;");
%>
</head>
<body>
<div class="container"></div>
<div>
	<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
			<th class="center aligned">일자</th>
			<th class="center aligned">VIP룸</th>
			<th class="center aligned">일반룸</th>
			<th class="center aligned">합리적인 룸</th>
			</tr>
		</thead>
		<tbody>
			<% while(rset.next()){
			String available="";
			
			%>			
			<tr>
			<td class="center aligned"><%=rset.getString(1) %></td> <!--일자  -->
			
		<%  available = rset.getString(3); //vip룸
			if(available.equals("예약 가능")) {%>
			<td class="center aligned"><a href='d_02_m.jsp?date=<%=rset.getString(1) %>&roomtype=1'><%=available %></a></td>
		<%} else { %>
			<td class="center aligned"><%=rset.getString(3) %></td>
		<%} 
		
			available = rset.getString(4);
			if(available.equals("예약 가능")) {%>		
			<td class="center aligned"><a href='d_02_m.jsp?date=<%=rset.getString(1) %>&roomtype=2'><%=available %></a></td>
		<%} else { %>	
			<td class="center aligned"><%=rset.getString(4) %></td>
		<%}
		
			available = rset.getString(5);
			if(available.equals("예약 가능")) {%>	
			<td class="center aligned"><a href='d_02_m.jsp?date=<%=rset.getString(1) %>&roomtype=3'><%=available %></a></td>
		<%} else { %>		
			<td class="center aligned"><%=rset.getString(5) %></td>
			</tr>
		<%}
			}; %>
		</tbody>
	</table>
</div>
</body>
</html>