<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Post</title>
</head>
<style>
hr {
	width : 700px;
	text-align : left;
	border-bottom : 0px;
}
body {
	background-color : #97d5e0
}

</style>
<body>
	<%
		Connection con = null;
		DB db = null;
		ResultSet rs = null;
		String category = null;
		try {
			db = new DB();
			con = db.loadConnect();		//db연결 
			rs = db.getCategory();
	%>
	
	<form action = "SavePost.jsp" method = "post">
	<h3>Post</h3>
		<hr>
		<select name = "category"> 
			<option value =""> 게시판 이름 </option>
			<%
			while(rs.next()){		//select태그에 게시판 이름 option 넣기 
				category = rs.getString(1);
			%>
				<option value="<%=category%>"><%= category%></option>
			<%
			}
			%>
		</select><br><hr>
	작성자 : 
	<input type="text" value="" name="name" size ="20">		
	비밀번호 :
	<input type = "password" value = "" name = "pPw" size="10">
	공개허용 : 
	<input type = "radio" name = "show" value ="Y"> Y 
	<input type = "radio" name = "show" value ="N"> N
	공지사항 : 
	<input type = "radio" name = "notice" value ="Y"> Y 
	<input type = "radio" name = "notice" value ="N"> N 
	 
	<br> <hr>
	<input type ="text" value ="" name = "title" size ="100">
	<br><hr>
	<textarea rows="20" cols="100" name = "contents"></textarea><br><br>
	<input type = "file" size = "70">
	<input type = "button" value = "목록" onClick = "location.href = 'Board.jsp'">
	<input type ="submit"  value = "확인">
	<%	
		} catch(Exception e) {
			System.out.print("에러");
		} finally {
			db.close(con);
		}
	%>
	</form>
</body>
</html>