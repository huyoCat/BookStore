<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>注销</title>
</head>
<body>
	<%
		session.removeAttribute("UserName");
		session.removeAttribute("iden");
		response.sendRedirect("Index.jsp");
	%>
</body>
</html>