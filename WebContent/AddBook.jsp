<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>����鼮</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	
 	
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м������鼮 -->
		<div id="AddBook"><!-- = = method�ĳ�post��ת��Ų������� -->
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
		
			%>
			<form action="AddBook_2.jsp" method="post" id="ABook">
				�������鼮��Ϣ��<br><br>
				�鼮���ƣ�<input type="text" name="BookName">&nbsp;&nbsp;
				ͼ��ISBN��<input type="text" name="BookISBN"><br><br>
				ͼ�����ߣ�<input type="text" name="BookWriter">&nbsp;&nbsp;
				�����磺<input type="text" name="BookPublisher"><br><br>
				ͼ���飺<textarea name="BookIntro"></textarea>&nbsp;&nbsp;
				ͼ�����<select name="BookType">
					<%
						String sqlGetType="select TypeName from BookType";
						List<Map<String, Object>> rsGetType=helperClass.SelectSQL(sqlGetType);
						
						//��ȡ�����б������
						if(rsGetType.size()==0){//�����ѯ��������
							out.println("���ݴ���");
						}
						else{//��ȡ������ʾ�������б��
							for(Map<String, Object> item:rsGetType){
								String TypeName=""+item.get("TypeName");
								%>
									<option value="<%=TypeName%>"><%=TypeName%></option>
								<%
							}
						}
					%>
				</select><br><br>
				�����۸�<input type="text" name="BookCost">&nbsp;&nbsp;
				���ۼ۸�<input type="text" name="BookSell"><br><br>
				�������ڣ�<input type="text" name="BookInDay"><!-- Ҫ����ʽ�ж� -->&nbsp;&nbsp;
				��ƷͼƬ��<input type="file" name="file">
				
				<!-- ��ȡ�ļ� -->
				<!-- 				�������дһ�������Զ��޸���� -->
				<br><br>
				������Ŀ��<input type="text" name="number">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" value="����">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="���">
			</form>
			
			<%
		}
		%>
		
			
		</div>
	</div>
</body>
</html>