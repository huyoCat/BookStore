<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改个人信息</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
			<%
			if(null==session.getAttribute("UserName")
			||("".equals(session.getAttribute("UserName").toString()))){
				out.println("请先登录网站！");
				%>
				<br><a href="Login.jsp">登录</a><br>
				<a href="Register.jsp">注册</a>
				<%
			}
			else{//已登录
				String UserName=session.getAttribute("UserName").toString();

				String seleSql="select * from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(seleSql);
				if(StarList.size()==0){
					out.print("数据错误");
					%>
					<a href="U_UpdateMsg.jsp">点击刷新</a>
					<%
				}
				else{
					List<User> UserList=helperClass.reUser(StarList);
					if(UserList.size()!=0){
						User user=UserList.get(0);
						%>
						<div>
							<table border="3px" align="center" cellspacing="10px">
								<tr>
									<th>我的信息</th>
									<th></th>
								</tr>
								<tr>
									<td>用户名：<%=user.getUserName() %></td>
									<td>用户名禁止修改</td>
								</tr>
								<tr>
									<td>用户密码：不可见</td>
									<td><a href="U_UpdateMsg2.jsp?msg=Pwd">修改</a></td>
								</tr>
								<tr>
									<td>收货地址：<%=user.getUserAddress() %></td>
									<td><a href="U_UpdateMsg2.jsp?msg=Address">修改</a></td>
								</tr>
								<tr>
									<td>联系电话：<%=user.getUserPhone() %></td>
									<td><a href="U_UpdateMsg2.jsp?msg=Phone">修改</a></td>
								</tr>
							</table>
						</div>
						<%
					}
				}
			}
			%>
		</div>
	</div>

</body>
</html>