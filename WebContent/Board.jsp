<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,board.*"%>
    <%
   // String lineCount = request.getParameter("lineCount");
    %>
  <!--    <script>alert("<%//=lineCount %>");</script>-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language = "javascript">
function count(){
	var selId = document.getElementById("count");
	var idx = selId.selectedIndex;
	var count = selId.options[idx].value;
	
	document.getElementById("formPost").setAttribute("action", "Board.jsp");
	document.getElementById("lineCount").value = count;
	document.getElementById("formPost").submit();
}

function submit(url, pNum, flag) {
	document.getElementById("pNum").value = pNum;
	document.getElementById("flag").value = flag;
	document.getElementById("formPost").setAttribute("action",url);
	document.getElementById("formPost").submit();
}


</script>
</head>
<style>
hr {
	width : 1100px;
	text-align : left;
	border-bottom : 0px;
}
body {
	background-color : #97d5e0
}
.head {
	font-weight : bold;
}
.notice {
	font-weight : bold;
}
</style>
<body>
	<%
		DB db = null;
		Connection con = null;
		String category = null;
		ResultSet rs = null;
		ArrayList<UserBean> list = null;
		int num=0, nextNum = 0;
		int count=0;
		boolean recommend = false;
		try{
			list = new ArrayList<UserBean>();
			request.setCharacterEncoding("EUC-KR");
			db = new DB();
			con = db.loadConnect();
			list = db.getCategory(con);
	%>
	<h3> Board</h3><hr>
		<select id = "category"> 
			<option value =""> 게시판 이름 </option>
			<%
				for(int i=0;i<list.size();i++){
			%>
				<option value="<%=list.get(i).getCategory() %>"><%=list.get(i).getCategory() %></option>
			<%
			}
			%>
		</select>
		<select id = "count" onchange="count()">
		
			<option value ="5" selected>5</option>
			<option value ="7">7</option>
			<option value ="10">10</option>
		</select><br><hr>
		<table class = "head">
			<tr align = "center">
				<td width = "70">글 번호</td>
				<td width = "600">제목 </td>
				<td width = "100">작성자</td>
				<td width = "70">조회수</td>
				<td width = "70">추천수</td>
				<td width = "150">날짜</td>
			</tr>
		</table><hr>
		
		<form id="formPost" action="Post.jsp" method="post">
		<% nextNum = db.getNextPnum(con); %>
			<input type="hidden" id="pNum" name="pNum" value="<%=nextNum %>" />
		<!--<input type="hidden" name="pNum" value="999" /> -->
			<input type="hidden" id="flag" name="flag" value="4" />
			<input type="hidden" id="lineCount" name="lineCount" value="" />
			<input type="hidden" value = "<%=recommend %>" name = "recommend">
		<div>
			<table class = "notice">
		<%
			list = db.loadNotice(con);
			for(int i=0;i<list.size();i++){
				num = list.get(i).getPnum();
		%>
			<tr align = "center">
				<td width = "70"><%= num%></td>
			
				<td width = "600"><a href ="javascript:submit('ShowPost.jsp', '<%=num%>', '');"><%=list.get(i).getTitle() %></a></td>
				<td width = "100"><%=list.get(i).getName()%></td>
				<td width = "70"><%=list.get(i).getHit()%></td>
				<td width = "70"><%=list.get(i).getRecommend()%></td>
				<td width = "150"><%=list.get(i).getPdate()%></td>
			</tr>
		<%
			}
		%>
		</table>
		</div><hr><hr>
		
		<div>
			<table class = "post">
		<%
			list = db.getPostHeader(con);
			for(int i=0;i<list.size();i++){
				String show = list.get(i).getShow();
				num = list.get(i).getPnum();
				
				if(show.equals("N")){
					%><tr align = "center">
					<td width = "70"><%=num%></td>
					<td width = "600"><a href ="javascript:submit('Confirm_PW.jsp', '<%=num%>', '3');">공개되지 않은 글 입니다.</a></td>
					<td width = "100"><%=list.get(i).getName()%></td>
					<td width = "70"><%=list.get(i).getHit()%></td>
					<td width = "70"><%=list.get(i).getRecommend()%></td>
					<td width = "150"><%=list.get(i).getPdate()%></td>
				</tr>
				<% 
				} else {
			%>	
				<tr align = "center">
					<td width = "70"><%= num%></td>
					<td width = "600"><a href ="javascript:submit('ShowPost.jsp', '<%=num%>', '');"><%=list.get(i).getTitle()%></a></td>
					<td width = "100"><%=list.get(i).getName()%></td>
					<td width = "70"><%=list.get(i).getHit()%></td>
					<td width = "70"><%=list.get(i).getRecommend()%></td>
					<td width = "150"><%=list.get(i).getPdate()%></td>
				</tr>
			<% 	
				}
			}
			%>	
			</table>
		</div><hr>
		<input type = "submit" value = "글쓰기">
		</form>
		
	<% 	
		}catch (Exception e){
			System.out.print("에러");
			
		}finally {
			db.close(con);
		}
	%>
	
</body>
</html>