<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>메뉴바 jsp</title>
<!-- bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link type="text/css" rel="stylesheet" href="./resources/mainstyle.css">
</head>
<script>
$(function(){
// 	$("#introduce #a_01").click(function(){ //리조트소개
// // 		 $.post("main.jsp", {contentPage: "a_01.html"}); 		
// 		 $.ajax ({
// 	            dataType:"json",
// 	            type: "POST",
// 	            url:"main.jsp",
// 	            data:{ "contentPage" : "a_01.html" },
// 	            success: function(data) {
// 	            	alert("success!");
// 	            },
// 	            error : function(error) {
// 	            	alert("fail..");
// 	            }
// 	        });
// 	});

	$(document).ready(function() {
		$(".top_menu").click(function(e) {
			document.location.href=e.currentTarget.search;
// 			console.log(e.currentTarget.search);
		});
	});
});
</script>
<body>

<div id="menu" class="container-fluid">
	<div style='float: left; padding-top:20px; '>
		<a href="?contentPage=a_00.html" id="a_00" class="top_menu">
		<img src="./image/5stars.png" style="width:100px" id="gg"></a>
		<p style="color: #fff;">NANURESORT</p>
	</div>     
	<div class="btn-group btn-group-toggle" data-toggle="buttons">    
		
		<label class="btn btn-secondary" id="introduce">
			<input type="radio" name="options" id="option1" autocomplete="off"> 리조트 소개
			<div class="dropdown-content">
			    <a href="?contentPage=a_00.html" id="a_00" class="top_menu">나누리조트</a>
			    <a href="?contentPage=a_01.html" id="a_01" class="top_menu">VIP룸</a>
			    <a href="?contentPage=a_02.html" id="a_02" class="top_menu">일반룸</a>
			    <a href="?contentPage=a_03.html" id="a_03" class="top_menu">합리적인룸</a>
		 	</div>
		</label>
		<label class="btn btn-secondary" id="location">
			<input type="radio" name="options" id="option2" autocomplete="off"> 오시는 길
			<div class="dropdown-content">
			    <a href="?contentPage=b_01.html" id="b_01" class="top_menu">오시는 길</a>
			    <a href="?contentPage=b_02.html" id="b_02" class="top_menu">주차장 이용 안내</a>
		 	</div>
		</label>
		<label class="btn btn-secondary" id="spots">
			<input type="radio" name="options" id="option3" autocomplete="off"> 주변 명소
			<div class="dropdown-content">
			    <a href="?contentPage=c_01.html" id="c_01" class="top_menu">나누리 생가</a>
			    <a href="?contentPage=c_02.html" id="c_02" class="top_menu">나누리 단골 떡볶이집</a>
		 	</div>
		</label>
		<label class="btn btn-secondary" id="booking">
			<input type="radio" name="options" id="option4" autocomplete="off"> 예약하기
			<div class="dropdown-content">
			    <a href="?contentPage=d_01.jsp" id="d_01" class="top_menu">예약 리스트</a>
			    <a href="?contentPage=d_02.jsp" id="d_02" class="top_menu">예약하기</a>
			    <%
			    String loginOK=null;
				
				loginOK = (String)session.getAttribute("login_ok");
				if(loginOK==null || !loginOK.equals("yes")){					
				}else{ %>
				<a href="?contentPage=adm_allview.jsp" id="adm_allview" class="top_menu">예약 리스트(admin)</a>
				<a href="?contentPage=adm_makedb.jsp" id="adm_makedb" class="top_menu">관리자 추가</a>					
				<%}  %>
		 	</div>
		</label>
		<label class="btn btn-secondary" id="news">
			<input type="radio" name="options" id="option5" autocomplete="off"> 리조트 소식
			<div class="dropdown-content">
			    <a href="?contentPage=e_01.jsp" id="e_01" class="top_menu">리조트 소식</a>
			    <a href="?contentPage=e_02.jsp" id="e_02" class="top_menu">후기</a>
		 	</div>
		</label>		
	</div>  
</div>

</body>
</html>