<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>공지/후기 수정</title>
<script type="text/javascript">
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }

          reader.readAsDataURL(input.files[0]);
        }
    }
	$(document).ready(function(){
		$('#content').on('keyup', function(){
			if($(this).val().length > 100) {
				$(this).val($(this).val().substring(0,100));
			}
		});
	});

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
<%
Calendar calt = Calendar.getInstance();
SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 

String id = request.getParameter("key");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
	"root","dc190105");
Statement stmt = conn.createStatement();
ResultSet rset = stmt.executeQuery("select title, content, imgurl, board_id from resortboarditem where id="+id+";");

String title = "";
String content= "";
String imgurl= "";
int board_id= 0;

while(rset.next()){
	title = rset.getString(1);
	content = rset.getString(2);
	imgurl = rset.getString(3);	
	board_id = rset.getInt(4);
}
%>
</head>
<body>

<form method="post" action= "?contentPage=e_01_write.jsp" id="updateform" enctype="multipart/form-data">
	<table cellspacing=1 width=700 border=0 align=center>
		<tr>
    		<td width=100>글번호</td>
    		<td align="left"><input type="hidden" style="width:600px" name="id" value="<%=id %>"><%=id %></td>
    	</tr>    	
    	<tr>
    		<td>제목</td>
    		<td><input type="text" style="width:600px" name="title" value="<%=title %>" maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
    	</tr>    	
    	<tr>
    		<td>날짜</td>
    		<td><%=sdt.format(calt.getTime()) %></td>
    	</tr>    	
    	<tr>
    		<td>내용</td>
    		<td><input type="text" style="width:500px; height: 500px;" id ="content" name="content" value="<%=content %>"></td>
    	</tr>
    	<tr>
    		<td>사진</td>
    		<td><%if(imgurl != null) {%>
    			이전 사진: <img src='image/<%=imgurl %>'><%} %>
    					 <input type="hidden" style="width:600px" name="oldimg" value="<%=imgurl %>"><br>
    			새 사진 추가:
    			<input type='file' name='file1' id="imgInp" />
				<img id="blah" src="#" alt="이미지 미리보기" />	
				<input type='hidden' name="board_id" value="<%=board_id %>">	
    	</tr>
    	<tr>
    		<td colspan="2" align="right">
    			<button type="button" onclick="location.href='?contentPage=e_01.jsp'">취소</button>
    			<input type="submit" value="수정">
    			
    		</td>
    	</tr>    		
	</table>

</form>

</body>
</html>