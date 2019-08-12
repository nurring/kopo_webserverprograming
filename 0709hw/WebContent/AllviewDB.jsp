<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<style>
	table{
		margin: 10px;
		border-style: hidden;
        border-collapse: collapse;
	}
</style>
<%
try{
		Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
		Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
		
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
		ResultSet rset2 = stmt.executeQuery("select * from examtable;");
		while(rset2.next()){
			totalLineCnt++;
		}
		
			
%>

<% 	
	//하이퍼링크값받기(각 링크페이지의 첫 링크번호)
	String getFirstLink = request.getParameter("sendFirstLink");
	if (getFirstLink != null){
	    firstLinkNum = Integer.parseInt(getFirstLink);}	
	
	//마지막 링크페이지의 첫 링크번호 (전체라인수/100 *10)+1
    lastPage_firstLinkNum = ((int)(totalLineCnt/100)*10)+1;
    if (totalLineCnt == 100) lastPage_firstLinkNum =1 ;//전체라인이 100일 때 11이나오므로 1로 정정
    
  	//이전페이지 가기
    prePage_firstLinkNum = firstLinkNum-10;
//    if(prePage_firstLinkNum <= 0) {
//    	prePage_firstLinkNum = 1; //마이너스 페이지는 없으므로 1페이지로 간다
//    }

    //다음페이지 가기
    nextPage_firstLinkNum = firstLinkNum+10;
//    if(nextPage_firstLinkNum > lastPage_firstLinkNum+10){
//        nextPage_firstLinkNum = lastPage_firstLinkNum; //최대 페이지 이상 출력되지 않게
//    }	

%>
</head>
<body>
<div>
	<div>
		<table cellspacing=1 width=600 border=1 align=center>
			<tr>
	         <th width=50><p align=center>이름</p></th>
	         <th width=50><p align=center>학번</p></th>
	         <th width=50><p align=center>국어</p></th>
	         <th width=50><p align=center>영어</p></th>
	         <th width=50><p align=center>수학</p></th>
	         <th width=50><p align=center>총점</p></th>
	         <th width=50><p align=center>평균</p></th>
	         <th width=50><p align=center>등수</p></th>
	      	</tr>
	
<%
		String QueryTxt;
		QueryTxt = String.format("select name, studentid, kor, eng, mat, (kor+eng+mat), ROUND(((kor+eng+mat)/3),2), rank "+
								 "from (select name, studentid, kor, eng, mat, (kor+eng+mat), ROUND(((kor+eng+mat)/3),2),"+ 
								 "CASE WHEN @prev_value = ROUND(((kor+eng+mat)/3),2) "+
								 "THEN @vRank "+
							  	 "WHEN @prev_value := ROUND(((kor+eng+mat)/3),2) "+
								 "THEN @vRank := @vRank + 1 END AS rank "+
								 "FROM "+
								 "examtable AS p, "+
								 "(SELECT @vRank := 0, @prev_value := NULL) AS r "+
								 "ORDER BY ROUND(((kor+eng+mat)/3),2) DESC) AS CNT;");
		ResultSet rset = stmt.executeQuery(QueryTxt);	
		while (rset.next()){	
			LineCnt++;
	        if(LineCnt < fromNum){continue;}
	        if(LineCnt >= toNum){break;}
			out.println("<tr>");
			out.println("<td width=50><p align=center><a href=OneviewDB.jsp?memberid="+Integer.toString(rset.getInt(2))+
					"&membername="+rset.getString(1)+">"+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(2)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(3)+"</p></td>"); 
			out.println("<td width=50><p align=center>"+rset.getInt(4)+"</p></td>"); 
			out.println("<td width=50><p align=center>"+rset.getInt(5)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getDouble(7)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(8)+"</p></td></tr>");		
		}		
		rset.close();
		stmt.close();
		conn.close();
	

%>
		</table>
	</div>
	<div style="height: 1em"></div>
	<div>
		<table border="0" align="center">
			<tr>
			<%if(firstLinkNum != 1){%>
			<td align="center">
			<a href="AllviewDB.jsp?sendFirstLink=<%=firstPage_firstLinkNum %>">≪</a>
			</td>
			<td align="center">
			<a href="AllviewDB.jsp?sendFirstLink=<%=prePage_firstLinkNum %>&from=<%=prePage_firstLinkNum*10-9 %>&cnt=10">＜</a>
			</td>
			<%}%>
<%
			for(int i=firstLinkNum; i<firstLinkNum+10; i++){
				if((i*10)-9 > totalLineCnt) break;				
				out.print("<td>");   
                out.print("<a href=AllviewDB.jsp?sendFirstLink="+firstLinkNum+"&from="+((i*10)-9)+"&cnt=10>"+i+"</a>");
                out.print("</td>");
			}	
%>
			<%if((firstLinkNum+9)*10 < totalLineCnt){%>
				<td> 
				<a href="AllviewDB.jsp?sendFirstLink=<%=nextPage_firstLinkNum%>&from=<%=nextPage_firstLinkNum*10-9 %>&cnt=10">
				＞</a>
				</td>
				<td> 
				<a href="AllviewDB.jsp?sendFirstLink=<%=lastPage_firstLinkNum%>&from=<%=lastPage_firstLinkNum*10-9 %>&cnt=10">
				≫</a>
				</td>
						
			<%} %>	
			</tr>
		</table>	
	</div>
</div>
<%

	}catch (Exception e){
		out.println("테이블이 없음다~");
	}

%>
</body>
</html>