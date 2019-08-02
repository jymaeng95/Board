<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*,board.*"%>
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
	
	return count;
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
		ResultSet rs = null;
		String category = null;
		int num=0;
		
		int i =0;
		int count=0;
		try{
			db = new DB();
			con = db.loadConnect();
			rs = db.getCategory();
	%>
	<h3> Board</h3><hr>
		<select id = "category"> 
			<option value =""> 게시판 이름 </option>
			<%
			while(rs.next()){		//select태그에 게시판 이름 option 넣기 
				category = rs.getString(1);
			%>
				<option value="<%=category%>"><%= category%></option>
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
		
		<div>
			<table class = "notice">
		<%
			rs = db.loadNotice();
			while(rs.next()){
				if(i>2){
					break;
				}
				num = rs.getInt("pNum");
		%>
			<tr align = "center">
				<td width = "70"><%= num%></td>
				<td width = "600"><a href ="ShowPost.jsp?pNum=<%=num%>">
				<%= rs.getString("title")%></a></td>
				<td width = "100"><%= rs.getString("name")%></td>
				<td width = "70"><%= rs.getInt("hit")%></td>
				<td width = "70"><%= rs.getInt("recommend")%></td>
				<td width = "150"><%= rs.getString("pdate")%></td>
			</tr>
		<%
			i++;
			}
		%>
		</table>
		</div><hr><hr>
		
		<div>
			<table class = "post">
		<%
			rs = db.getPostHeader();
		while(rs.next()){
			String show = rs.getString("show_YN");
			num = rs.getInt("pNum");
			if(show.equals("N")){
				%><tr align = "center">
				<td width = "70"><%= num%></td>
				<td width = "600"><a href ="Confirm_PW.jsp?flag=3&pNum=<%=num%>">공개되지 않은 글 입니다.</a></td>
				<td width = "100"><%= rs.getString("name")%></td>
				<td width = "70"><%= rs.getInt("hit")%></td>
				<td width = "70"><%= rs.getInt("recommend")%></td>
				<td width = "150"><%= rs.getString("pdate")%></td>
			</tr>
			<% 
			} else {
		%>	
			<tr align = "center">
				<td width = "70"><%= num%></td>
				<td width = "600"><a href ="ShowPost.jsp?pNum=<%=num%>">
				<%= rs.getString("title")%></a></td>
				<td width = "100"><%= rs.getString("name")%></td>
				<td width = "70"><%= rs.getInt("hit")%></td>
				<td width = "70"><%= rs.getInt("recommend")%></td>
				<td width = "150"><%= rs.getString("pdate")%></td>
			</tr>
		<% 	
			}
		}
		%>	
		</table>
		</div>
		<hr>
		
		<input type = "button" value = "글쓰기" onclick = "location.href = 'Post.jsp'">
		
	<% 	
			
		}catch (Exception e){
			System.out.print("에러");
			
		}finally {
			db.close(con);
		}
	%>
	
</body>
</html>