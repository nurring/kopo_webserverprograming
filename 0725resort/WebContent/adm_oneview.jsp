<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>예약 상황(1개)</title>
<%
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd");
	String id = request.getParameter("key");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05", "root",
			"dc190105");
	Statement stmt = conn.createStatement();
	ResultSet rset = null;

	rset = stmt.executeQuery(
			"SELECT * FROM reservationlist a where a.id ="+id+";");

	String name = null;
	String email = null;
	String phone1 = null;
	String phone2 = null;
	String payer = null;
	int roomtype = 0;
	String checkin = null;
	String checkout = null;
	int size = 0;
	int processing = 0;
	while (rset.next()) {
		name = rset.getString(2);
		email = rset.getString(3);
		phone1 = rset.getString(4);
		phone2 = rset.getString(5);
		payer = rset.getString(6);
		size = rset.getInt(7);
		roomtype = rset.getInt(8);
		checkin = rset.getString(9);
		checkout = rset.getString(10);
		processing = rset.getInt(11);
	}
%>
<script type="text/javascript">
$(document).ready(function(){
	$("input, textarea").keyup(function(){
		var value = $(this).val();
		var arr_char = new Array();
		arr_char.push("'");
		arr_char.push("\"");
		arr_char.push("<");
		arr_char.push(">");
	
		for(var i=0 ; i<arr_char.length ; i++)	{
			if(value.indexOf(arr_char[i]) != -1)
			{	window.alert("<, >, ', \" 특수문자는 사용하실 수 없습니다.");
				value = value.substr(0, value.indexOf(arr_char[i]));
				$(this).val(value);		
			}
		}
	});
});
</script>
</head>
<body>

<div class="container">
<form method="POST" action="?contentPage=adm_update.jsp">
	<table class="table">
		<tr>
			<td>예약자명</td>
			<td><input type="text" name="name" value='<%=name%>'>
				<input type="hidden" name="id" value='<%=id%>'></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" value='<%=email%>'></td>
		</tr>
		<tr>
			<td>연락처1</td>
			<td><input type="text" name="phone1" value='<%=phone1%>'></td>
		</tr>
		<tr>
			<td>연락처2</td>
			<td><input type="text" name="phone2" value='<%=phone2%>'></td>
		</tr>
		<tr>
			<td>인원</td>
			<td><input type="number" name="size" value='<%=size%>'></td>
		</tr>
		<tr>
			<td>입금자명</td>
			<td><input type="text" name="payer" value='<%=payer%>'></td>
		</tr>
		<tr>
			<td>룸타입</td>
			<td><input type="number" name="roomtype" value='<%=roomtype%>'> (1:vip 2:regular 3:reasonable)</td>
		</tr>
		<tr>
			<td>체크인</td>
			<td><input type="date" name="checkin" value='<%=checkin%>'></td>
		</tr>
		<tr>
			<td>체크아웃</td>
			<td><input type="date" name="checkout" value='<%=checkout%>'></td>
		</tr>
		<tr>
			<td>지불상태</td>
			<td><input type="number" name="processing" value='<%=processing%>'> (1.예약신청 2.입금대기 3.입금확인)</td>
		</tr>
		<tr>
			<td><button type="button" class="btn btn-dark" onclick="location.href='?contentPage=adm_allview.jsp'">목록</button>
			<input type="submit" value="수정" class="btn btn-dark">
			<button type="button" class="btn btn-dark" onclick="location.href='?contentPage=adm_delete.jsp&key=<%=id %>'">삭제</button></td>
		</tr>
	</table>
</form>

</div>
</body>
</html>