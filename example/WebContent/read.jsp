<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardExample.*" %>
<%
	String strPg = request.getParameter("pg"); // 페이지 번호받기
	int pg = Integer.parseInt(strPg);
	String strNum = request.getParameter("num"); // 글번호 받기
	int num = Integer.parseInt(strNum);
	BoardDAO boardDAO = new BoardDAO();
	boardDAO.boardUpdateHit(num);
	BoardDTO dto = boardDAO.boardRead(num);
	// num, title, writer, pwd, content, regdate, hit
	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
<script type="text/javascript"> // 이번트 처리
	function go_update(){
		//alert("alert1")
		// 주소표시줄 : location, 자바스크립트를 이용하여 주소를 바꾸는 방법
		location.href="updateform.jsp?num=<%=dto.getNum()%>&pg=<%=pg%>";
	}
	function go_delete(){
		// 자바스크립트에서 아이디로 요소를 찾는다.
		var span1 = document.getElementById("span1");
		span1.style.visibility = "hidden" // visibility : 화면에서는 사라지고 공간은 남아있음
		var form1 = document.getElementById("form1");
		form1.style.display = "inline" // display : 화면, 공간은 다 사라짐
	}
	function cancel(){
		var span1 = document.getElementById("span1");
		span1.style.visibility = "" 
		var form1 = document.getElementById("form1");
		form1.style.display = "none" 
	}
	function del(){
		
		if(form1.pwd.value == ""){
			alert("비밀번호를 꼭 입력해주세요.");
			form1.pwd.focus();
			return;
		}
		form1.submit();
	}
</script>
</head>
<body>
	<h1> 글 상세 보기</h1>
	<a href="list.jsp">리스트</a><br><br>
	<table width="500" border="1">
		<tr>
			<th width="100">글 번호</th>
			<td><%=dto.getNum()%></td>
		</tr>
		<tr>
			<th width="100">글쓴이</th>
			<td><%=dto.getWriter()%></td>
		</tr>
		<tr>
			<th width="100">날짜</th>
			<td><%=dto.getRegdate()%></td>
		</tr>
		<tr>
			<th width="100">조회수</th>
			<td><%=dto.getHit()%></td>
		</tr>
		<tr>
			<th width="100">제목</th>
			<td><%=dto.getTitle()%></td>
		</tr>
		<tr>
			<th width="100">내용</th>
			<td><%=dto.getContent()%></td>
		</tr>
		<tr>
			<td colspan="2">
				<span id="span1">
					<input type="button" value="수정" onclick="go_update()"> <!-- 이런상태는 강한결합임 -->
					<input type="button" value="삭제" onclick="go_delete()">
				</span>
				<form action="delete.jsp" method="post" id="form1" name="form1" style="display:inline; display:none">
					<input type="hidden" name="pg" value="<%=pg%>">
					<input type="hidden" name="num" value="<%=dto.getNum()%>">
					비밀번호 : <input type="password" name="pwd" size="12" maxlength="50">
					<!-- onclick del() 함수에서 submit 하면 여기서 정의한 delete.jsp로 간다 -->
					<!-- 삭제하기 위해선 글번호와 비밀번호가 필요하기 때문에 hidden으로 글 번호를 입력받는다. -->
					<input type="button" value="Del" onclick="del()"> 
					<input type="button" value="Cancel" onclick="cancel()">
				</form>
			</td>
		</tr>
	</table>
</body>
</html>