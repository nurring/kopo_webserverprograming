<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<title>조회</title>

<% 
    try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
      Statement stmt = conn.createStatement();      
      //자료 읽어오기용 변수
      int LineCnt = 0;
      int fromNum = 0; //몇 번 부터 
        int toNum = 0; //몇 번 까지 
        int toCnt = 0; //몇 개를 조회할 것인지
        String fromTemp; //던지는 값을 일시적으로 받을 변수
        String toTemp; //던지는 값을 일시적으로 받을 변수        
         //값 받기
        fromTemp = request.getParameter("from"); //from이라는 이름은 내가 지정해준 것 
        toTemp = request.getParameter("cnt"); //몇개까지 값을 받았는지
        //최초에 받은 값이 없을 때
        if(fromTemp == null && toTemp == null){
            fromNum = 1; //제일 처음 값
            toCnt = 10; //10개씩 끊어서 조회한다.
        }else{  //(만약 받은 값이 있다면)페이지 이동 번호를 눌렀다면 그 값을 페이지 이동 값으로 보내줘야함
            fromNum = Integer.parseInt(fromTemp); //받은 String값을 Int값으로
            toCnt = Integer.parseInt(toTemp); //몇개를 조회할 것인지
        }toNum = fromNum + toCnt; //몇번부터 몇개를 조회할 것인지 = 몇번까지 조회할 것인지         
      //페이지용 변수
        final int firstPage_firstNum = 1; //맨 첫 페이지의 번호 
        int firstNum = 1; //각 페이지의 첫 항목의 번호 
        int prevPage_firstNum = 0; //이전 페이지용 
        int nextPage_firstNum = 0; //다음 페이지용
        int lastPage_firstNum = 0; //마지막 페이지용
        int totalLineCnt = 0; //데이터의 전체 라인 수 (마지막 페이지용)         
        ResultSet rset = stmt.executeQuery("select * from examtable;");
        while(rset.next()){
           totalLineCnt++;
        }
         //각 페이지의 첫 번째 링크 숫자
        String getFirstLink = request.getParameter("sendFirstLink");
        if(getFirstLink != null){
            firstNum = Integer.parseInt(getFirstLink);
        }
        //마지막 페이지 구하기
        lastPage_firstNum = ((int)(totalLineCnt/100)*10)+1;
        if (totalLineCnt == 100) lastPage_firstNum = 1; //위의 식에서 나올 오류의 예외처리용
        //이전 페이지 이동
        prevPage_firstNum = firstNum-10; // 이전페이지로 이동할 때는 해당페이지의 첫 번호-10
        if(prevPage_firstNum <= 0) prevPage_firstNum=1; //예외처리
        //다음 페이지 이동
        nextPage_firstNum = firstNum+10; //다음 페이지로 이동할 때는 해당페이지의 첫 번호 +10
        if(nextPage_firstNum > lastPage_firstNum+10){
        nextPage_firstNum = lastPage_firstNum; //다음페이지가 계속 나오지 않도록
        }
   %>

</head>
<body>
<h1>조회</h1>
   <table cellspacing=1 width=600 border=1>
      <tr>
         <td width=50 bgcolor=#9999ff><p align=center>이름</p></td>
         <td width=50 bgcolor=#9999ff><p align=center>학번</p></td>
         <td width=50 bgcolor=#9999ff><p align=center>국어</p></td>
         <td width=50 bgcolor=#9999ff><p align=center>영어</p></td>
         <td width=50 bgcolor=#9999ff><p align=center>수학</p></td>
      </tr>
   <%
      String name;
       String ckey;
      int sID;
      
      ResultSet rset2 = stmt.executeQuery("select * from examtable;");
      while(rset2.next()){
         
         sID = rset2.getInt(2); //학번
         name = rset2.getString(1);            //이름
         ckey = URLEncoder.encode(name, "utf-8");//이름 한글 처리
         LineCnt++;
         if(LineCnt < fromNum){continue;}
         if(LineCnt >= toNum){break;}
         
         out.println("<tr>");
         out.println("<td width=50><p align=center><a href=oneview.jsp?studentID="+sID+"&member="+name+">"+rset2.getString(1)+"</a></a></p></td>");
         out.println("<td width=50><p align=center>"+Integer.toString(rset2.getInt(2))+"</p></td>");
         out.println("<td width=50><p align=center>"+Integer.toString(rset2.getInt(3))+"</p></td>");
         out.println("<td width=50><p align=center>"+Integer.toString(rset2.getInt(4))+"</p></td>");
         out.println("<td width=50><p align=center>"+Integer.toString(rset2.getInt(5))+"</p></td>");
         out.println("</tr>");
         
      }%>
      </table>
        <%--페이지 수 만들기--%>
        <div style=height:2em></div>
        <table border=0>
            <tr id=Ltr>

                <td>
                    <a href ="AllviewDB.jsp?sendFirstLink=<%=firstPage_firstNum%>">≪</a>
                </td>
                <td>
                    <a href ="AllviewDB.jsp?sendFirstLink=<%=prevPage_firstNum%>&from=<%=prevPage_firstNum*10-9%>&cnt=10">＜</a>
                </td>
                
                <%
                    for(int i=firstNum; i<firstNum+10; i++){
                        //더이상 나올 데이터가 없을 경우 페이지 번호도 보이지 않는다
                        if((i*10)-9 > totalLineCnt) break;
                        out.print("<td>");
                        out.print("<a href=AllviewDB.jsp?sendFirstLink="+firstNum+"&from="+((i*10)-9)+"&cnt=10>"+i+"</a>");
                        out.print("</td>");
                    }
                %>
  
         

            </tr>
            </table>
   <%   rset.close();
      stmt.close();
      conn.close();
    }catch(Exception e){
       out.println("테이블이 없어요");
    }
   %>
   
</body>
</html>