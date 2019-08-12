$(document).ready( function() {
	$("#contents").load("a_00.html");
});
$(function(){
	$("#introduce #a_00").click(function(){ //리조트소개
		$("#contents").load("a_00.html");		
	});
});
$(function(){
	$("#introduce #a_01").click(function(){ //vip룸
		$("#contents").load("a_01.html");		
	});
});	
$(function(){
	$("#introduce #a_02").click(function(){ //일반룸
		$("#contents").load("a_02.html");		
	});
});	
$(function(){
	$("#introduce #a_03").click(function(){ //합리적인룸
		$("#contents").load("a_03.html");		
	});
});	
	
$(function(){
	$("#location #b_01").click(function(){ //오시는 길
		$("#contents").load("b_01.html");		
	});
});
$(function(){
	$("#location #b_02").click(function(){ //주차장 이용 안내
		$("#contents").load("b_02.html");		
	});
});
$(function(){
	$("#spots #c_01").click(function(){ //나누리 생가
		$("#contents").load("c_01.html");		
	});
});
$(function(){
	$("#spots #c_02").click(function(){ //나누리 단골 떡볶이집
		$("#contents").load("c_02.html");		
	});
});
$(function(){
	$("#booking #d_01").click(function(){ //예약리스트
		$("#contents").load("d_01.jsp");		
	});
});
$(function(){
	$("#booking #d_02").click(function(){ //예약하기
		$("#contents").load("d_02.html");		
	});
});
$(function(){
	$("#news #e_01").click(function(){ //리조트 소식
		$("#contents").load("e_01.jsp");		
	});
});
$(function(){
	$("#news #e_02").click(function(){ //후기
		$("#contents").load("e_02.jsp");		
	});
});