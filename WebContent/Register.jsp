<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>ע��</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function check(){
// 			alert("��ȷ���������˺�����");
			var name=document.getElementById("name").value;
			var pwd=document.getElementById("pwd").value;
// 			alert(pwd);
			if(name==""||pwd==""){
				alert("��ȷ���������˺�����");
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
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		<div id="AddBook">
			<form action="" method="post" onSubmit="return check();">
				�˺ţ�&nbsp;<input type="text" name="userName"><br><br>
				���룺&nbsp;<input type="password" name="password"><br><br>
<!-- 				�Ƿ����Ա��<input type="radio" value="AD" name="iden">&nbsp;&nbsp; -->
				<input type="submit" value="ע��">&nbsp;&nbsp;
				<input type="reset" value="���">
			</form>
			<%
// 				String iden = request.getParameter("iden");
				String UserName=request.getParameter("userName");
				String UserPwd=request.getParameter("password");
				
				if((!"".equals(UserName))&&UserName!=null&&
						(!"".equals(UserPwd))&&UserPwd!=null){
					String sqlRegister="insert into UserInfo (UserName,UserPwd) values('"+UserName+"','"+UserPwd+"')";
					boolean flag=helperClass.SQL_ZSG(sqlRegister);
					if(flag){
						//��¼session
// 						������ҳ���ұ�������ʾ�ѵ�¼��ʽ
						session.setAttribute("UserName", UserName);
						session.setAttribute("UserPwd", UserPwd);
					}
					else{
						out.println("ע��ʧ�ܣ��˺��Ѵ��ڣ�");
					}
				}
			%>
		</div>
	</div>
</body>
</html>