<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>전체 화면</title>
<%
	// 넘어오는 값 받아서 div에 배치할 것 지정하기
	String contentPage = request.getParameter("contentPage");
	if (contentPage == null) {
		contentPage = "a_00.html";
	}
%>
</head>
<body>
	<div>
		 <jsp:include page="menu.jsp"/>
		<%--<%@ include file="menu.jsp"%>  --%> 
	</div>
	<div id="contents" class="container-fluid">
		<jsp:include page="<%=contentPage%>" />
	</div>
	<div>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>