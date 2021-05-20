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
				<table>
				<tr><td><a href="Index.jsp">网站首页</a></td></tr>
				<tr><td><a href="AddBook.jsp">添加书籍</a></td></tr>
				<tr><td><a href="A_DeleBook.jsp">删除/修改书籍信息</a></td></tr>
				<tr><td><a href="A_MaType.jsp">管理书籍类别</a></td></tr>
				<tr><td><a>管理用户</a></td></tr>
				<tr><td><a href="A_MaOrder.jsp">管理订单</a></td></tr>
				</table>
				<%
			}
			else{
				%>
				<table>
				<tr><td><a href="Index.jsp">网站首页</a></td></tr>
				<tr><td><a href="U_Star.jsp">收藏夹</a></td></tr>
				<tr><td><a href="U_Car.jsp">购物车</a></td></tr>
				<tr><td><a href="U_hisOrder.jsp">历史订单</a></td></tr>
				<tr><td><a>修改密码</a></td></tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table border="3px" align="center" cellspacing="10px">
				<tr><th>书籍类别</th></tr>
			<%
				String sqlBaType="select TypeName from BookType";
				List<Map<String, Object>> rsBType=helperClass.SelectSQL(sqlBaType);
				if(rsBType.size()==0){
					out.println("数据错误！显示图书类别失败！");
				}
				else{
					for(Map<String, Object> item:rsBType){
						%>
						<tr><td><%=""+item.get("TypeName") %></td></tr>
						<%
					}
					
				}
			%>
			</table>
			<%
		}
		%>

	</div>
</body>
</html>