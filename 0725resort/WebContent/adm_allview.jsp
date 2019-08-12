<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<html>
<head>
<title>관리자 페이지</title>
<!-- bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<link type="text/css" rel="stylesheet" href="./resources/mainstyle.css">
<%
	Calendar cal;
	cal = Calendar.getInstance();
	SimpleDateFormat sdt = new SimpleDateFormat("dd");
	String today;
	today = sdt.format(cal.getTime());

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05", "root",
			"dc190105");
	Statement stmt = conn.createStatement();
	ResultSet rset = null;

	rset = stmt.executeQuery("SELECT " + "cal.onemonth, " + "DAYOFWEEK(cal.onemonth) AS DAY, "
			+ "IFNULL((SELECT a.id FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 1 AND staydate = cal.onemonth),'없음')AS VIPID,"
			+ "IFNULL((SELECT a.NAME FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 1 AND staydate = cal.onemonth),'예약 가능')AS VIP, "
			+ "IFNULL((SELECT a.id FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 2 AND staydate = cal.onemonth),'없음')AS REGULARID,"
			+ "IFNULL((SELECT a.NAME FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 2 AND staydate = cal.onemonth),'예약 가능')AS REGULAR, "
			+ "IFNULL((SELECT a.id FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 3 AND staydate = cal.onemonth),'없음')AS REASONABLEID, "
			+ "IFNULL((SELECT a.NAME FROM (SELECT id, NAME, roomtype FROM reservationlist)AS a "
			+ "right JOIN (SELECT * FROM reservationdate)AS b ON a.id = b.id WHERE b.roomtype = 3 AND staydate = cal.onemonth),'예약 가능')AS REASONABLE "
			+ "from " + "(	SELECT dt+ INTERVAL lv - 1 DAY onemonth "
			+ "from (SELECT ordinal_position lv, concat(DATE_FORMAT(NOW(), '%Y%m'),'" + today + "') dt "
			+ "FROM information_schema.COLUMNS " + "WHERE table_schema = 'mysql' "
			+ "AND TABLE_NAME = 'user') a " + "WHERE lv <= DAY(LAST_DAY(dt)) " + ")	cal;");
%>
</head>
<body>
<div class="content" style="padding:150px 500px 500px 150px;">
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
				<%
					while (rset.next()) {
						String available = "";
						String key = "";
				%>
				<tr>
					<td class="center aligned"><%=rset.getString(1)%></td>
					<!--일자  -->

					<%	available = rset.getString(4); //vip 예약자명
						key = rset.getString(3); //vip 예약 id
							if (available.equals("예약 가능")) {	%>
					<td class="center aligned"><a
						href='?contentPage=d_02.jsp?date=<%=rset.getString(1)%>&roomtype=1'><%=available%></a></td>
					<%	} else {	%>
					<td class="center aligned">					
						<a href='?contentPage=adm_oneview.jsp&key=<%=key%>'><%=available%></a></td>
					<%	}
						
						available = rset.getString(6); //일반룸 예약자명
						key = rset.getString(5); //일반룸 예약 id
							if (available.equals("예약 가능")) {
					%>
					<td class="center aligned"><a
						href='?contentPage=d_02.jsp?date=<%=rset.getString(1)%>&roomtype=2'><%=available%></a></td>
					<%	} else {	%>
					<td class="center aligned">
						<a href='?contentPage=adm_oneview.jsp&key=<%=key%>'><%=available%></a></td>
					<%
						}

						available = rset.getString(8); //일반룸 예약자명
						key = rset.getString(7); //일반룸 예약 id						
							if (available.equals("예약 가능")) {
					%>
					<td class="center aligned"><a
						href='?contentPage=d_02.jsp?date=<%=rset.getString(1)%>&roomtype=3'><%=available%></a></td>
					<%	} else {	%>
					<td class="center aligned">
						<a href='?contentPage=adm_oneview.jsp&key=<%=key%>'><%=available%></a></td>
				</tr>
				<%
			}
			}
			;
		%>

			</tbody>
	</table>
	<a href="main.jsp">메인 페이지 가기</a>
</div>

</body>
</html>