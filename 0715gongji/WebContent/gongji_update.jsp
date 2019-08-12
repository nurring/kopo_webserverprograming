<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>Insert title here</title>
<%
	Calendar calt = Calendar.getInstance();
	SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
	
	String id = request.getParameter("key");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
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
</script>
</head>
<body>
<form method="post" action= "gongji_write.jsp" id="updateform" >
	<table align="center">
		<tr>
    		<td>글번호</td>
    		<td align="left"><input type="hidden" style="width:500px" name="id" value="<%=id %>"><%=id %></td>
    	</tr>    	
    	<tr>
    		<td>제목</td>
    		<td><input type="text" style="width:500px" name="title" value="<%=title%>" maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
    	</tr>    	
    	<tr>
    		<td>날짜</td>
    		<td><%=sdt.format(calt.getTime()) %></td>
    	</tr>    	
    	<tr>
    		<td>내용</td>
    		
    		<td><textarea style="width:500px; height: 500px;" id ="content" name="content" form="updateform" placeholder="100자 이내로 제한됩니다" required><%=content%></textarea></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right">
    			<button type="button" onclick="location.href='gongjilist.jsp'">취소</button>
    			<input type="submit" value="수정">
    			<button type="button" onclick="location.href='gongji_delete.jsp?key=<%=id %>'">삭제</button>
    		</td>
    	</tr>
    	
	
	</table>

</form>
</body>
</html>