<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��¼</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>

	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		<div id="AddBook">
			<form action="Index.jsp" method="post">
				<!-- ��¼ҳ�� -->
<!-- 		<img src="picture/Login.png" height="30"> -->
				�˺ţ�<input type="text" name="userName"><br><br>
				���룺<input type="password" name="password"><br><br>
<!-- 				<input type="radio" name="iden" value="�û�"> -->
				<input type="submit" value="��¼">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="���">
			</form>
		</div>
		
	</div>
	
</body>
</html>