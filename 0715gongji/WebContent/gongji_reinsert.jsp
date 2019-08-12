<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<head>
<title>답글 작성 페이지</title>
<%
Calendar calt = Calendar.getInstance();
SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
%>
<%
	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	ResultSet rset = null;
	ResultSet rset2 = null;
	
	//파라미터 받기
	String key, relevelTmp;	
	key = request.getParameter("key");
	relevelTmp = request.getParameter("relevel");
	//recnt = request.getParameter("recnt");	
	
	int rootid=0;
	rset2 = stmt.executeQuery("select rootid from gongji where id =  "+key+";");
	while(rset2.next()){
		rootid = rset2.getInt(1);
	}
	
	int relevel = Integer.parseInt(relevelTmp);
	relevel += 1;
	
	int recnt=0;
	rset = stmt.executeQuery("SELECT MAX(recnt) FROM gongji WHERE rootid ="+rootid+" and relevel = "+relevel+";");
	while(rset.next()){
		recnt = rset.getInt(1);
		recnt +=1;
		out.print("recnt="+recnt);
	}
	
	
	
	
%>
</head>
<body>
<form method="post" action= "gongji_write.jsp"  id="insertform">
	<table align="center">
		<tr>
    		<td>글번호</td>
    		<td align="center">자동 부여</td>
    	</tr>    	
    	<tr>
    		<td>제목</td>
    		<td><input type="text" style="width:500px" name="title" maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
    	</tr>    	
    	<tr>
    		<td>날짜</td>
    		<td><%=sdt.format(calt.getTime()) %></td>
    	</tr>    	
    	<tr>
    		<td>내용</td>
    		<td><textarea style="width:500px; height: 500px;" id ="content" name="content" form="insertform" placeholder="100자 이내로 제한됩니다" required></textarea></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right">
    		<input type="hidden" name="key" value="<%=rootid%>"><%=rootid%>
    		<input type="hidden" name="relevel" value="<%=relevel%>">
    		<input type="hidden" name="recnt" value="<%=recnt%>">
    		<input type="submit" value="추가"></td>
    	</tr>
	</table>

</form>
</body>
</html>