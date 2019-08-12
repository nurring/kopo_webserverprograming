<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<html>
<head>
<title>새글/답글/수정 처리단</title>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 	
	
	String uploadPath = request.getRealPath("image");
	String id = null;
	String title = null;
	String content = null;
	String rootid = null;
	String newrelevel = null;
	String oldimg = null;
	String fileName1 = null;
	String orgfileName1 = null;
	String board_id = null;
	int newid = 0;
	
	//파일 저장하기
		try {
			MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
					request, 
					uploadPath, // 파일을 저장할 디렉토리 지정
					1024 * 1024 * 10, // 첨부파일 최대 용량 설정(bite) / 10MB / 용량 초과 시 예외 발생
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
			board_id = multi.getParameter("board_id");	
			
			fileName1 = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
			orgfileName1 = multi.getOriginalFileName("file1"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
			
			System.out.println("id : "+id);
			System.out.println("title : "+title);
			System.out.println("content : "+content);
			System.out.println("rootid : "+rootid);
			System.out.println("newrelevel : "+newrelevel);
			System.out.println("oldimg : "+oldimg);
			System.out.println("fileName1 : "+fileName1);
			System.out.println("orgfileName1 : "+orgfileName1);
			
		} catch (Exception e) {
			out.print(e.toString());
		} // 업로드 종료	
		
		//db연결
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
		Statement stmt = conn.createStatement();
		PreparedStatement ps= null;		
		ResultSet rset = null;
		
		if (id == null && rootid != null){ //후기 답글
			ps = conn.prepareStatement("insert into resortboarditem (board_id, title, date, content, rootid, relevel, imgurl) values(?,?,?,?,?,?,?);");
			ps.setInt(1, 2);
			ps.setString(2, title);
			ps.setString(3, sdt.format(calt.getTime()));
			ps.setString(4, content);
			ps.setString(5, rootid);
			ps.setString(6, newrelevel);
			ps.setString(7, fileName1);
			ps.execute();			
			
			rset = stmt.executeQuery("select id from resortboarditem where id=(select max(id) from resortboarditem);");	
			
		} else if(id == null && rootid == null && board_id.equals("2")){ //후기 새 글
			ps = conn.prepareStatement("insert into resortboarditem (board_id, title, date, content, relevel, imgurl) values(?,?,?,?,?,?);");
			ps.setInt(1, 2);
			ps.setString(2, title);
			ps.setString(3, sdt.format(calt.getTime()));
			ps.setString(4, content);
			ps.setString(5, "");
			ps.setString(6, fileName1);
			ps.execute();
			
			stmt.execute("UPDATE resortboarditem SET rootid = LAST_INSERT_ID() WHERE id = LAST_INSERT_ID();");
			rset = stmt.executeQuery("select id from resortboarditem where id=(select max(id) from resortboarditem);");	
		} else if(id == null && rootid == null && board_id.equals("1")) { //공지 새 글
			ps = conn.prepareStatement("insert into resortboarditem (board_id, title, date, content, imgurl) values(?,?,?,?,?);");
			ps.setInt(1, 1);
			ps.setString(2, title);
			ps.setString(3, sdt.format(calt.getTime()));
			ps.setString(4, content);
			ps.setString(5, fileName1);
			ps.execute();
			
			rset = stmt.executeQuery("select id from resortboarditem where id=(select max(id) from resortboarditem);");	
		} else if(id != null){ //수정
			if(fileName1 == null) {
				fileName1 = oldimg;
			}
			ps = conn.prepareStatement("update resortboarditem set title=?, content=?, imgurl=? where id=?;");
			ps.setString(1, title);
			ps.setString(2, content);
			ps.setString(3, fileName1);
			ps.setString(4, id);
			ps.execute();
			
			rset = stmt.executeQuery("select id from resortboarditem where id="+id+";");
		}
		
		while(rset.next()){
			newid=rset.getInt(1);
		}
		
		
%>
</head>
<%if(board_id.equals("1")){ %>
<meta http-equiv="refresh" content="0.1; url=e_01_view_m.jsp?key=<%=newid%>"> 
<%} else if(board_id.equals("2")) { %>
<meta http-equiv="refresh" content="0.1; url=e_02_view_m.jsp?key=<%=newid%>"> 
<%} %>
<body>
</body>
</html>