<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*" %>
<%
	String strNum = request.getParameter("num");
	int num = Integer.parseInt(strNum);
	BoardDAO boardDAO = new BoardDAO();
	BoardDTO dto = boardDAO.boardRead(num);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<script>
	function update_check(){
		//alert("alert1");	
		if(form1.title.value==""){
			alert("제목을 꼭 입력해주세요.");
			form1.title.focus();
			return;
		}
		if(form1.writer.value==""){
			alert("글쓴이을 꼭 입력해주세요.");
			form1.writer.focus();
			return;
		}
		if(form1.content.value==""){
			alert("내용을 꼭 입력해주세요.");
			form1.content.focus();
			return;
		}
		if(form1.pwd.value==""){
			alert("비밀번호를 꼭 입력해주세요.");
			form1.pwd.focus();
			return;
		}
		form1.submit();
	}
</script>
</head>
<body>
<h1>글 수정</h1>
<form action="update.jsp" method="post" name="form1">
	<table>
		<tr>
			<th>글 번호</th>
			<td><%=dto.getNum()%></td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="hidden" name="num" value="<%=dto.getNum()%>">
				<input type="text" name="title" value="<%=dto.getTitle()%>">
			</td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td><input type="text" name="writer" value="<%=dto.getWriter()%>"></td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><%=dto.getRegdate()%></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=dto.getHit()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" rows="5" cols="30"><%=dto.getContent() %></textarea></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="button" value="수정" onclick="update_check()">
				<input type="reset" value="취소" onclick="history.back()">
			</th>
			
		</tr>
	</table>
</form>
</body>
</html>




