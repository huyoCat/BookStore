<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��¼</title>
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
			<form method="post" onSubmit="return check();" id="LoginAnd">
				<!-- ��¼ҳ�� -->
<!-- 		<img src="picture/Login.png" height="30"> -->
				�˺ţ�&nbsp;<input type="text" name="userName" id="name"><br><br>
				���룺&nbsp;<input type="password" name="password" id="pwd"><br><br>
<!-- 				<input type="radio" name="iden" value="�û�"> -->
				�Ƿ����Ա��<input type="radio"  name="iden">&nbsp;&nbsp;
				<input type="submit" value="��¼">&nbsp;&nbsp;
				<input type="reset" value="���">
			</form>
			<%
				//�������ݿ���֤��Ϣ����session
				String UserName=request.getParameter("userName");
				String UserPwd=request.getParameter("password");
				
				//����ǹ���Ա
				if(null!=request.getParameter("iden")){
					if(!("".equals(UserName))&&UserName!=null&&
							!("".equals(UserPwd))&&UserPwd!=null){
						String sql1="select * from ADInfo where ADName='"+UserName+"'";
						List<Map<String, Object>> rs1=helperClass.SelectSQL(sql1);
						if(rs1.size()==0){//�����ѯ��������
// 							out.println("�ù���Ա�����ڣ�");
							%>
							<script type="text/javascript">
								alert('�ù���Ա�����ڣ�');
							</script>
							<%
						}
						else{
							for(Map<String, Object> item:rs1){
								if(UserPwd.equals(""+item.get("ADPwd"))){
									//��¼�ɹ����ض�����ҳ����¼session��Ϣ
									session.setAttribute("UserName", UserName);
									session.setAttribute("UserName", UserPwd);
									session.setAttribute("iden", "iden");
									response.sendRedirect("Index.jsp");
//	 								out.println("��ӭ��¼��"+UserName+"��");
								}
								else{
									%>
									<script type="text/javascript">
										alert('��������������������룡');
									</script>
									<%
// 									out.println("��������������������롣");
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
						
						if(rs1.size()==0){//�����ѯ��������
// 							out.println("���û������ڣ�");
							%>
							<script type="text/javascript">
								alert('���û������ڣ�');
							</script>
							<%
						}
						else{
							for(Map<String, Object> item:rs1){
								if(UserPwd.equals(""+item.get("UserPwd"))){
									//��¼�ɹ����ض�����ҳ����¼session��Ϣ
									session.setAttribute("UserName", UserName);
									session.setAttribute("UserPwd", UserPwd);
									response.sendRedirect("Index.jsp");
//	 								out.println("��ӭ��¼��"+UserName+"��");
								}
								else{
									%>
									<script type="text/javascript">
										alert('��������������������룡');
									</script>
									<%
// 									out.println("��������������������롣");
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