<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<%try{ %>


<%
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('김남준',209901,95,100,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('김석진',209902,95,95,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('민윤기',209903,100,100,100);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('정호석',209904,100,95,90);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('박지민',209905,80,100,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('김태형',209906,100,100,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('전정국',209907,70,70,70);");
	for(int i=0;i<250;i++){
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('전정"+i+"',"
			+(209908+i)+","+(int)(Math.random()*100)+","+(int)(Math.random()*100)+","+(int)(Math.random()*100)+");");		
	}
	
	
	stmt.close();
	conn.close();
	
	out.print("<h1>실습 데이터 입력 OK</h1>");
	
}catch (Exception e){
	out.println("테이블이 없거나 중복데이터입니다");
}
%>
</body>
</html>