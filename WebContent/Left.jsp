<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>Insert title here</title>
	
	<link type="text/css" rel="stylesheet" href="left.css"/>
</head>
<body>
	<div id="Left">
<!-- 		ͨ��ѭ������ͼ����� -->
		<%
// 		�Ѿ���¼��״̬
		if(null!=session.getAttribute("UserName")){
			if(null!=session.getAttribute("iden")&&("iden".equals(""+session.getAttribute("iden")))){//�ǹ���Ա
				%>
				<table id="LtABLE" cellspacing="15">
				<tr><td id="left_User">><a href="Index.jsp">��վ��ҳ</a></td></tr>
				<tr><td id="left_User">><a href="AddBook.jsp">����鼮</a></td></tr>
				<tr><td id="left_User">><a href="A_DeleBook.jsp">ɾ��/�޸��鼮��Ϣ</a></td></tr>
				<tr><td id="left_User">><a href="A_MaType.jsp">�����鼮���</a></td></tr>
				<tr><td id="left_User">><a href="A_MaUser.jsp">�����û�</a></td></tr>
				<tr><td id="left_User">><a href="A_MaOrder.jsp">������</a></td></tr>
				</table>
				<%
			}
			else{
				%>
				<table id="LtABLE" cellspacing="15">
				<tr><td id="left_User"><a href="Index.jsp">��վ��ҳ</a></td></tr>
				<tr><td id="left_User"><a href="U_Star.jsp">�ղؼ�</a></td></tr>
				<tr><td id="left_User"><a href="U_Car.jsp">���ﳵ</a></td></tr>
				<tr><td id="left_User"><a href="U_hisOrder.jsp">��ʷ����</a></td></tr>
				<tr><td id="left_User"><a href="U_UpdateMsg.jsp">�޸ĸ�����Ϣ</a></td></tr>
				</table>
				<%
			}
		}
		else{
			%>
			<img src="picture/welcome.png" id="leftPic">
			<%
		}
		%>

	</div>
</body>
</html>