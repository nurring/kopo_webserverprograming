<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<html>
<head>
<title>답글 입력 처리단</title>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 	
	
	String uploadPath = request.getRealPath("");
	out.print(uploadPath);
	String id = null;
	String title = null;
	String content = null;
	String rootid = null;
	String newrelevel = null;
	String oldimg = null;
	String fileName1 = null;
	String orgfileName1 = null;
	
	//파일 저장하기
	try {
		MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10KB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);
		
		//파라미터 받아오기	
		id = multi.getParameter("id");
		title = multi.getParameter("title");	
		content = multi.getParameter("content");
		rootid = multi.getParameter("rootid");	
		newrelevel = multi.getParameter("newrelevel");
		oldimg = multi.getParameter("oldimg");
		
		fileName1 = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
		orgfileName1 = multi.getOriginalFileName("file1"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)

		
	} catch (Exception e) {
		out.print(e.toString());
	} // 업로드 종료	
	
	
	
	//db연결
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
		Statement stmt = conn.createStatement();
		ResultSet rset = null;
		
	
	
	if (id == null && rootid != null){ //답글
		stmt.execute("insert into gongji2 (title, date, content, rootid, relevel, imgurl) values('"+title+"', '"+sdt.format(calt.getTime())+"', '"+content+"', "+rootid+", '"+newrelevel+"','"+fileName1+"');");
		rset = stmt.executeQuery("select id from gongji2 where id=(select max(id) from gongji2);");	
	} else if(id == null && rootid == null){ //새 글
		stmt.execute("insert into gongji2 (title, date, content, relevel, imgurl) values('"+title+"','"+sdt.format(calt.getTime())+"','"+content+"','','"+fileName1+"');");
		stmt.execute("UPDATE gongji2 SET rootid = LAST_INSERT_ID() WHERE id = LAST_INSERT_ID();");
		rset = stmt.executeQuery("select id from gongji2 where id=(select max(id) from gongji2);");	
	} else if(id != null){ //수정
		if(fileName1 == null) {
			fileName1 = oldimg;
		}
		stmt.execute("update gongji2 set title= '"+title+"', content= '"+content+"', imgurl='"+fileName1+"' where id= "+id+";");
		rset = stmt.executeQuery("select id from gongji2 where id="+id+";");
	}
%>
</head>
<body>
<div>
<h1 align=center>작성 완료</h1>
	<%
	int newid = 0;
	while(rset.next()){
		newid=rset.getInt(1);
	}
	response.sendRedirect("gongji_view2.jsp?key="+newid);
	%>
	
</div>
</body>
</html>