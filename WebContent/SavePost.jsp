`<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import ="java.sql.*,board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SavePost</title>
</head>

<body>
	<%
		Connection con = null;
		DB db = null;
		try{
			request.setCharacterEncoding("EUC-KR");
			db = new DB();
			con = db.loadConnect();
			String category = request.getParameter("category");
			String name = request.getParameter("name");
			String pPw = request.getParameter("pPw");
			String show = request.getParameter("show");
			String notice = request.getParameter("notice");
			String title = request.getParameter("title");
			String contents = request.getParameter("contents");
			
			boolean check = db.setPost(category, name, pPw, show, notice, title, contents);
			if(check){
				out.print("<script><alert('���Լ���')></script>");
			}else{
				out.print("<script><alert('���Խ���')></script>");
			}						
		}catch (Exception e){
			System.out.print("����");
		}finally {
			db.close(con);
		}
	%>
</body>
</html>