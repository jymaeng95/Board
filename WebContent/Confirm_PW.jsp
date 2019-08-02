<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<style>
body {
	text-align : center;
	background-color : #97d5e0
}
</style>
<body>
	<form action="Check_PW.jsp" method="post">
		<%
		int num=0, flag = 0;
				
		flag = Integer.parseInt(request.getParameter("flag"));
		num = Integer.parseInt(request.getParameter("pNum"));
			
		%>
		<input type="hidden" value="<%=num %>" name="pNum">
		<input type="hidden" value="<%=flag %>" name="flag"> 
		비밀 번호 : <input type="password" name="pPw"> <br><br>
		<input type="submit" value="확인">
	</form>
</body>
</html>