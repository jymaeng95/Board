<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*, board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

</head>
<style>

body {
	background-color : #97d5e0
}

</style>
<body>
	<%
		Connection con = null;
		DB db = null;
		int num = 0;
		try{
			db = new DB();
			db.loadConnect();
			
			request.setCharacterEncoding("EUC-KR");
			num = Integer.parseInt(request.getParameter("pNum"));
			
			boolean check = db.updateRecommend(con,num);
			if(check){
				out.print("추천하였습니다");
			}else{
				out.print("추천에 실패 했습니다");
			}
	%>
	<br>
	<input type ="button" value = "확인" onclick = "window.close()">
	<% 
		}catch (Exception e){
			System.out.print("에러");
		}finally {
			db.close(con);
		}
	%>
	
</body>
</html>