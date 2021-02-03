<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
</head>
<body>
<h1>글쓰기</h1>
<form action="write.jsp" method="post">
<table width="400" border="1">
<tr>
	<td>제목</td>
	<td><input type="text" name="title"></td>
</tr>
<tr>
	<td>글쓴이</td>
	<td><input type="text" name="writer"></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td><input type="password" name="pwd"></td>
</tr>
<tr>
	<td>내용</td>
	<td><textarea name="content" rows="5" cols="30"></textarea></td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="쓰기">
		<input type="reset" value="취소">
	</td>
</tr>
</table>
</form>
</body>
</html>
