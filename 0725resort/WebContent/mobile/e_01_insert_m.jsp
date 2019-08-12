<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>공지/새글 쓰기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script type="text/javascript">

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
<form method="post" action= "e_01_write_m.jsp"  id="insertform" 
	enctype="multipart/form-data">
	<table class="table">
		<tr>
    		<th scope="row">글번호</th>
    		<td>자동 부여</td>
    	</tr>    	
    	<tr>
    		<th scope="row">제목</th>
    		<td><input type="text" style="min-width: 100%" name="title" 
    			maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
    	</tr>    	
    	<tr>
    		<th scope="row">날짜</th>
    		<td><%=sdt.format(calt.getTime()) %></td>
    	</tr>    	
    	<tr>
    		<th scope="row">내용</th>
    		<td>
    		<textarea style="height: 350px;min-width: 100%;" id ="content" name="content" form="insertform" required></textarea>
    		<br><span style="color:#aaa;" id="counter">(0 / 최대 700자)</span>
    		</td>
    	</tr>
		<tr>
    		<th scope="row">사진</th>
    		<td><input type='file' name='file1' id="imgInp" />			
				<input type='hidden' name="board_id" value="<%=boardnum %>"></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right">
    		<button class="btn btn-dark" type="button" onclick="location.href='e_02_m.jsp'">취소</button>	
    		<input class="btn btn-dark" type="submit" value="추가"></td>
    	</tr>
	</table>
</form>
</div>
</body>
</html>