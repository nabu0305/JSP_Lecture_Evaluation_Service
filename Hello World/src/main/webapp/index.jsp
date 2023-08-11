<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>First Page</title>
</head>
<body>
	Hello World!
	<form action = "./userJoinAction.jsp" method= "post">
		<input type="text" name="userID">
		<input type="password" name="userPassword">
		<input type="submit" value="회원가입"> 
	</form>
</body>
</html>