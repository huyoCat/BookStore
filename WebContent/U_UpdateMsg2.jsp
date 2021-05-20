<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改个人信息</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Check(){
// 			alert("!");
			var NowPwd=document.getElementById("NowPwd").value;
			var concernPwd=document.getElementById("concernPwd").value;
			var flag=(NowPwd==concernPwd);
			if(!flag){
				alert("请确定修改后两次输入的密码相同");
			}
// 			alert(NowPwd==concernPwd);
// 			return NowPwd==concernPwd;
// 			alert(NowPwd);
// 			alert(concernPwd);
			return flag;
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
			
				//修改密码
				if(null!=request.getParameter("BePwd")&&!("".equals(request.getParameter("BePwd")))
					&&null!=request.getParameter("NowPwd")&&!("".equals(request.getParameter("NowPwd")))
					&&null!=request.getParameter("concernPwd")&&!("".equals(request.getParameter("concernPwd")))){
					
					String BePwd=""+request.getParameter("BePwd");
					String NowPwd=""+request.getParameter("NowPwd");
					String concernPwd=""+request.getParameter("concernPwd");
					//先比较原密码是否正确
					String compare="select UserPwd from UserInfo where UserName='"+UserName+"'";
					List<Map<String, Object>> StarList=helperClass.SelectSQL(compare);
					if(StarList.size()!=0){
						if(BePwd.equals(StarList.get(0).get("UserPwd"))){
							String update="update UserInfo set UserPwd='"+NowPwd+"' UserName='"+UserName+"'";
							boolean flag=helperClass.SQL_ZSG(update);
							if(flag){
								%>
								<a href="Index.jsp">修改成功，返回首页</a>
								<%
							}
							else{
								%>
								<a href="U_UpdateMsg.jsp">修改失败，重新修改</a>
								<%
							}
						}
						else{
// 							out.print("原密码输入错误，请重新输入");
							%>
							<a href="U_UpdateMsg.jsp">原密码输入错误，请重新输入</a>
							<%
						}
					}
				}
				
				
				//修改地址
				if(null!=request.getParameter("Address")&&!("".equals(""+request.getParameter("Address")))){
					String UserAddress=""+request.getParameter("Address");
					String update="update UserInfo set UserAddress='"+UserAddress+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(update);
					if(flag){
						%>
						<a href="Index.jsp">修改成功，返回首页</a>
						<%
					}
					else{
						%>
						<a href="U_UpdateMsg.jsp">修改失败，重新修改</a>
						<%
					}
				
				}
				
				//修改联系方式
				if(null!=request.getParameter("Phone")&&!("".equals(""+request.getParameter("Phone")))){
					String UserPhone=""+request.getParameter("Phone");
					String update="update UserInfo set UserPhone='"+UserPhone+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(update);
					if(flag){
						%>
						<a href="Index.jsp">修改成功，返回首页</a>
						<%
					}
					else{
						%>
						<a href="U_UpdateMsg.jsp">修改失败，重新修改</a>
						<%
					}
				
				}
				
				if(null!=request.getParameter("msg")&&!("".equals(""+request.getParameter("msg")))){
					
					//如果是修改密码请求
					if("Pwd".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post" onSubmit="return Check()">
							请输入原密码：<input type="password" name="BePwd" id="BePwd"><br>
							修改后的密码：<input type="password" name="NowPwd" id="NowPwd"><br>
							请确认密码：<input type="password" name="concernPwd" id="concernPwd"><br>
							<input type="submit" value="确定"  name="updatePwd">
						</form>
						<%
					}
					
					
					//如果是修改地址请求
					if("Address".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post">
							请输入收货地址：<textarea name="Address" rows="" cols=""></textarea>
							<input type="submit" value="确定"  name="updateAddress">
						</form>
						<%
					}
					
					
					//如果是修改联系方式请求
					if("Phone".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post">
							请输入联系方式：<input type="text" name="Phone">
							<input type="submit" value="确定" name="updatePhone">
						</form>
						<%
					}
				}
				
			}
			%>
			</div>
		</div>

</body>
</html>