<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>三味书屋</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
<!-- 	hello world!<br> -->
	
		<!-- 	网页头图  右上角 登录or 注册 -->
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
			<table>
				<tr>
					<th>名称</th>
					<th>详情</th>
					<th>价格</th>
				</tr>
			
				<tr>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
	
</body>
</html>