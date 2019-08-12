<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<style>
	table{
		margin: 10px;
		border-style: hidden;
        border-collapse: collapse;
	}
</style>
<script type="text/javascript">
	function validate(){
		var re_name =  /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,10}$/; //이름 한글인지 검사할 규칙
		var name = document.getElementById("name");		
		
		if(join.name.value == ""){ //이름이 비어있을 때
			alert("이름을 입력해 주세요.")
			join.name.focus();
			return false;
		}
		
		if(!check(re_name, name, "이름은 10자 이내 한글만 허용합니다.")){
			return false;
		}
	}
	function check(re, what, message) {
	       if(re.test(what.value)) {
	           return true;
	       }
	       alert(message);
	       what.value = "";
	       what.focus();
	       //return false;
	   }

</script>
<%

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String QueryTxt;
	QueryTxt = String.format("select * from hubo_table;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
</head>
<body>
<div class="container">
	<div>
	<form method="post" action="./A_01.jsp" name="join" onsubmit='return validate();'>
		<table class="table table-striped">
			<tr>
	         <th width=50><p align=center>번호</p></th>
	         <th width=50><p align=center>이름</p></th>
	         <th width=50><p align=center></p></th>	         
	      	</tr>
<%
		while(rset.next()){
			out.println("<tr>");
			out.println("<td align=center>"+rset.getInt(1)+"</td>");
			out.println("<td align=center>"+rset.getString(2)+"</td>");
			out.println("<td><a href=A_02.jsp?huboid="+rset.getInt(1)+"&huboname="+rset.getString(2)+"><button type='button' class='btn btn-primary'>삭제</button></td>");			
			out.println("</tr>");
		}
		rset.close();
		stmt.close();
		conn.close();			

%>		
			<tr>
			 <td align=center>자동 부여</td>
			 <td align=center><input type="text" name="huboname" id="name"></td>
			 <td><input type="submit" class='btn btn-primary' value="추가"></td>
			</tr>
			
		</table>
	</form>	
	</div>

</div>

</body>
</html>