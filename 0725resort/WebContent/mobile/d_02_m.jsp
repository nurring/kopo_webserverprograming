<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>예약하기 폼</title>
<link rel="stylesheet" type="text/css" href="/0725resort/resources/semantic.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
<script src="/0725resort/resources/semantic.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
html {
	font-size: 16px;
}

.container {
	margin: 50px;
}
body {
		  background-color: #ebebeb;
	}
</style>
 <script>
//3자리 단위마다 콤마 생성
 function addCommas(x) {
     return x.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-");
 }
  
 //모든 콤마 제거
 function removeCommas(x) {
     if(!x || x.length == 0) return "";
     else return x.split("-").join("");
 }
 
 $(document).ready(function(){
 $('#phone1, #phone2').on("focus", function() {
	    var x = $(this).val();
	    x = removeCommas(x);
	    $(this).val(x);
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x);
	        $(this).val(x);
	    }
	}).on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
 });
 
$(function() {                
    //시작일.
    $('#fromdate').datepicker({
        dateFormat: "yy-mm-dd",             // 날짜의 형식
        changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
        //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
        onClose: function( selectedDate ) {    
            // 시작일(fromDate) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            var mindate = new Date(selectedDate);
            mindate.setDate(mindate.getDate() + 1);
            
            $("#todate").datepicker( "option", "minDate", mindate );
        }                
    });

    //종료일
    $('#todate').datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        onClose: function( selectedDate ) {
            // 종료일(toDate) datepicker가 닫힐때
            // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            var mindate = new Date(selectedDate);
            mindate.setDate(mindate.getDate() -1);
            $("#fromdate").datepicker( "option", "maxDate", mindate );
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
String fromdate = request.getParameter("date");
String roomtype = request.getParameter("roomtype");
%>
</head>
<body>
	<div class="ui container">
		<form class="ui form" method="POST" action="d_02_write_m.jsp">
			<h4 class="ui dividing header">주문자 정보</h4>
			<div class="field">
				<label>성함</label>
				<div class="field">
					<input type="text" name="fullname" placeholder="성함" maxlength="10" required>
				</div>
			</div>

			<div class="field">
				<label>이메일 주소</label>
				<div class="two fields">
					<div class="field">
						<input type="text" name="email1" placeholder="e-mail id" maxlength="40" required>
					</div>
					<div>@</div>
					<div class="field">
						<input type="text" name="email2" placeholder="gmail.com" maxlength="40" required>
					</div>
				</div>
			</div>
			<div class="field">
				<label>핸드폰 번호</label>
				<div class="field">
					<input type="text" name="phone1" placeholder="연락 가능한 연락처를 남겨주세요." maxlength="13" id="phone1" required>
				</div>
			</div>
			<div class="field">
				<label>비상 연락처</label>
				<div class="field">
					<input type="text" name="phone2" placeholder="위의 번호 이외의 연락처를 남겨주세요." maxlength="13" id="phone2" required>
				</div>
			</div>

			<h4 class="ui dividing header">예약 정보</h4>

			<div class="field">
				<label>입금자명</label>
				<div class="field">
					<input type="text" name="payer" placeholder="입금자명을 입력하세요" maxlength="10" required>
				</div>
			</div>

			<div class="field">
				<label>룸타입</label>
				<div class="ui selection dropdown">
					<input type="hidden" name="roomtype" required>
					<div class="default text">예약하실 룸타입을 선택하세요</div>
					<i class="dropdown icon"></i>
					<%if(roomtype==null) {%>
					<div class="menu">
						<div class="item" data-value="vip">VIP룸</div>
						<div class="item" data-value="regular">일반룸</div>
						<div class="item" data-value="reasonable">합리적인 룸</div>
					</div>
					<%} 
      else {
			      	if (roomtype.equals("1")) {
			      		roomtype = "vip";     		
			      	}
			      	if (roomtype.equals("2")) {
			      		roomtype = "regular";     		
			      	}
			      	if (roomtype.equals("3")) {
			      		roomtype = "reasonable";     		
      				}      	
      %>
					<div class="menu">
						<div class="item" data-value="<%=roomtype %>">
							<%=roomtype %>
						</div>
					</div>
					<%} %>
				</div>
			</div>

			<div class="field">
				<label>인원수</label>
				<div class="ui selection dropdown">
					<input type="hidden" name="size" required>
					<div class="default text">투숙 예정 인원을 입력하세요</div>
					<i class="dropdown icon"></i>
					<div class="menu">
						<div class="item" data-value="1">1명</div>
						<div class="item" data-value="2">2명</div>
						<div class="item" data-value="3">3명</div>
						<div class="item" data-value="4">4명</div>
						<div class="item" data-value="5">5명</div>
						<div class="item" data-value="6">6명 이상</div>
					</div>
				</div>
			</div>

			<div class="inline fields">
				<label>체크인 </label>
				<%if(roomtype==null) {%>
				<div class="field">
					<input type="text" name="fromdate" id="fromdate" required>
				</div>
				<%} else {%>
				<div class="field">
					<input type="text" name="fromdate" id="fromdate" value="<%=fromdate %>" required>
				</div>
				<%} %>
			</div>
			<div class="inline fields">
				<label>체크아웃</label>
				<div class="field">
					<input type="text" name="todate" id="todate" required>
				</div>
			</div>

			<input type="submit" value="예약" class="ui button" id="submit" />
		</form>
	</div>

	<script>

$('.ui.dropdown').dropdown();
$('.ui.checkbox').checkbox();
</script>
</body>
</html>