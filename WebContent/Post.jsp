<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Post</title>
</head>
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
		</select><br><br>
	작성자 : 
	<input type="text" value="" name="name" size ="20">		
	비밀번호 :
	<input type = "password" value = "" name = "pPw" size="10">
	공개허용 : 
	<input type = "radio" name = "show" value ="Y"> Y 
	<input type = "radio" name = "show" value ="N"> N
	공지사항 : 
	<input type = "radio" name = "notice" value ="Y"> Y 
	<input type = "radio" name = "notice" value ="N"> N <br>
	 
	<br> 
	<input type ="text" value ="" name = "title" size ="100"><br>
	<br>
	<textarea rows="20" cols="100" name = "contents"></textarea><br>
	<input type ="submit" value = "확인">
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