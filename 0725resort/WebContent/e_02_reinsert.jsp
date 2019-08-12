<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page
	import="java.sql.*,javax.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Calendar,java.util.ArrayList"%>

<html>
<head>
<title>후기 답글 달기</title>
<script type="text/javascript">
	$(function() {
		$("#imgInp").on('change', function() {
			readURL(this);
		});
	});

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
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
	SimpleDateFormat sdt = new SimpleDateFormat("YYYY-MM-dd");

	Class.forName("com.mysql.jdbc.Driver");//문자열을 객체로 리턴
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05", "root",
			"dc190105");//db url,계정 정보를 식별자로 받아 연결을 시도
	Statement stmt = conn.createStatement();//쿼리를 생성/실행/반환한 결과를 가져올 작업영역
	ResultSet rset = null;
	ResultSet rset2 = null;

	//원글의 정보 파라미터 받아오기
	String id, relevel;
	id = request.getParameter("key"); //원글 글번호
	relevel = request.getParameter("relevel"); //원글 relevel (aba, aaaa ...)	

	int rootid = 0;
	rset = stmt.executeQuery("select rootid from resortboarditem where id =" + id + ";"); //원글의 rootid 받아오기
	while (rset.next()) {
		rootid = rset.getInt(1);
	}

	//원글의 relevel길이 which is 답글 level 깊이
	int relevellength = 0;
	relevellength = relevel.length();	

	//새로 생성 될 답글의 relevel 구하기
	String newrelevel = null; //다음자리 답글 중 마지막 글의 relevel 값 (ex. aa의 답글 aaa, aab, aac 중 aac를 취함)
	rset2 = stmt.executeQuery(
			"SELECT id, rootid, relevel FROM resortboarditem WHERE rootid = " + rootid + " and LENGTH(relevel) = "
					+ (relevellength + 1) + " AND relevel LIKE '" + relevel + "%' ORDER BY relevel;");
	while (rset2.next()) {
		newrelevel = rset2.getString(3);
	}
	
	if (newrelevel == null){
		newrelevel = relevel + 'a';
	} else {
		newrelevel = newrelevel.substring(relevellength, relevellength+1); //relevel값 끝자리 알파벳 끊어내기
		char alpa = newrelevel.charAt(0);
		int ialpa = (int)alpa; //ialpa : 끝자리 알파벳의 아스키코드
		
		int alpa2 = ialpa+1;
		char lastrelevel = (char)alpa2; //아스키코드에 +1해서 다시 알파벳으로 변환		
		
		newrelevel = relevel + lastrelevel;		
		//out.println(" newrelevel : "+newrelevel);			
	}
	
	System.out.println("rootid: " + rootid);
	System.out.println("relevellength+1: " + (relevellength + 1)); //원글이면 0
	System.out.println("newrelevel: " + newrelevel);
%>
</head>
<body>
	<form method="post" action="?contentPage=e_01_write.jsp" id="insertform"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>글번호</td>
				<td align="center">자동 부여</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" style="width: 500px" name="title"
					maxlength="50" placeholder="50자 이내로 제한됩니다" required></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><%=sdt.format(calt.getTime()) %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea style="width:500px; height: 500px;" id ="content" name="content" form="insertform" required></textarea>
	    		<br><span style="color:#aaa;" id="counter">(0 / 최대 700자)</span>
	    		</td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type='file' name='file1' id="imgInp" /> <img
					id="blah" src="#" alt="이미지 미리보기" /></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="hidden" name="rootid" value="<%=rootid%>"> 
				<input type="hidden" name="newrelevel" value="<%=newrelevel%>">
				<input type='hidden' name="board_id" value="2">
				<input type="submit" value="추가"></td>
			</tr>
		</table>
	</form>
</body>
</html>