<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>登录</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>

	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
		<div id="AddBook">
			<form action="Index.jsp" method="post">
				<!-- 登录页面 -->
<!-- 		<img src="picture/Login.png" height="30"> -->
				账号：<input type="text" name="userName"><br><br>
				密码：<input type="password" name="password"><br><br>
<!-- 				<input type="radio" name="iden" value="用户"> -->
				<input type="submit" value="登录">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="清空">
			</form>
		</div>
		
	</div>
	
</body>
</html>