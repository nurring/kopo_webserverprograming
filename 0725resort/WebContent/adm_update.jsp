<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.ArrayList"%>
<%@ page import="javasource.testdate"%>
<html>
<head>
<title>내용 수정</title>
<%
try{
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String payer = request.getParameter("payer");
	String size = request.getParameter("size");
	String roomtype = request.getParameter("roomtype");
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	String processing = request.getParameter("processing");
	
	name = new String(name.getBytes("8859_1"),"utf-8");
	payer = new String(payer.getBytes("8859_1"),"utf-8");
	
// 	out.println(name);out.println(email);out.println(phone1);
// 	out.println(phone2);out.println(size);out.println(payer);
// 	out.println(roomtype);out.println(checkin);out.println(checkout);out.println(processing);


//전체 숙박일 쭈루루룩~
	ArrayList<String> staydays;
	testdate gd = new testdate();
	staydays = gd.getdates(checkin, checkout);
	System.out.print("staydays: "+staydays);
	

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	PreparedStatement ps= null;	
	
	conn.setAutoCommit(false); 
	ps = conn.prepareStatement("UPDATE reservationlist SET NAME =?, email=?, phone1=?, phone2=?, payer=?, size=?, roomtype=?, checkin=?, checkout=?, processing=? WHERE id=?;");
	ps.setString(1,name);
	ps.setString(2, email);
	ps.setString(3, phone1);
	ps.setString(4, phone2);
	ps.setString(5, payer);
	ps.setString(6, size);
	ps.setString(7, roomtype);
	ps.setString(8, checkin);
	ps.setString(9, checkout);
	ps.setString(10, processing);
	ps.setString(11, id);
	ps.execute();
	
	stmt.execute("delete from reservationdate where id="+id+";");
	
	for(String date:staydays){
		ps = conn.prepareStatement("insert into reservationdate(id, roomtype, staydate) values(?,?,?);");
		ps.setString(1, id);
		ps.setString(2, roomtype);
		ps.setString(3, date);
		ps.execute();
	}
	conn.commit();
	
// 	response.sendRedirect("main.jsp?contentPage=adm_allview.jsp");

}catch (Exception e){ %>
<script>
	alert("예약 가능한 일자를 확인하세요.");
	history.go(-1);
</script>
<%} %>
</head>
<meta http-equiv="refresh" content="0.1; url=main.jsp?contentPage=adm_allview.jsp">
<body>

</body>
</html>