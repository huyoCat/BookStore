<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��ζ����</title>
		<style type="text/css">
			html,body{
				height: 150px;
				width: 100%;
			}
		</style>
	<link type="text/css" rel="stylesheet" href="style.css"/> 
	<script type="text/javascript">
		function Logout(){
			var flag=confirm("ȷ���˳���¼��");
			if(flag){
				window.location.href='Logout.jsp';
			}
		}
	</script>
</head>
<body>
	<div id="header">
	
<!-- 		ͷ��ͼƬ -->
		<img id="title" src="picture/��ζ����.png" height=80%>
		
<!-- 	������ -->
		<div id="titleBt">
			<form action="">
				<input type="text" id="searchBox">
				<input type="button" id="searchButton" value="search">
			</form>
		</div>
<!-- 		�ѵ�¼ -->
		<%
// 			��ȡsession
			if(null!=session.getAttribute("UserName")
				&&!("".equals(session.getAttribute("UserName").toString()))){
				%>
					<a id="loginLogo2" href="U_Area.jsp">
					<%=session.getAttribute("UserName").toString() %>�ĸ�������</a>
					<a id="loginLogo2" href="#" onClick="Logout()">�˳���¼</a>
				<%
			}
			else{
				%>
				<!-- 		ע��/��¼ͼ�� -->
				<div>
					
					<a id="loginLogo" href="Register.jsp">ע��</a>
					<a id="loginLogo" href="Login.jsp">��¼</a>
		<!-- 			<img id="loginLogo" alt="���ע��" src="picture/ע��logo.png"> -->
		<!-- 			<img id="loginLogo2" alt="���ע��" src="picture/��¼logo.png"> -->
				</div>
				<%
			}
		%>

	</div>
</body>
</html>