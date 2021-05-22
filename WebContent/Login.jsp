<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>登录</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function check(){
// 			alert("请确保已输入账号密码");
			var name=document.getElementById("name").value;
			var pwd=document.getElementById("pwd").value;
// 			alert(pwd);
			if(name==""||pwd==""){
				alert("请确保已输入账号密码");
				return false;
			}
			else{
				return true;
			}
		}
	</script>
</head>
<body>

	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
		<div id="AddBook">
			<form method="post" onSubmit="return check();" id="LoginAnd">
				<!-- 登录页面 -->
<!-- 		<img src="picture/Login.png" height="30"> -->
				账号：&nbsp;<input type="text" name="userName" id="name"><br><br>
				密码：&nbsp;<input type="password" name="password" id="pwd"><br><br>
<!-- 				<input type="radio" name="iden" value="用户"> -->
				是否管理员：<input type="radio"  name="iden">&nbsp;&nbsp;
				<input type="submit" value="登录">&nbsp;&nbsp;
				<input type="reset" value="清空">
			</form>
			<%
				//连接数据库验证信息记载session
				String UserName=request.getParameter("userName");
				String UserPwd=request.getParameter("password");
				
				//如果是管理员
				if(null!=request.getParameter("iden")){
					if(!("".equals(UserName))&&UserName!=null&&
							!("".equals(UserPwd))&&UserPwd!=null){
						String sql1="select * from ADInfo where ADName='"+UserName+"'";
						List<Map<String, Object>> rs1=helperClass.SelectSQL(sql1);
						if(rs1.size()==0){//如果查询不到数据
// 							out.println("该管理员不存在！");
							%>
							<script type="text/javascript">
								alert('该管理员不存在！');
							</script>
							<%
						}
						else{
							for(Map<String, Object> item:rs1){
								if(UserPwd.equals(""+item.get("ADPwd"))){
									//登录成功，重定向到主页，记录session信息
									session.setAttribute("UserName", UserName);
									session.setAttribute("UserName", UserPwd);
									session.setAttribute("iden", "iden");
									response.sendRedirect("Index.jsp");
//	 								out.println("欢迎登录！"+UserName+"！");
								}
								else{
									%>
									<script type="text/javascript">
										alert('密码错误，请重新输入密码！');
									</script>
									<%
// 									out.println("密码错误，请重新输入密码。");
								}
							}
						}
					}
					
				}
				else{
					if(!("".equals(UserName))&&UserName!=null&&
							!("".equals(UserPwd))&&UserPwd!=null){
						String sql1="select * from UserInfo where UserName='"+UserName+"'";
						List<Map<String, Object>> rs1=helperClass.SelectSQL(sql1);
						
						if(rs1.size()==0){//如果查询不到数据
// 							out.println("该用户不存在！");
							%>
							<script type="text/javascript">
								alert('该用户不存在！');
							</script>
							<%
						}
						else{
							for(Map<String, Object> item:rs1){
								if(UserPwd.equals(""+item.get("UserPwd"))){
									//登录成功，重定向到主页，记录session信息
									session.setAttribute("UserName", UserName);
									session.setAttribute("UserPwd", UserPwd);
									response.sendRedirect("Index.jsp");
//	 								out.println("欢迎登录！"+UserName+"！");
								}
								else{
									%>
									<script type="text/javascript">
										alert('密码错误，请重新输入密码！');
									</script>
									<%
// 									out.println("密码错误，请重新输入密码。");
								}
							}
						}
					}
				}
			%>
		</div>
		
	</div>
	
</body>
</html>