<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
 
 <%
 
 // 추천수,조회수 업데이트 코드 작성 (밑에 삭제 후)
 //if("true".equals("추천 플래그")) {
	 //DB 저장
	 
	 
	 %>
<!-- 	 <script>alert("추천하였습니다.");</script> -->
	 <%
	 
// }
 
 
 %> 
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language = "javascript">
function submit(url, pNum, flag) {
	document.getElementById("pNum").value = pNum;
	document.getElementById("flag").value = flag;
	document.getElementById("showPost").setAttribute("action",url);
	document.getElementById("showPost").submit();
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
		Connection con = null;
		DB db = null;
		String title="",name="",pdate="",contents="";
		ArrayList <UserBean> list = null;
		int num=0,hit=0;
		try {
			db = new DB();
			con = db.loadConnect();
			list = new ArrayList<UserBean>();
			
			request.setCharacterEncoding("EUC-KR");
			num = Integer.parseInt(request.getParameter("pNum"));
			db.updateHit(con, num);
			
			list = db.getPostInfo(con, num);
			title = list.get(0).getTitle();
			name = list.get(0).getName();
			pdate = list.get(0).getPdate();
			hit = list.get(0).getHit();
			contents = list.get(0).getContents();
			
		%>
		<form name="showPost" id="showPost" action ="Confirm_PW.jsp" method="post">
		<input type="hidden" id="flag" name="flag" value="" />
		<input type="hidden" id="pNum" name="pNum" value="<%=num %>" />
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
		<input type = "button" value = "추천" name ="recommend" onClick ="window.open('Recom_update.jsp?pNum=<%=num %>','','top=100px, left=100px, height=100px, width=100px')">
		<input type = "button" value = "수정" name ="modify" onClick = "submit('Confirm_PW.jsp', '<%=num %>', '1');">
		<input type = "button" value = "삭제" name ="delete" onClick = "submit('Confirm_PW.jsp', '<%=num %>', '2');">		
		<input type = "button" value = "목록" onClick = "location.href = 'Board.jsp'">
		</form>
		<% 
		}catch (Exception e) {
			System.out.print("에러");
		}finally {
			db.close(con);
		}
		
	%>
	
</body>
</html>