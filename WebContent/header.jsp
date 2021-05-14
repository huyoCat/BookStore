<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>三味书屋</title>
		<style type="text/css">
			html,body{
				height: 150px;
				width: 100%;
			}
		</style>
	<link type="text/css" rel="stylesheet" href="style.css"/> 
	<script type="text/javascript">
		function Logout(){
			var flag=confirm("确认退出登录？");
			if(flag){
				window.location.href='Logout.jsp';
			}
		}
	</script>
</head>
<body>
	<div id="header">
	
<!-- 		头部图片 -->
		<img id="title" src="picture/三味书屋.png" height=80%>
		
<!-- 	搜索框 -->
		<div id="titleBt">
			<form action="">
				<input type="text" id="searchBox">
				<input type="button" id="searchButton" value="search">
			</form>
		</div>
<!-- 		已登录 -->
		<%
// 			获取session
			if(null!=session.getAttribute("UserName")
				&&!("".equals(session.getAttribute("UserName").toString()))){
				%>
					<a id="loginLogo2" href="U_Area.jsp">
					<%=session.getAttribute("UserName").toString() %>的个人中心</a>
					<a id="loginLogo2" href="#" onClick="Logout()">退出登录</a>
				<%
			}
			else{
				%>
				<!-- 		注册/登录图标 -->
				<div>
					
					<a id="loginLogo" href="Register.jsp">注册</a>
					<a id="loginLogo" href="Login.jsp">登录</a>
		<!-- 			<img id="loginLogo" alt="点击注册" src="picture/注册logo.png"> -->
		<!-- 			<img id="loginLogo2" alt="点击注册" src="picture/登录logo.png"> -->
				</div>
				<%
			}
		%>

	</div>
</body>
</html>