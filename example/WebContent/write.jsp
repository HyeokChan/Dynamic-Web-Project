<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//num,title,writer,pwd,content,regdate,hit
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String pwd = request.getParameter("pwd");
	String content = request.getParameter("content");
	// DTO 작업
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setWriter(writer);
	dto.setPwd(pwd);
	dto.setContent(content);
	// DAO 작업
	BoardDAO boardDAO = new BoardDAO();
	boardDAO.boardInsert(dto);
	// list.jsp 로 가기
	response.sendRedirect("list.jsp");
%>