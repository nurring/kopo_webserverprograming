<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar" %>

<html>
<head>
<title>상품 추가</title>
<style type="text/css">
	table {
    border-collapse: collapse;
  }
	.line{
		position: relative;
		}
</style>
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
</script>
<%
Calendar calt = Calendar.getInstance();
SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd"); 
%>
<%!String filename; %>
</head>
<body>
<div>
	<div align=center><h1>상품 추가</h1></div>
	
	<form action= "product_write.jsp" method="post"  id="insertform" enctype="multipart/form-data">
		<table cellspacing=1 width=800 border=0 align=center>
			<tr><td width=150>상품번호</td>
	    		<td>자동 부여</td></tr> 
	    		   	
	    	<tr><td>상품명</td>
	    		<td><input type="text" style="width:500px" name="name" required></td></tr> 
	    		   	
	    	<tr><td>재고 현황</td>
	    		<td><input type="number" style="width:500px" name="qty" required></td></tr> 
	    		 
	    	<tr><td>상품 등록일</td>
	    		<td><%=sdt.format(calt.getTime()) %></td></tr> 
	    		
	    	<tr><td>재고 등록일</td>
	    		<td><%=sdt.format(calt.getTime()) %></td></tr>  
	    		 	
	    	<tr><td>상품 설명</td>
	    		<td><textarea style="width:500px;" name="description" form="insertform" required></textarea></td></tr>
	    	
	    	<tr><td>상품 사진</td>
	    		<td><input type='file' name='file1' id="imgInp" />
        			<img id="blah" src="#" alt="your image" /></td></tr> 
        			
	    	<tr><td colspan="2" align="right"><input type="submit" value="추가"></td></tr>
		
		</table>
	</form>
</div>

</body>
</html>