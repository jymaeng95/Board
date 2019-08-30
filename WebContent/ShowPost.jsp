<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*,board.*"%>
 
  		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script language = "javascript">	
$(function(){
	$('.goPW').click(function() {
		submitToPw($(this).attr("url"),$(this).attr("num"),$(this).attr("flag"));
	});
	
});

$(function() {
	$('#Rec').click(function (){
		callAjax();
	});
});
function callAjax() {
	var postNum = $('#pNum').val();
	$.ajax({
		type : "post",
		async : false,
		url : "Recommend.jsp",
		data : {
			"pNum" : postNum 
		},
		dataType : "json",
		success : function(data) {
			JSON.stringify(data);
			alert("추천하였습니다.");
			$('#Rec').attr("disabled",true);
			$('#HeaderRecom').text(data.recommed);
		},
		error : function(){
			alert("error");
		}
	});
}


function submitToPw(url, pNum, flag) {
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
  	int num=0,hit=0, recom = 0;
  	boolean checkHit = false;
   	boolean recommend;
   	
   // 추천수,조회수 업데이트 코드 작성 (밑에 삭제 후)
  	try {
		db = new DB();
		con = db.loadConnect();
		list = new ArrayList<UserBean>();

		num = Integer.parseInt(request.getParameter("pNum"));
		request.setCharacterEncoding("EUC-KR");	
		db.updateHit(con, num);
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
				<td id = "HeaderTitle" width = "600"><%= title%></td>
				<td id = "HeaderName" width = "150"><%= name%></td>
				<td id = "HeaderDate" width = "150"><%= pdate%></td>
				<td id = "HeaderHit"width = "70"><%= hit%></td>
				<td id = "HeaderRecom"width = "70"><%= recom%></td>
			</tr>
		</table>
		<hr>
		<table>
			<tr>
			<td width = "1000"><%= contents%></td>
		</table><br><br><br>
		<input type="hidden" id="flag" name="flag" value="1" />
		<input type="hidden" id="pNum" name="pNum" value="<%=num %>" />
		<br>
		<hr>
		<input type ="button" value = "추천" id ="Rec" >
		<%-- <input type = "button" value = "수정" class="goPW" name ="modify" onclick ="submitToPw('Confirm_PW.jsp','<%=num %>','1');"/> --%>
		<%-- <input type = "button" value = "삭제" class="goPW" name ="delete" onclick ="submitToPw('Confirm_PW.jsp','<%=num %>','2');"/>	--%>
		<input type = "button" value = "수정" class = "goPW" url ="Confirm_PW.jsp" num = "<%=num %>" flag = "1"/>
		<input type = "button" value = "삭제" class = "goPW" url ="Confirm_PW.jsp" num = "<%=num %>" flag = "2"/>
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