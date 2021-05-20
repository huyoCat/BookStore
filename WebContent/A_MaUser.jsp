<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�����û�</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function ban(UserID){
			var UserID=UserID;
			var flag=confirm("ȷ�Ͻ��û������������");
			if(flag){
				window.location.href="A_MaUser.jsp?UserID="+UserID+"&msg=ban";
			}
		}
		
		function pick(UserID){
			var UserID=UserID;
			var flag=confirm("ȷ�Ͻ���û���������");
			if(flag){
				window.location.href="A_MaUser.jsp?UserID="+UserID+"&msg=pick";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
<!-- 			����Ƿ��¼�����ǲ��ǹ���Ա -->
			<%
			if(null==session.getAttribute("UserName")
			||("".equals(session.getAttribute("UserName").toString()))){
			out.println("���ȵ�¼��վ��");
			%>
			<br><a href="Login.jsp">��¼</a><br>
			<a href="Register.jsp">ע��</a>
			<%
			}
			else{//�ѵ�¼
				if("iden".equals(session.getAttribute("iden").toString())){
					String UserName=session.getAttribute("UserName").toString();
					
					String SeleSql="select * from UserInfo where UserGrant=0";
					
					//������������û�����Ϣ����
					if(null!=request.getParameter("msg")){
						int UserID=0;
						if(null!=request.getParameter("UserID")){
							UserID=Integer.parseInt(""+request.getParameter("UserID"));
						}
						if("ban".equals(request.getParameter("msg").toString())){
							String sql="update UserInfo set UserGrant=1 where UserID="+UserID+"";
							boolean flag=helperClass.SQL_ZSG(sql);
							if(flag){
								out.print("���ڳɹ���");
							}
							else{
								out.print("����ʧ�ܣ�");
							}
						}
						else if("pick".equals(request.getParameter("msg").toString())){
							String sql="update UserInfo set UserGrant=0 where UserID="+UserID+"";
							boolean flag=helperClass.SQL_ZSG(sql);
							if(flag){
								out.print("����������ɹ���");
							}
							else{
								out.print("���������ʧ�ܣ�");
							}
						}
					}
					
// 					�������������Ϣ
					if(!("null".equals(""+request.getParameter("limit")))){
						if("UserGrant".equals(""+request.getParameter("limit"))){
							SeleSql="select * from UserInfo where UserGrant=1";
						}
						else if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
							out.print("�����������ؼ���");
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
								<option value="null">ѡ����������</option>
								<option value="UserName">�����û�������</option>
								<option value="UserGrant">�鿴�������û�</option>
							</select>
										
							<input type="text" name="search">&nbsp;&nbsp;
							<input type="submit" value="����">
						</div>
						
						<div>
							<table border="3px" align="center" cellspacing="10px">
								<tr>
									<th>�û�ID</th>
									<th>�û���Ϣ</th>
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
													�û�����<%=user.getUserName() %><br>
													�û����룺<%=user.getUserPwd() %><br>
													�û��ջ���ַ��<%=user.getUserAddress() %><br>
													�û���ϵ��ʽ��<%=user.getUserPhone() %>
												</td>
												
												<%
													if(user.getUserGrant()==0){
														%>
														<td>
															<a href="#" onClick="ban(<%=user.getUserID() %>)">���������</a>
														</td>
														<%
													}
													else{
														%>
														<td>
															<a href="#" onClick="pick(<%=user.getUserID() %>)">���������</a>
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