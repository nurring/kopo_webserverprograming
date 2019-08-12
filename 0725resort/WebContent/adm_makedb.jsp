<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<html>
<head>
<title>관리자 추가</title>
</head>
<body>
<div class="container">
<h3>관리자 추가하기</h3>

<form method="POST">
ID:<input type="text" name="id" required>
PW:<input type="password" name="pass" required>
<input type="submit" value="생성">
</form>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	int chkid = 0;
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select count(id) from reservationadmin where id='"+id+"';");
	
	if(rset.next()){
		chkid =	rset.getInt(1);
	}
// 	System.out.println("id:"+id);
// 	System.out.println("pass:"+pass);
// 	System.out.println("chkid:"+chkid);
// 	out.println("id:"+id);
// 	out.println("pass:"+pass);
// 	out.println("chkid:"+chkid);
	
	if(chkid == 0 && id!= null){
		stmt.execute("insert into reservationadmin(id, pass) values('"+id+"','"+pass+"');");
	} else if (request.getParameter("id")==null) {}
	else {%>
<script>
	alert('아이디 중복입니다.');
</script>
<%}%>	
</div>
</body>
</html>