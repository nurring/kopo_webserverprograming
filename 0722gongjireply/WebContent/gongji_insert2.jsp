<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>
<html>
<head>
<title>글쓰기</title>
    <!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<!-- include summernote-ko-KR --> 
<script src="lang/summernote-ko-KR.js"></script>
<script>
	$(document).ready(function() {
	  $('#content').summernote({
		  height: 500,
		  width: 600,
		  toolbar: [
			  ['style', ['style']],
			  ['font', ['bold', 'underline', 'clear']],
			  ['fontname', ['fontname']],
			  ['color', ['color']],
			  ['para', ['ul', 'ol', 'paragraph']],
			  ['table', ['table']],
			  ['view', ['fullscreen', 'codeview', 'help']],
			]
	  });
	});
</script>
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
    
</script>

<%
Calendar calt = Calendar.getInstance();
SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
%>


</head>
<body>
<form method="post" action= "gongji_write2.jsp"  id="insertform" enctype="multipart/form-data">
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
    		<td><textarea id ="content" name="content" form="insertform" required></textarea></td>
    	</tr>
		<tr>
    		<td>사진</td>
    		<td><input type='file' name='file1' id="imgInp" />
				<img id="blah" src="#" alt="your image" /></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right"><input type="submit" value="추가"></td>
    	</tr>
	</table>
</form>
</body>
</html>