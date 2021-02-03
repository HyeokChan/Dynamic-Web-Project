<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*"%>
<%
	BoardDAO boardDAO = new BoardDAO();
	for(int i=1; i<=10; i++){
		BoardDTO dto = new BoardDTO();
		dto.setTitle("제목" + i);
		dto.setWriter("홍길동" + i);
		dto.setPwd("1234");
		dto.setContent("내용" + i);
		boardDAO.boardInsert(dto);
	}
%>
<script>
	alert("10개의 글 저장 완료!")
</script>