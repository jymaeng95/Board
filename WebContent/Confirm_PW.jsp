<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, board.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script language = "javascript">
$(function() {
	$('#submitButton').on('click',function() {
		var postNum = $('#pNum').val();
		var postPw = $('#pPw').val();
		var postFlag = $('#flag').val();
		$.ajax({
			type : "post",
			async : false,
			url : "Check_PW.jsp",
			data : {
				"pNum" : postNum,
				"pPw" : postPw,
				"flag" : postFlag
			},
			dataType : "json",
			success : function(data) {
			 	JSON.stringify(data); 
				if(data.check == "1"){
					$('#check').attr('value',"true");
					if(postFlag == "1"){
						onSubmit("Post.jsp",postNum,postFlag);
					}else {
						onSubmit("Board.jsp","","");
					}
				} else {
					alert("비밀번호가 틀렸습니다.");
				}
			},
			error : function() {
				alert("error");
			}
		});
	});
	
	$('#backButton').on('click',function() {
		history.go(-1);
	});
});

function onSubmit(url, pNum, flag) {
	document.getElementById("pNum").value = pNum;
	document.getElementById("flag").value = flag;
	document.getElementById("CheckPw").setAttribute("action",url);
	document.getElementById("CheckPw").submit();
}
</script>
</head>
<style>
body {
	text-align : center;
	background-color : #97d5e0
}
</style>
<body>
	<form id ="CheckPw" action ="Check_PW.jsp" method="post">
		<%
		int num=0, flag = 0;
		flag = Integer.parseInt(request.getParameter("flag"));
		num = Integer.parseInt(request.getParameter("pNum"));
		%>
			<input type="hidden" id = "pNum" value="<%=num %>" name="pNum">
			<input type="hidden" id = "flag" value="<%=flag %>" name="flag"> 
			비밀 번호 : <input type="password" id = "pPw" name="pPw"> <br><br>
			<input type="button" id = "submitButton" value="확인">
			<input type="button" id = "backButton" value ="뒤로가기">
 	</form>
</body>
</html>