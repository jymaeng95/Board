<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,board.*"%>
    <%
		String test2 = (request.getParameter("firstPaging") == null) ? "1" : request.getParameter("firstPaging");
    	int firstPaging = Integer.parseInt(test2);
    	
    	String test = (request.getParameter("paging") == null) ? "1" : request.getParameter("paging");
    	int paging = Integer.parseInt(test);
    	
    	String test3 = (request.getParameter("lineCount") == null) ? "3" : request.getParameter("lineCount");
    	int lineCount = Integer.parseInt(test3);
    %>
  <!--    <script>alert("<%//=lineCount %>");</script>-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language = "javascript">
function postCount(){
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

function onReload(paging,firstPaging) {
	document.getElementById("paging").value = paging;
	document.getElementById("firstPaging").value = firstPaging;
	document.getElementById("formPost").setAttribute("action", "Board.jsp");
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
		PageCount pCount = null;
		LastPage lastP = null;
		int num=0, nextNum = 0;
		int count=0;
		boolean recommend = false;
		
		int postCount=0,first=0,last=0, pageDevide = 0;
		try{
			list = new ArrayList<UserBean>();
			request.setCharacterEncoding("EUC-KR");
			db = new DB();
			con = db.loadConnect();
			list = db.getCategory(con);
	%>
	<h3> Board</h3><hr>
		<form id="formPost" action="Post.jsp" method="post">
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
		<select id = "count" onchange="postCount()">
			<option value ="3">3</option>
			<option value ="5" >5</option>
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
		
		<% nextNum = db.getNextPnum(con); %>
			<input type="hidden" id="pNum" name="pNum" value="<%=nextNum %>" />
			<input type="hidden" id="flag" name="flag" value="4" />
			<input type="hidden" id="lineCount" name="lineCount" value="<%=lineCount %>" />
			<input type="hidden" value = "<%=recommend %>" name = "recommend">
		<div>
			<table class = "notice">
		<%
			pageDevide = lineCount;
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
			postCount = db.countPost(con);
			
			
		%>
			<input type="hidden" id="paging" value = "<%=paging %>" name = "paging"/>
			<input type="hidden" id="firstPaging" value ="<%=firstPaging %>" name = "firstPaging"/>
			<script>alert("<%=paging%> / <%=firstPaging%> / <%=lineCount%>")</script>
		<% 
				
			if(postCount>=pageDevide){
				last = paging * pageDevide;
				first = last - pageDevide + 1;
				list = db.getPostHeader(con,first,last);
			} else {
				first = 1;
				last = pageDevide;
				list = db.getPostHeader(con,first,last);
			}
			for(int i=0;i<list.size();i++){
				String show = list.get(i).getShow();
				num = list.get(i).getPnum();
				if(show.equals("N")||show.equals("null")){
		%>
					<tr align = "center">
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
		<table>
		<%
				
			if(paging%10 == 1 && paging < 2){
		%>	
			<td width ="20"> << </td>
			<td width = "30"> < </td>
		<%
			} else if(paging%10 == 1){
				
		%>
			<td width ="20"><a href="javascript:onReload('<%=1 %>','<%=1 %>')"> << </a></td>
			<td width ="20"><a href="javascript:onReload('<%=paging-1%>','<%=firstPaging-10%>')"> < </a></td>
		<% } else {
		
		%>	
			<td width ="20"><a href="javascript:onReload('<%=1 %>','<%=1 %>')"> << </a></td>
			<td width = "30"><a href="javascript:onReload('<%=paging-1%>','<%=firstPaging %>')"> < </a></td>
		<%
		}
			pCount = new PageCount();
			int pageCount = pCount.paging(postCount, pageDevide);
		
			for(int i=firstPaging;i<=pageCount;i++){
				if(i%10==0) {
		%>
			<td width = "15"><a href ="javascript:onReload('<%=i%>','<%=firstPaging%>');"><%=i %></a></td>
		<% 		
			break;
			} else {
		%>		
		<td width = "15"><a href ="javascript:onReload('<%=i%>','<%=firstPaging%>');"><%=i %></a></td>
		<% 
			}
		}
			
		if(paging%10 == 0){
			firstPaging = paging+1;	
		%>
			<td width ="20"><a href="javascript:onReload('<%=paging+1%>','<%=firstPaging%>')"> > </a></td>
		<%	
		} else if(paging >= pageCount){
		%>
			<td width ="30"> > </td>
		<%	
			} else {
		%>
			<td width ="20"><a href="javascript:onReload('<%=paging+1%>','<%=firstPaging%>')"> > </a></td>
		<%	
		}
	
		lastP = new LastPage();
		lastP.lastPage(pageCount);
		%>
		
		<td width ="15"><a href="javascript:onReload('<%=pageCount%>','<%=lastP.lastPage(pageCount)%>')"> >> </a></td>
		<td width ="100"><input type = "submit" value = "글쓰기"></td>
		</table>
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