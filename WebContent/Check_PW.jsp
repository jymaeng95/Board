<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  import="java.sql.*, board.*"%>
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
		int num=0, flag=0, check=0;
		String pw = "";
		boolean checkPW = false;
		try{
			db = new DB();
			con = db.loadConnect();
			
			request.setCharacterEncoding("EUC-KR");
			
			num = Integer.parseInt(request.getParameter("pNum"));
			flag = Integer.parseInt(request.getParameter("flag"));
			pw = request.getParameter("pPw");
			check = db.confirmPW(con,num,pw);
				if(check>0){
					switch(flag){
					case 1:
						%><jsp:forward page = "Post.jsp">
						<jsp:param name="flag" value = "<%=flag %>"/>
						<jsp:param name="pNum" value = "<%=num %>"/>
						</jsp:forward>
						<% break;
					case 2:
						db.deletePost(con,num);
						%><jsp:forward page = "Board.jsp"/>
						<% break; 
					case 3:
						%><jsp:forward page = "ShowPost.jsp">
						<jsp:param name="pNum" value = "<%=num %>"/>
						</jsp:forward>
						<%break; 
					}
				}else {
				%>
				<script>history.go(-2);</script>
				<% 
			}
		}catch (Exception e){
			System.out.print("에러");
		}finally {
			db.close(con);
		}
	%>
</body>
</html>