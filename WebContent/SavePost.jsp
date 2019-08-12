<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*, board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection con = null;
		DB db = null;
		try{
			request.setCharacterEncoding("EUC-KR");
			db = new DB();
			con = db.loadConnect();
			
			int num = Integer.parseInt(request.getParameter("pNum"));
			int flag = Integer.parseInt(request.getParameter("flag"));
			
			Map <String, String> map = new HashMap<String, String>();
			
			map.put("category",request.getParameter("category"));
			map.put("name",request.getParameter("name"));
			map.put("pPw",request.getParameter("pPw"));
			map.put("show",request.getParameter("show"));
			map.put("notice",request.getParameter("notice"));
			map.put("title",request.getParameter("title"));
			map.put("contents",request.getParameter("contents"));
			if(flag == 1){
				map.put("pNum",request.getParameter("pNum"));
				boolean check = db.setModifyPost(con, map);
			}else {
				db.setPost(con,map);
			}
			
	%>
		<jsp:forward page = "ShowPost.jsp"/>
	<%
		}catch (Exception e){
			System.out.print("에러");
		}finally {
			db.close(con);
		}
	%>
</body>
</html>