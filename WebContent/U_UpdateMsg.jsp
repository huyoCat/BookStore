<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸ĸ�����Ϣ</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
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
				String UserName=session.getAttribute("UserName").toString();

				String seleSql="select * from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(seleSql);
				if(StarList.size()==0){
					out.print("���ݴ���");
					%>
					<a href="U_UpdateMsg.jsp">���ˢ��</a>
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
									<th>�ҵ���Ϣ</th>
									<th></th>
								</tr>
								<tr>
									<td>�û�����<%=user.getUserName() %></td>
									<td>�û�����ֹ�޸�</td>
								</tr>
								<tr>
									<td>�û����룺���ɼ�</td>
									<td><a href="U_UpdateMsg2.jsp?msg=Pwd">�޸�</a></td>
								</tr>
								<tr>
									<td>�ջ���ַ��<%=user.getUserAddress() %></td>
									<td><a href="U_UpdateMsg2.jsp?msg=Address">�޸�</a></td>
								</tr>
								<tr>
									<td>��ϵ�绰��<%=user.getUserPhone() %></td>
									<td><a href="U_UpdateMsg2.jsp?msg=Phone">�޸�</a></td>
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