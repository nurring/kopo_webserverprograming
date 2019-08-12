<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>공지/새글 쓰기</title>
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
    $('#content').keyup(function (e){
        var content = $(this).val();
        $('#counter').html("("+content.length+" / 최대 700자)");    //글자수 실시간 카운팅

        if (content.length > 700){
            alert("최대 700자까지 입력 가능합니다.");
            $(this).val(content.substring(0, 700));
            $('#counter').html("(700 / 최대 700자)");
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
String boardnum = request.getParameter("board");
%>
</head>
<body>
<div class="container">
<form method="post" action= "?contentPage=e_01_write.jsp"  id="insertform" enctype="multipart/form-data">
	<table cellspacing=1 width=700 border=0 align=center>
		<tr>
    		<td width=100>글번호</td>
    		<td align="center">자동 부여</td>
    	</tr>    	
    	<tr>
    		<td>제목</td>
    		<td><input type="text" style="width:600px" name="title" maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
    	</tr>    	
    	<tr>
    		<td>날짜</td>
    		<td><%=sdt.format(calt.getTime()) %></td>
    	</tr>    	
    	<tr>
    		<td>내용</td>
    		<td>
    		<textarea style="width:500px; height: 500px;" id ="content" name="content" form="insertform" required></textarea>
    		<br><span style="color:#aaa;" id="counter">(0 / 최대 700자)</span>
    		</td>
    	</tr>
		<tr>
    		<td>사진</td>
    		<td><input type='file' name='file1' id="imgInp" />
				<img id="blah" src="#" alt="your image" />				
				<input type='hidden' name="board_id" value="<%=boardnum %>"></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right"><input type="submit" value="추가"></td>
    	</tr>
	</table>
</form>
</div>
</body>
</html>