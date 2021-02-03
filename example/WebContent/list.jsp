<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="boardExample.*" %>
<%@ page import="java.util.*" %>
<%
	BoardDAO boardDAO = new BoardDAO();
	ArrayList<BoardDTO> list = boardDAO.boardList();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
</head>
<body>
	<h1>게시판 리스트</h1>
	<a href="writeform.jsp">글쓰기</a><br><br>
	<table width="400" border="1">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>날짜</th>
		</tr>
		<%
			for(int i=0; i<list.size();i++){
				BoardDTO dto = list.get(i);
				
		%>
		<tr>
			<td><%=dto.getNum()%></td>
			<td><a href="read.jsp?num=<%=dto.getNum()%>"> <%=dto.getTitle()%></a></td>
			<td><%=dto.getHit()%></td>
			<td><%=dto.getRegdate()%></td>
		</tr>
		<%
			}
		%>
		
	</table>
</body>
</html>