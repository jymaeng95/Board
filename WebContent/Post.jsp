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
			con = db.loadConnect();		//db���� 
			rs = db.getCategory();
	%>
	
	<form action = "SavePost.jsp" method = "post">
	<h3>Post</h3>
		<hr>
		<select name = "category"> 
			<option value =""> �Խ��� �̸� </option>
			<%
			while(rs.next()){		//select�±׿� �Խ��� �̸� option �ֱ� 
				category = rs.getString(1);
			%>
				<option value="<%=category%>"><%= category%></option>
			<%
			}
			%>
		</select><br><hr>
	�ۼ��� : 
	<input type="text" value="" name="name" size ="20">		
	��й�ȣ :
	<input type = "password" value = "" name = "pPw" size="10">
	������� : 
	<input type = "radio" name = "show" value ="Y"> Y 
	<input type = "radio" name = "show" value ="N"> N
	�������� : 
	<input type = "radio" name = "notice" value ="Y"> Y 
	<input type = "radio" name = "notice" value ="N"> N 
	 
	<br> <hr>
	<input type ="text" value ="" name = "title" size ="100">
	<br><hr>
	<textarea rows="20" cols="100" name = "contents"></textarea><br><br>
	<input type = "file" size = "70">
	<input type = "button" value = "���" onClick = "location.href = 'Board.jsp'">
	<input type ="submit"  value = "Ȯ��">
	<%	
		} catch(Exception e) {
			System.out.print("����");
		} finally {
			db.close(con);
		}
	%>
	</form>
</body>
</html>