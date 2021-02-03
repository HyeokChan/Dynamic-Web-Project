<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="boardExample.BoardDTO"/> <!-- 파라미터를 저장할 dto 생성 -->
<jsp:setProperty property="*" name="dto"/> <!-- 넘어오는 파라미터 한번에 설정 -->
<%
	String strPg = request.getParameter("pg");
	int pg = Integer.parseInt(strPg);
	
	BoardDAO boardDAO = new BoardDAO();
	int success = boardDAO.boardUpdate(dto);
	if(success==1){
		response.sendRedirect("list.jsp?pg="+pg); // 이동한다.
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