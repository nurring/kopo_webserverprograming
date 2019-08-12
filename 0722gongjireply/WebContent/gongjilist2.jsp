<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>공지리스트 2</title>
<style type="text/css">
	table {
    border-collapse: collapse;
  }
	.line{
		position: relative;
		}
</style>
<%
	//날짜포맷처리
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	
	//자료 읽어오는 변수
		int LineCnt = 0; //행 번호
	    int fromNum =0; //몇번부터
	    int toCnt = 0; //몇개를
	    int toNum =0; //그래서 몇개까지 조회할지 정하는 변수
	    String fromTemp;//던지는 값을 일시적으로 받을 변수
	    String toTemp; 
	    
	  	//파라미터 받기
		fromTemp = request.getParameter("from");
		toTemp = request.getParameter("cnt");
		
		if(fromTemp == null && toTemp == null){//최초에 받은 값이 없을 때
			fromNum = 1; //제일 처음 값
	        toCnt = 10; //10개씩 끊어서 조회한다.
		}else { 
			fromNum = Integer.parseInt(fromTemp);
			toCnt = Integer.parseInt(toTemp);
		}  
		toNum = fromNum + toCnt; 
		
		//페이징 처리 용 변수
		final int firstPage_firstLinkNum = 1;
		int firstLinkNum = 1; //각 링크페이지의 첫 링크 번호 (1, 11, 21..)
		int totalLineCnt = 0; //데이터 전체 라인 수
		int prePage_firstLinkNum = 0; //이전 링크페이지의 첫 링크 번호
		int nextPage_firstLinkNum = 0; //다음 링크페이지의 첫 링크 번호
		int lastPage_firstLinkNum = 0; //마지막 링크 페이지의 첫 링크 번호
		
		//데이터 전체 라인 수 구하기
		ResultSet rset2 = stmt.executeQuery("select * from gongji;");
		while(rset2.next()){
			totalLineCnt++;
		}
		
		//하이퍼링크값받기(각 링크페이지의 첫 링크번호)
		String getFirstLink = request.getParameter("sendFirstLink");
		if (getFirstLink != null){
		    firstLinkNum = Integer.parseInt(getFirstLink);}	
		
		//마지막 링크페이지의 첫 링크번호 (전체라인수/100 *10)+1
	    lastPage_firstLinkNum = ((int)(totalLineCnt/100)*10)+1;
	    if (totalLineCnt == 100) lastPage_firstLinkNum =1 ;//전체라인이 100일 때 11이나오므로 1로 정정
	    
	  	//이전페이지 가기
	    prePage_firstLinkNum = firstLinkNum-10;
	    //다음페이지 가기
	    nextPage_firstLinkNum = firstLinkNum+10;
	
	
	
	String QueryTxt;
	QueryTxt = String.format("SELECT id, relevel, title, date, viewcnt FROM gongji2 ORDER BY rootid DESC, relevel ASC;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
</head>
<body>

<div>
	<div align=center><h1>공지사항 리스트(eclipse 작성)</h1></div>
		<table class="parent" cellspacing=1 width=800 border=1 align=center>
			<tr>
		         <th width=50><p align=center>번호</p></th>
		         <th width=600><p align=center>제목</p></th>
		         <th width=100><p align=center>등록일</p></th>	
		         <th width=50><p align=center>조회수</p></th>         
	      	</tr>
<%
			while(rset.next()){
				LineCnt++;
		        if(LineCnt < fromNum){continue;}
		        if(LineCnt >= toNum){break;}
				out.println("<tr>");
				out.println("<td align=center style='height: 15;'>"+rset.getInt(1)+"</td>");
				out.println("<td>");
				String relevel = rset.getString(2);				
				int relevelnum = relevel.length();
				if (relevelnum != 0){
					while(relevelnum !=0){
						out.print("　　");
						relevelnum --;
					}
					out.print(">[RE] ");
				}
				out.println("<a href=gongji_view2.jsp?key="+rset.getInt(1)+">"+rset.getString(3)+"</a>");
				String realTime =sdt.format(calt.getTime());
				String getTime = sdt.format(rset.getDate(4));
				
				if (getTime.equals(realTime)){%>
					<img src="heart.png">
				<%}
				out.println("</td>");
				out.println("<td align=center>"+rset.getDate(4)+"</td>");	
				out.println("<td align=center>"+rset.getInt(5)+"</td>");
				out.println("</tr>");
			}
			rset.close();
			stmt.close();
			conn.close();			
%>				
		</table>
	</div>
	
			<div>
		<table border="0" align="center">
			<tr>
			<%if(firstLinkNum != 1){%>
			<td align="center">
			<a href="gongjilist2.jsp?sendFirstLink=<%=firstPage_firstLinkNum %>">≪</a>
			</td>
			<td align="center">
			<a href="gongjilist2.jsp?sendFirstLink=<%=prePage_firstLinkNum %>&from=<%=prePage_firstLinkNum*10-9 %>&cnt=10">＜</a>
			</td>
			<%}%>
<%
			for(int i=firstLinkNum; i<firstLinkNum+10; i++){
				if((i*10)-9 > totalLineCnt) break;				
				out.print("<td>");   
                out.print("<a href=gongjilist2.jsp?sendFirstLink="+firstLinkNum+"&from="+((i*10)-9)+"&cnt=10>"+i+"</a>");
                out.print("</td>");
			}	
%>
			<%if((firstLinkNum+9)*10 < totalLineCnt){%>
				<td> 
				<a href="gongjilist2.jsp?sendFirstLink=<%=nextPage_firstLinkNum%>&from=<%=nextPage_firstLinkNum*10-9 %>&cnt=10">
				＞</a>
				</td>
				<td> 
				<a href="gongjilist2.jsp?sendFirstLink=<%=lastPage_firstLinkNum%>&from=<%=lastPage_firstLinkNum*10-9 %>&cnt=10">
				≫</a>
				</td>
						
			<%} %>	
			</tr>
		</table>	
		</div>
	
	
	
	
	<table style="margin-top:10px" cellspacing=1 width=800 align=center>
		<tr align=right>
		<td><button type="button" onclick="location.href='gongji_insert2.jsp'">새 글 쓰기</button></td>
		</tr>
	</table>

</body>
</html>