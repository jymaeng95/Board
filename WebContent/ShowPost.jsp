<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
 
 <%
  	Connection con = null;
  	DB db = null;
  	String title="",name="",pdate="",contents="";
  	ArrayList <UserBean> list = null;
  	int num=0,hit=0, recom = 0;
  	boolean checkHit = false;
   	boolean recommend;
   	
   // 추천수,조회수 업데이트 코드 작성 (밑에 삭제 후)
  	try {
  		db = new DB();
  		con = db.loadConnect();
  		list = new ArrayList<UserBean>();

  		num = Integer.parseInt(request.getParameter("pNum"));
  		recommend  = Boolean.parseBoolean(request.getParameter("recommend"));
  		%>
  		<script>alert("<%=recommend%>")</script>
  		<%
  		if(recommend){
  		%>
  			<script>alert("추천하였습니다");</script>
  		<%
  			db.updateRecommend(con, num);
  			checkHit = true;
  		}
  		
  		if (!checkHit) {
  			db.updateHit(con, num);
  			checkHit = true;
  		}
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language = "javascript">	
function submitToPw(url, pNum, flag) {
	document.getElementById("pNum").value = pNum;
	document.getElementById("flag").value = flag;
	document.getElementById("showPost").setAttribute("action",url);
	document.getElementById("showPost").submit();
}
function reloadPost(url,pNum,recommend) {
	document.getElementById("pNum").value = pNum;
	document.getElementById("recommend").value = recommend;
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
		request.setCharacterEncoding("EUC-KR");
		list = db.getPostInfo(con, num);
		title = list.get(0).getTitle();
		name = list.get(0).getName();
		pdate = list.get(0).getPdate();
		hit = list.get(0).getHit();
		recom = list.get(0).getRecommend();				
		contents = list.get(0).getContents();
			
	%>
		<form id="showPost" action="Confirm_PW.jsp" method="post">
		<hr>
		<table>
			<tr align ="center">
				<td width = "600"><%= title%></td>
				<td width = "150"><%= name%></td>
				<td width = "150"><%= pdate%></td>
				<td width = "70"><%= hit%></td>
				<td width = "70"><%= recom%></td>
			</tr>
		</table>
		<hr>
		<table>
			<tr>
			<td width = "1000"><%= contents%></td>
		</table><br><br><br>
		<input type="hidden" id="flag" name="flag" value="1" />
		<input type="hidden" id="pNum" name="pNum" value="<%=num %>" />
  		<input type= "hidden" id="recommend" name = "recommend" value ="">
		<br>
		<hr>
		<%
			if(recommend){
				%><input type="button" value = "추천" name = "recommend" disabled />
		<% 	} else { %>
				<input type = "button" value = "추천" name ="recommend" onclick ="reloadPost('ShowPost.jsp','<%=num %>','true');"/>
		<% } %>
		<input type = "button" value = "수정" name ="modify" onclick ="submitToPw('Confirm_PW.jsp','<%=num %>','1');"/>
		<input type = "button" value = "삭제" name ="delete" onclick ="submitToPw('Confirm_PW.jsp','<%=num %>','2');"/>		
		<input type = "button" value = "목록" onclick = "location.href = 'Board.jsp'">
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