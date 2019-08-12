<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<%@ page
	import="java.text.SimpleDateFormat,java.util.Date,java.util.Calendar,java.util.ArrayList"%>
<%@ page import="javasource.testdate"%>
<html>
<head>
<title>예약 처리단</title>
<link rel="stylesheet" type="text/css" href="resources/semantic.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
<script src="resources/semantic.js"></script>
<%
//받아올 변수 선언
	String fullname= "";
	String email1= "";
	String email2= "";
	String phone1= "";
	String phone2= "";
	String payer= "";
	String roomtype= "";
	String size= "";
	String fromdate= "";
	String todate= "";

//받아오기
	fullname = request.getParameter("fullname");
	email1 = request.getParameter("email1");	
	email2 = request.getParameter("email2");
	phone1 = request.getParameter("phone1");
	phone2 = request.getParameter("phone2");
	payer = request.getParameter("payer");
	roomtype = request.getParameter("roomtype");
	size = request.getParameter("size");
	fromdate = request.getParameter("fromdate");
	todate = request.getParameter("todate");
	
//한글처리
	fullname = new String(fullname.getBytes("8859_1"),"utf-8");
	payer = new String(payer.getBytes("8859_1"),"utf-8");

	
//db 입력될 자료형 만들기
	String email ="";
	String phone ="";	
	email = email1+"@"+email2;
	
	if (roomtype.equals("vip")) { 
		roomtype="1";
	}else if (roomtype.equals("regular")) {
		roomtype="2";
	}else {
		roomtype="3";
	}
	
//전체 숙박일 쭈루루룩~
	ArrayList<String> staydays;
	testdate gd = new testdate();
	staydays = gd.getdates(fromdate, todate);
	System.out.print("staydays: "+staydays);
	
//db연결
try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
		Statement stmt = con.createStatement();
		PreparedStatement ps= null;
		
		con.setAutoCommit(false);   
		ps = con.prepareStatement(  
	    		"insert into reservationlist(name, email, phone1, phone2, payer, roomtype, size, checkin, checkout) values(?,?,?,?,?,?,?,?,?)"); 
		ps.setString(1, fullname);
		ps.setString(2, email);
		ps.setString(3, phone1);
		ps.setString(4, phone2);
		ps.setString(5, payer);
		ps.setInt(6, Integer.parseInt(roomtype));
		ps.setInt(7, Integer.parseInt(size));
		ps.setString(8, fromdate);
		ps.setString(9, todate);
		ps.execute();
		
		ResultSet rset = null;
		rset = stmt.executeQuery("select id, roomtype from reservationlist where id=(select max(id) from reservationlist);");
		int newid = 0;
		int newroomtype = 0;
		while(rset.next()){
			newid=rset.getInt(1);
			newroomtype=rset.getInt(2);
		}		
		for(String date:staydays){
			ps = con.prepareStatement("insert into reservationdate(id, roomtype, staydate) values(?,?,?);");		
			ps.setInt(1, newid);
			ps.setInt(2, newroomtype);
			ps.setString(3, date);
			ps.execute();
		}	
		con.commit();
		
		
%>

</head>
<meta http-equiv="refresh" content="2; url=?contentPage=d_01.jsp">
<body>
	<p></p>
	<div style="padding: 300px 300px 300px 300px;">
		<div class="ui icon message">
			<i class="notched circle loading icon"></i>
			<div class="content">
				<div class="header">예약 완료</div>
				<p>2초 뒤 예약 리스트로 이동합니다.</p>
			</div>
		</div>
	</div>
	
<%}catch (Exception e){ %>
<script>
	alert("예약 가능한 일자를 확인하세요.");
	history.go(-1);
</script>
<%} %>

</body>
</html>