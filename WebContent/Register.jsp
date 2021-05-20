<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>注册</title>
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
			<form action="" method="post" onSubmit="return check();">
				账号：&nbsp;<input type="text" name="userName"><br><br>
				密码：&nbsp;<input type="password" name="password"><br><br>
<!-- 				是否管理员：<input type="radio" value="AD" name="iden">&nbsp;&nbsp; -->
				<input type="submit" value="注册">&nbsp;&nbsp;
				<input type="reset" value="清空">
			</form>
			<%
// 				String iden = request.getParameter("iden");
				String UserName=request.getParameter("userName");
				String UserPwd=request.getParameter("password");
				
				if((!"".equals(UserName))&&UserName!=null&&
						(!"".equals(UserPwd))&&UserPwd!=null){
// 					判断是否含中文
					UserName=helperClass.zhuanma(UserName);

					boolean flagCON=helperClass.isContainChinese(UserName);
					if(flagCON){
						out.print("请输入非中文字符");
					}
					else{
// 						判断是否重名
						String chekcSql="select UserName from UserInfo";
						List<Map<String, Object>> StarList=helperClass.SelectSQL(chekcSql);
						for(Map<String, Object> map:StarList){
							if(UserName.equals(map.get("UserName"))){
								out.println("注册失败！用户名已存在！");
								return;
							}
						}
						String sqlRegister="insert into UserInfo (UserName,UserPwd) values('"+UserName+"','"+UserPwd+"')";
						boolean flag=helperClass.SQL_ZSG(sqlRegister);
						if(flag){
							//记录session
//	 						返回首页，右边上面显示已登录样式
// 							查询ID
							String sql="select * from UserInfo where UserName='"+UserName+"'";
							List<Map<String, Object>> List=helperClass.SelectSQL(sql);
							String UserID="";
							if(List.size()!=0){
								UserID=""+List.get(0).get("UserID");
							}
							session.setAttribute("UserID", UserID);
							session.setAttribute("UserName", UserName);
							session.setAttribute("UserPwd", UserPwd);
							%>
							<a href="Login.jsp">注册成功！去登录</a>
							<%
						}
						else{
							out.println("注册失败，请重新注册");
						}
					}
					
				}
			%>
		</div>
	</div>
</body>
</html>