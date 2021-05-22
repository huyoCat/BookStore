<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>Insert title here</title>
	
	<link type="text/css" rel="stylesheet" href="left.css"/>
</head>
<body>
	<div id="Left">
<!-- 		通过循环加载图书分类 -->
		<%
// 		已经登录的状态
		if(null!=session.getAttribute("UserName")){
			if(null!=session.getAttribute("iden")&&("iden".equals(""+session.getAttribute("iden")))){//是管理员
				%>
				<table id="LtABLE" cellspacing="15">
				<tr><td id="left_User">><a href="Index.jsp">网站首页</a></td></tr>
				<tr><td id="left_User">><a href="AddBook.jsp">添加书籍</a></td></tr>
				<tr><td id="left_User">><a href="A_DeleBook.jsp">删除/修改书籍信息</a></td></tr>
				<tr><td id="left_User">><a href="A_MaType.jsp">管理书籍类别</a></td></tr>
				<tr><td id="left_User">><a href="A_MaUser.jsp">管理用户</a></td></tr>
				<tr><td id="left_User">><a href="A_MaOrder.jsp">管理订单</a></td></tr>
				</table>
				<%
			}
			else{
				%>
				<table id="LtABLE" cellspacing="15">
				<tr><td id="left_User"><a href="Index.jsp">网站首页</a></td></tr>
				<tr><td id="left_User"><a href="U_Star.jsp">收藏夹</a></td></tr>
				<tr><td id="left_User"><a href="U_Car.jsp">购物车</a></td></tr>
				<tr><td id="left_User"><a href="U_hisOrder.jsp">历史订单</a></td></tr>
				<tr><td id="left_User"><a href="U_UpdateMsg.jsp">修改个人信息</a></td></tr>
				</table>
				<%
			}
		}
		else{
			%>
			<img src="picture/welcome.png" id="leftPic">
			<%
		}
		%>

	</div>
</body>
</html>