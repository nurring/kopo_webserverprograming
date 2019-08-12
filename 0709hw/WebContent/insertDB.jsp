<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>성적 입력 추가 완료</h1>

<%
try{
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역		
	
	//중간에 빈 숫자 찾아서 학번 넣어주는 연산
	int max = 0;	
	ResultSet rset = stmt.executeQuery("select * from examtable where studentid='209901';");
    if(rset.next()){
       rset = stmt.executeQuery("select min(studentid+1) from examtable where (studentid+1) not in (select studentid from examtable);");
       rset.next();
       max = rset.getInt(1);
    }
    else{ max = 209901; }
	
    //파라미터 받아오기
	String newName = request.getParameter("username");		
	newName = new String(newName.getBytes("8859_1"),"utf-8");
	String newKor = request.getParameter("kor");
	String newEng = request.getParameter("eng");
	String newMat = request.getParameter("mat");	
	
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('"+newName+"',"+max+','+newKor+","+newEng+","+newMat+");");
	
	String QueryTxt;
	QueryTxt = String.format("SELECT NAME, studentid, kor, eng, mat, kor+eng+mat, round((kor+eng+mat)/3, 2) FROM examtable WHERE studentid ="+max+";");
	ResultSet rset2 = stmt.executeQuery(QueryTxt);
%>
<button type="button" onclick="history.go(-1)">뒤로가기</button>
<table cellspacing=1 width=600 border=1>
<tr>
         <td width=50><p align=center>이름</p></td>
         <td width=50><p align=center>학번</p></td>
         <td width=50><p align=center>국어</p></td>
         <td width=50><p align=center>영어</p></td>
         <td width=50><p align=center>수학</p></td>
         <td width=50><p align=center>총점</p></td>
         <td width=50><p align=center>평균</p></td>
      	</tr>
<%
	while (rset2.next()){
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset2.getString(1)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset2.getInt(2)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset2.getInt(3)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset2.getInt(4)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset2.getInt(5)+"</p></td>");	
		out.println("<td width=50><p align=center>"+rset2.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset2.getDouble(7)+"</p></td></tr>");
	}
	rset.close();
	stmt.close();
	conn.close();

}catch (Exception e){
	out.println("오류요~");
}
%>
</table>
</body>
</html>