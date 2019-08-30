<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  import="java.sql.*, board.*"%>

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
/* 			flag = Integer.parseInt(request.getParameter("flag")); */
			pw = request.getParameter("pPw");
			check = db.confirmPW(con,num,pw);
			
			String result = "{\"check\":\""+check+"\"}";
			out.print(result);
			%><%-- if(check>0){
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
			} --%>
	<% 	}catch (Exception e){
			System.out.print("¿¡·¯");
		}finally {
			db.close(con);
		}
	%>
