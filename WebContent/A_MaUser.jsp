<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>管理用户</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function ban(UserID){
			var UserID=UserID;
			var flag=confirm("确认将用户加入黑名单？");
			if(flag){
				window.location.href="A_MaUser.jsp?UserID="+UserID+"&msg=ban";
			}
		}
		
		function pick(UserID){
			var UserID=UserID;
			var flag=confirm("确认解除用户黑名单？");
			if(flag){
				window.location.href="A_MaUser.jsp?UserID="+UserID+"&msg=pick";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
<!-- 			检测是否登录并且是不是管理员 -->
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
				if("iden".equals(session.getAttribute("iden").toString())){
					String UserName=session.getAttribute("UserName").toString();
					
					String SeleSql="select * from UserInfo where UserGrant=0";
					
					//如果带着拉黑用户的消息或解除
					if(null!=request.getParameter("msg")){
						int UserID=0;
						if(null!=request.getParameter("UserID")){
							UserID=Integer.parseInt(""+request.getParameter("UserID"));
						}
						if("ban".equals(request.getParameter("msg").toString())){
							String sql="update UserInfo set UserGrant=1 where UserID="+UserID+"";
							boolean flag=helperClass.SQL_ZSG(sql);
							if(flag){
								out.print("拉黑成功！");
							}
							else{
								out.print("拉黑失败！");
							}
						}
						else if("pick".equals(request.getParameter("msg").toString())){
							String sql="update UserInfo set UserGrant=0 where UserID="+UserID+"";
							boolean flag=helperClass.SQL_ZSG(sql);
							if(flag){
								out.print("解除黑名单成功！");
							}
							else{
								out.print("解除黑名单失败！");
							}
						}
					}
					
// 					如果带着搜索信息
					if(!("null".equals(""+request.getParameter("limit")))){
						if("UserGrant".equals(""+request.getParameter("limit"))){
							SeleSql="select * from UserInfo where UserGrant=1";
						}
						else if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
							out.print("请输入搜索关键词");
						}
						else{
							String limit=request.getParameter("limit").toString();
							String search=request.getParameter("search").toString();
							SeleSql+=" and "+limit+" like '%'+'"+search+"'+'%'";
						}
					}
					
					%>
					<form action="" method="post">
					
						<div>
							<select name="limit">
								<option value="null">选择搜索条件</option>
								<option value="UserName">根据用户名搜索</option>
								<option value="UserGrant">查看已拉黑用户</option>
							</select>
										
							<input type="text" name="search">&nbsp;&nbsp;
							<input type="submit" value="搜索">
						</div>
						
						<div>
							<table border="3px" align="center" cellspacing="10px">
								<tr>
									<th>用户ID</th>
									<th>用户信息</th>
									<th></th>
								</tr>
								
								<%
								List<Map<String, Object>> StarList=helperClass.SelectSQL(SeleSql);
								if(StarList.size()!=0){
									List<User> UserList=helperClass.reUser(StarList);
									if(UserList.size()!=0){
										for(User user:UserList){
											%>
											<tr>
												<td><%=user.getUserID() %></td>
												
												<td>
													用户名：<%=user.getUserName() %><br>
													用户密码：<%=user.getUserPwd() %><br>
													用户收货地址：<%=user.getUserAddress() %><br>
													用户联系方式：<%=user.getUserPhone() %>
												</td>
												
												<%
													if(user.getUserGrant()==0){
														%>
														<td>
															<a href="#" onClick="ban(<%=user.getUserID() %>)">加入黑名单</a>
														</td>
														<%
													}
													else{
														%>
														<td>
															<a href="#" onClick="pick(<%=user.getUserID() %>)">解除黑名单</a>
														</td>
														<%
													}
												%>
											</tr>
											<%
										}
									}
									
								}
								
								%>
								
							</table>
						</div>
					</form>
					<%
					
				}
			}
			%>
		
		</div>
	</div>

</body>
</html>