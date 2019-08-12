<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<html>
<head>
<title>새 상품 입력 처리단</title>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	//파일 업로드할 변수/위치 선언
	//String uploadPath = "C:\\Users\\User\\eclipse-workspace\\0716productllist\\WebContent";
	String uploadPath = request.getRealPath("");
	out.print(uploadPath);
	String fileName1 = "";
	String orgfileName1 = "";
	String name="";
	String qty="";
	String description="";
	String id="";
	
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
		name = multi.getParameter("name");	
		qty = multi.getParameter("qty");
		description = multi.getParameter("description");
			
		
		//한글처리 : 멀티는 안해도 되더라규~
		//name = new String(name.getBytes("8859_1"),"utf-8");
		//description = new String(description.getBytes("8859_1"),"utf-8");

		/* form의 <input type="file"> name값을 모를 경우 name을 구할때 사용
		Enumeration files=multi.getFileNames(); // form의 type="file" name을 구함
		String file1 =(String)files.nextElement(); // 첫번째 type="file"의 name 저장
		String file2 =(String)files.nextElement(); // 두번째 type="file"의 name 저장
		*/
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
	
	stmt.execute("insert into product (name, qty, inserted, qtychked, description, imgurl) values ('"+name+"',"+qty+",'"+sdt.format(calt.getTime())+"','"+sdt.format(calt.getTime())+"','"+description+"','"+fileName1+"');");
	String QueryTxt;
	QueryTxt = String.format("select * from product where id =(select max(id) from product);");
	ResultSet rset2 = stmt.executeQuery(QueryTxt);
	
	
%>
<%!int idNo;%>
<%!String nameStr;%>
</head>
<body>
	<div>
	<h1 align=center>새 상품 추가 완료</h1>
		<table cellspacing=1 width=600 border=1 align=center>
		<%
		int newNo = 0;
			while(rset2.next()){
				out.println("<tr><td align=center width=150>상품번호</td>");
				out.println("<td align=left>"+rset2.getInt(1)+"</td></tr>"); 
				idNo = rset2.getInt(1);
				
				out.println("<tr><td align=center>상품명</td>");
				out.println("<td align=left>"+rset2.getString(2)+"</td></tr>");		
				nameStr = rset2.getString(2);
				
				out.println("<tr><td align=center>재고 현황</td>");
				out.println("<td align=left>"+rset2.getInt(3)+"</td></tr>");				
				
				out.println("<tr><td align=center>상품 등록일</td>");
				out.println("<td align=left>"+rset2.getDate(4)+"</td></tr>");	
				
				out.println("<tr><td align=center>재고 등록일</td>");
				out.println("<td align=left>"+rset2.getDate(5)+"</td></tr>");	
				
				out.println("<tr><td align=center>상품 설명</td>");
				out.println("<td align=left>"+rset2.getString(6)+"</td></tr>");
				
				out.println("<tr><td align=center>상품 사진</td>");
				out.println("<td align=center><img src='"+rset2.getString(7)+"'></td></tr>");	
		}
			
			rset2.close();
			stmt.close();
			conn.close();	
		%>
		</table>
		<table style="margin-top:10px" cellspacing=1 width=600 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='productlist.jsp'">목록</button>
			<button type="button" onclick="location.href='product_delete.jsp?key=<%=idNo %>&name=<%=nameStr %>'">삭제</button>
			<button type="button" onclick="location.href='product_update.jsp?key=<%=idNo %>'">수정</button></td>
		</tr>
		</table>	
		
	</div>

</body>
</html>