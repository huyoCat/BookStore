<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸ĸ�����Ϣ</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Check(){
// 			alert("!");
			var NowPwd=document.getElementById("NowPwd").value;
			var concernPwd=document.getElementById("concernPwd").value;
			var flag=(NowPwd==concernPwd);
			if(!flag){
				alert("��ȷ���޸ĺ����������������ͬ");
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
			
				//�޸�����
				if(null!=request.getParameter("BePwd")&&!("".equals(request.getParameter("BePwd")))
					&&null!=request.getParameter("NowPwd")&&!("".equals(request.getParameter("NowPwd")))
					&&null!=request.getParameter("concernPwd")&&!("".equals(request.getParameter("concernPwd")))){
					
					String BePwd=""+request.getParameter("BePwd");
					String NowPwd=""+request.getParameter("NowPwd");
					String concernPwd=""+request.getParameter("concernPwd");
					//�ȱȽ�ԭ�����Ƿ���ȷ
					String compare="select UserPwd from UserInfo where UserName='"+UserName+"'";
					List<Map<String, Object>> StarList=helperClass.SelectSQL(compare);
					if(StarList.size()!=0){
						if(BePwd.equals(StarList.get(0).get("UserPwd"))){
							String update="update UserInfo set UserPwd='"+NowPwd+"' UserName='"+UserName+"'";
							boolean flag=helperClass.SQL_ZSG(update);
							if(flag){
								%>
								<a href="Index.jsp">�޸ĳɹ���������ҳ</a>
								<%
							}
							else{
								%>
								<a href="U_UpdateMsg.jsp">�޸�ʧ�ܣ������޸�</a>
								<%
							}
						}
						else{
// 							out.print("ԭ���������������������");
							%>
							<a href="U_UpdateMsg.jsp">ԭ���������������������</a>
							<%
						}
					}
				}
				
				
				//�޸ĵ�ַ
				if(null!=request.getParameter("Address")&&!("".equals(""+request.getParameter("Address")))){
					String UserAddress=""+request.getParameter("Address");
					String update="update UserInfo set UserAddress='"+UserAddress+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(update);
					if(flag){
						%>
						<a href="Index.jsp">�޸ĳɹ���������ҳ</a>
						<%
					}
					else{
						%>
						<a href="U_UpdateMsg.jsp">�޸�ʧ�ܣ������޸�</a>
						<%
					}
				
				}
				
				//�޸���ϵ��ʽ
				if(null!=request.getParameter("Phone")&&!("".equals(""+request.getParameter("Phone")))){
					String UserPhone=""+request.getParameter("Phone");
					String update="update UserInfo set UserPhone='"+UserPhone+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(update);
					if(flag){
						%>
						<a href="Index.jsp">�޸ĳɹ���������ҳ</a>
						<%
					}
					else{
						%>
						<a href="U_UpdateMsg.jsp">�޸�ʧ�ܣ������޸�</a>
						<%
					}
				
				}
				
				if(null!=request.getParameter("msg")&&!("".equals(""+request.getParameter("msg")))){
					
					//������޸���������
					if("Pwd".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post" onSubmit="return Check()">
							������ԭ���룺<input type="password" name="BePwd" id="BePwd"><br>
							�޸ĺ�����룺<input type="password" name="NowPwd" id="NowPwd"><br>
							��ȷ�����룺<input type="password" name="concernPwd" id="concernPwd"><br>
							<input type="submit" value="ȷ��"  name="updatePwd">
						</form>
						<%
					}
					
					
					//������޸ĵ�ַ����
					if("Address".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post">
							�������ջ���ַ��<textarea name="Address" rows="" cols=""></textarea>
							<input type="submit" value="ȷ��"  name="updateAddress">
						</form>
						<%
					}
					
					
					//������޸���ϵ��ʽ����
					if("Phone".equals(""+request.getParameter("msg"))){
						%>
						<form action="" method="post">
							��������ϵ��ʽ��<input type="text" name="Phone">
							<input type="submit" value="ȷ��" name="updatePhone">
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