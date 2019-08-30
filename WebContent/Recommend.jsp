<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
   <%@ page import="java.util.ArrayList"%>
<%
	DB db = null;
	Connection con = null;
	ArrayList <UserBean> list = null;
	int num = 0;
	int recom = 0;
	try{
		db = new DB();
		con = db.loadConnect();
		list = new ArrayList<UserBean>();
		
		num = Integer.parseInt(request.getParameter("pNum"));
		db.updateRecommend(con, num);
		
		list = db.getPostInfo(con, num);
		recom = list.get(0).getRecommend();
		
		String result = "{\"recommed\":\""+recom+"\"}"; 
		out.print(result);
	} catch (Exception e) {
		System.out.print("¿¡·¯");
	}finally {
		db.close(con);
	}
%>
	