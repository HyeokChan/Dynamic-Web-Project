<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="boardExample.*" %>
<%@ page import="java.util.*" %>
<%
	int pg=1; // list.jsp가 바로 호출되면 1페이지 나오게 초기값 세팅
	String strPg = request.getParameter("pg");
	if(strPg != null){
		pg = Integer.parseInt(strPg);
	}
	int size = 10; // 한페이지에 보여줄 글의 개수
	int begin = (pg-1)*size+1; // 시작 글 번호
	int end = begin+size-1; // 끝 글 번호
	BoardDAO boardDAO = new BoardDAO();
	ArrayList<BoardDTO> list = boardDAO.boardList(begin, end);
	//ArrayList<BoardDTO> list = boardDAO.boardList();
	int cnt = boardDAO.boardCount(); // 전체 글의 수
	int totalPage = (cnt/size)+ (cnt%size==0?0:1);
	int pageSize = 10; // 페이지 링크가 10개 [11][12]...[20]
	int currentBlock = (pg/pageSize)+ (pg%pageSize==0?0:1); //1~10, 11~20
	int startPage = (currentBlock-1)*pageSize+1; // 시작 페이지 11
	int endPage = startPage + (pageSize-1);// 끝 페이지 20
	if(endPage>totalPage){
		endPage = totalPage;
	}
	int max = cnt-((pg-1)*size);
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
	<table width="660" border="1">
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
			<td><a href="read.jsp?num=<%=dto.getNum()%>&pg=<%=pg%>"> <%=dto.getTitle()%></a></td>
			<td><%=dto.getHit()%></td>
			<td><%=dto.getRegdate()%></td>
		</tr>
		<%
			}
		%>
	</table>
	<div style="width:600px" align="left">
	<%if(pg<=pageSize){%>
		[<span style="color:silver">◀◀</span>]
		[<span style="color:silver">◀</span>]
	<%}else{%>
		[<a href="list.jsp?pg=1">◀◀</a>]
		[<a href="list.jsp?pg=<%=startPage-1%>">◀</a>]
	<% } %>
	<% for(int i=startPage; i<=endPage; i++){%>
		<% if(pg!=i){%>
			[<a href="list.jsp?pg=<%=i%>"><%=i%></a>]
		<%}else{ %>
			[<%=i%>]
		<%}%>
	<%}if(endPage<totalPage){ %>
		[<a href="list.jsp?pg=<%=endPage+1%>">▶</a>]
		[<a href="list.jsp?pg=<%=totalPage%>">▶▶</a>]
	<%}else{%>
		[<span style="color:silver">▶</span>]
		[<span style="color:silver">▶▶</span>]
	<%}%>
	</div>
</body>
</html>