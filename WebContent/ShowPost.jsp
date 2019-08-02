<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

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
		Connection con = null;
		DB db = null;
		ResultSet rs = null;
		String title="",name="",pdate="",contents="";
		int num=0,hit=0;
		try {
			db = new DB();
			db.loadConnect();
			request.setCharacterEncoding("EUC-KR");
			num = Integer.parseInt(request.getParameter("pNum"));
			
			db.updateHit(num);
			
			rs = db.getPostInfo(num);
			
			if(rs.next()){
				title = rs.getString("title");
				name = rs.getString("name");
				pdate = rs.getString("pDate");
				hit = rs.getInt("hit");
				contents = rs.getString("contents");
			}
			
		%>
		<br>
		<hr>
		<table>
			<tr align ="center">
				<td width = "600"><%= title%></td>
				<td width = "150"><%= name%></td>
				<td width = "150"><%= pdate%></td>
				<td width = "70"><%= hit%></td>
			</tr>
		</table>
		<hr>
		<table>
			<tr>
			<td width = "1000"><%= contents%></td>
		</table><br><br><br>
		<hr>
		<input type = "button"  value = "추천" name ="recommend" onClick ="window.open('Recom_update.jsp?pNum=<%=num%>','','top=100px, left=100px, height=100px, width=100px')">
		<input type = "button" value = "수정" name ="modify" onClick = "location.href = 'Confirm_PW.jsp?flag=1&pNum=<%=num%>'">
		<input type = "button" value = "삭제" name ="delete" onClick = "location.href = 'Confirm_PW.jsp?flag=2&pNum=<%=num%>'">		
		<input type = "button" value = "목록" onClick = "location.href = 'Board.jsp'">
		<% 
		}catch (Exception e) {
			System.out.print("에러");
		}finally {
			db.close(con);
		}
		
	%>
	
</body>
</html>