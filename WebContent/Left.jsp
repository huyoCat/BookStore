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
				<table>
				<tr><td><a href="Index.jsp">��վ��ҳ</a></td></tr>
				<tr><td><a href="AddBook.jsp">����鼮</a></td></tr>
				<tr><td><a href="A_DeleBook.jsp">ɾ��/�޸��鼮��Ϣ</a></td></tr>
				<tr><td><a href="A_MaType.jsp">�����鼮���</a></td></tr>
				<tr><td><a>�����û�</a></td></tr>
				<tr><td><a href="A_MaOrder.jsp">������</a></td></tr>
				</table>
				<%
			}
			else{
				%>
				<table>
				<tr><td><a href="Index.jsp">��վ��ҳ</a></td></tr>
				<tr><td><a href="U_Star.jsp">�ղؼ�</a></td></tr>
				<tr><td><a href="U_Car.jsp">���ﳵ</a></td></tr>
				<tr><td><a href="U_hisOrder.jsp">��ʷ����</a></td></tr>
				<tr><td><a>�޸�����</a></td></tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table border="3px" align="center" cellspacing="10px">
				<tr><th>�鼮���</th></tr>
			<%
				String sqlBaType="select TypeName from BookType";
				List<Map<String, Object>> rsBType=helperClass.SelectSQL(sqlBaType);
				if(rsBType.size()==0){
					out.println("���ݴ�����ʾͼ�����ʧ�ܣ�");
				}
				else{
					for(Map<String, Object> item:rsBType){
						%>
						<tr><td><%=""+item.get("TypeName") %></td></tr>
						<%
					}
					
				}
			%>
			</table>
			<%
		}
		%>

	</div>
</body>
</html>