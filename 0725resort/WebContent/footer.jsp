<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<%
	//세션을 체크해서 없다면 로그인창으로 보낸다. 로그인이 되면 자기 자신에게 와야 하므로
	//자기 자신의 url을 써줘야 한다
	String loginOK=null;
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
%>
	<button class="btn btn-dark" onclick="location.href='adm_login.jsp'">관리자 로그인</button>
<%		return;
	}
	if(!loginOK.equals("yes")){
%>	
	<button class="btn btn-dark" onclick="location.href='adm_login.jsp'">관리자 로그인</button>	
<%		return;
	}else{
%>	
	<button class="btn btn-dark" onclick="location.href='adm_logout.jsp'">관리자 로그아웃</button>	
<%	}
%>
</body>
</html>