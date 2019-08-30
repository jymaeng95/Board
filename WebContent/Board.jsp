<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList" %>
<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="java.sql.*,board.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
	 
	int firstPaging = Integer.parseInt(CommonUtil.defaultString(request.getParameter("firstPaging"), "1"));	//ù��° �������ѹ�
	int paging = Integer.parseInt(CommonUtil.defaultString(request.getParameter("paging"), "1"));			//���� ������ ��ȣ
	int lineCount = Integer.parseInt(CommonUtil.defaultString(request.getParameter("lineCount"), "3"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script language = "javascript">
$(function() {
	$('.title').css("cursor","pointer");
	$('.title').click(function() {
		onSubmit($(this).attr("url"), $(this).attr("num"), $(this).attr("flag"));
	});
	
	$('.SecretTitle').css("cursor","pointer");
	$('.SecretClass').one('click',function(event) {
		$(event.currentTarget).find('.hidePw').toggle();
	});

	
	$('#clickPw').on('click',function(){
		var postNum = $('.SecretTitle').attr("num");
		var postPw = $('#pPw').val();
		$.ajax({
			type : "post",
			async : false,
			url : "Check_PW.jsp",
			data : {
				"pNum" : postNum,
				"pPw" : postPw
			},
			dataType : "json",
			success : function(data) {
			 	JSON.stringify(data); 
				if(data.check == "1"){
					onSubmit("ShowPost.jsp",postNum,"");
				} else {
					alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				}
			},
			error : function() {
				alert("error");
			}
		});
	});
	
	$('#count').on('change', function() {
		var count = $('#count option:selected').val();
		$('#count').val(count).prop('selected',true);
		$('#lineCount').val(count);
		$('#formPost').attr("action", "Board.jsp");
		$('#formPost').submit();
	});
	
	$('.paging').css("cursor","pointer");
	$('.paging').click(function() {
		onReload($(this).attr("paging"), $(this).attr("firstPaging"));
	});
});

function onSubmit(url, pNum, flag) {
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
		ArrayList<UserBean> list = null;
		int nextNum = 0;
		int num = 0;
		int count=0;
		boolean recommend = false;
		int postCount=0;	//�� �Խñ� ��
		int first=0;		//
		int last=0;			//
		int pageDevide = 0;	//�Խñ� ���� ��
		try{
			list = new ArrayList<UserBean>();
			db = new DB();
			con = db.loadConnect();
			list = db.getCategory(con);
	%>
	<h3> Board</h3><hr>
		<form id="formPost" action="Post.jsp" method="post">
		<select id = "category"> 
			<option value =""> �Խ��� �̸� </option>
			<%for (int i = 0; i < list.size(); i++) {%>
				<option value="<%=list.get(i).getCategory() %>"><%=list.get(i).getCategory() %></option>
			<%} %>
		</select>
		<select id = "count">
			<option value ="3">3</option>
			<option value ="5" >5</option>
			<option value ="7">7</option>
			<option value ="10">10</option>
		</select><br><hr>
		
		
		<table class = "head">
			<tr align = "center">
				<td width = "70">�� ��ȣ</td>
				<td width = "600">���� </td>
				<td width = "100">�ۼ���</td>
				<td width = "70">��ȸ��</td>
				<td width = "70">��õ��</td>
				<td width = "150">��¥</td>
			</tr>
		</table><hr>
		
		<% nextNum = db.getNextPnum(con); %>
			<input type="hidden" id="pNum" name="pNum" value="<%=nextNum %>" />
			<input type="hidden" id="flag" name="flag" value="4" />
			<input type="hidden" id="lineCount" name="lineCount" value="<%=lineCount %>" />
			<input type="hidden" value = "<%=recommend %>" name = "recommend">
		<div>
		
		<!-- //�������� START -->
			<table class = "notice">
		<%
			pageDevide = lineCount;
			list = db.loadNotice(con);
			
			for (int i = 0; i < list.size(); i++) {
				num = list.get(i).getPnum();
		%>
			<tr align = "center">
				<td width = "70"><%= num%></td>
				<td width = "600"><div class="title" url="ShowPost.jsp" num="<%=num%>" flag=""><%=list.get(i).getTitle() %></div></td>
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
		<!-- //�������� END -->
		
		<!-- //�Ϲ� �Խñ� START -->
		<div>
			<table class = "post">
		<%
			postCount = db.countPost(con);
		%>
			<input type="hidden" id="paging" value = "<%=paging %>" name = "paging"/>
			<input type="hidden" id="firstPaging" value ="<%=firstPaging %>" name = "firstPaging"/>
			<script>alert("<%=paging%> / <%=firstPaging%> / <%=lineCount%>")</script>
		<% 
			if (postCount >= pageDevide) {
				last = paging * pageDevide;
				first = last - pageDevide + 1;
			} else {
				last = pageDevide;
				first = 1;
			}
		
			list = db.getPostHeader(con,first,last);
		
			for(int i=0;i<list.size();i++){
				String show = list.get(i).getShow();
				num = list.get(i).getPnum();
		%>
				<tr align = "center">
					<td width = "70"><%=num%></td>
					<% if(show.equals("N")||show.equals("null")){ %>
					<td class = "SecretClass" width = "600"><span class="SecretTitle" num="<%=num%>">�������� ���� �� �Դϴ�.<br></span>
						<div class = "hidePw" test = "123" style ="display:none">
							<p>��й�ȣ :
							<input type = "password" id = "pPw" name = "pPw" > 
							<input type = "button" id = "clickPw" value = "Ȯ��">
						</div>
					</td>
					<%} else {%>
					<td width = "600"><div class="title" url="ShowPost.jsp" num="<%=num%>" flag=""><%=list.get(i).getTitle()%></div></td>
					<%} %>
					<td width = "100"><%=list.get(i).getName()%></td>
					<td width = "70"><%=list.get(i).getHit()%></td>
					<td width = "70"><%=list.get(i).getRecommend()%></td>
					<td width = "150"><%=list.get(i).getPdate()%></td>
				</tr>
			<% 	
			}
			%>	
			</table>
		</div><hr>
		<!-- //�Ϲ� �Խñ� END -->
		
		<!-- //����¡START -->
		<table>
		
		<!-- // <<, < ��� START -->
		<%if (paging == 1) {%>
			<td width ="20"> << </td>
			<td width = "30"> < </td>
		<% } else {%>
			<td width ="20"><span class = "paging" paging = "1" firstPaging = "1"> << </span></td>
			<td width ="20"><span class = "paging" paging = "<%=paging - 1%>" firstPaging = ""> < </span></td>
		<%} %>
		<!-- // <<, < ��� END -->
		
		<!-- // ������ ��� START -->
		<%
			int pageCount = PagingUtil.paging(postCount, pageDevide);
			for (int i = firstPaging; i <= pageCount; i++){
		%>
				<td width ="20"><span class = "paging" paging = "<%=i%>" firstPaging = "<%=firstPaging %>"><%=i %></span></td>
		<% 	if(i % 10 == 0) break;	
			}
		%>
		<!-- // ������ ��� END -->
		
		<!-- // >>, > ��� START -->
		<%if (paging == pageCount) {%>
			<td width ="30"> > </td>
		<%} else { %>
			<td width ="20"><span class = "paging" paging = "<%=paging + 1%>" firstPaging = "<%=(paging % 10 == 0) ? paging + 1 : firstPaging%>"> > </span></td>
		<%}%>
			<td width ="20"><span class = "paging" paging = "<%=pageCount%>" firstPaging = "<%=PagingUtil.lastPage(pageCount)%>"> >> </span></td>
		<!-- // >>, > ��� END -->
		<!-- //����¡END -->
		
		<td width ="100"><input type = "submit" value = "�۾���"></td>
		</table>
		</form>
		
	<% 
		}catch (Exception e){
			System.out.print("����");
			
		}finally {
			db.close(con);
		}
	%>
</body>
</html>