<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*" %>
<%
	// 1. 넘어온 값들을 받는다.
	String strPg = request.getParameter("pg"); // value=>"xxx"
	int pg = Integer.parseInt(strPg);
	String strNum = request.getParameter("num");
	int num = Integer.parseInt(strNum);
	String pwd = request.getParameter("pwd");
	// 2. dto에 값을 넣는다.
	BoardDTO dto = new BoardDTO();
	dto.setNum(num);
	dto.setPwd(pwd);
	// 3. BoardDAO에게 삭제 작업을 시킨다.
	BoardDAO boardDAO = new BoardDAO();
	int success = boardDAO.boardDelete(dto);
	if(success == 1){
		response.sendRedirect("list.jsp?pg="+pg);
	}
	else{
%>
<script>
	alert("비밀번호가 틀려서 되돌아 갑니다.")
	history.back();
</script>
<%
	}
%>		

	
	
