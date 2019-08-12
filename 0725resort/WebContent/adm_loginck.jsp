<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<html>
<head>
<title>로그인체크</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("passwd");
	String dbid = "";
	String dbpass = "";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from reservationadmin where id='"+id+"' and pass='"+pass+"';");
	while(rset.next()){
		dbid = rset.getString(1);
		dbpass = rset.getString(2);
	}
	
	boolean bPassChk=false;	
	//아이디,비밀번호 체크
	if(id.replaceAll(" ","").equals(dbid) && pass.replaceAll(" ","").equals(dbpass)){
		bPassChk=true;
	}else{
		bPassChk=false;
	}
	
	//패스워드 체크가 끝나면 세션을 기록하고 점프
	if(bPassChk) {
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);
		response.sendRedirect("main.jsp"); //로그인 체크 이후 돌아갈 곳
	}else{
		out.println("<h2>아이디 또는 패스워드 오류</h2>");
		out.println("<button><a href='main.jsp'>메인페이지</button>");		
	}	
%>
</body>
</html>