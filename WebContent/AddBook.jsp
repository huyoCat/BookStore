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
			<form action="AddBook_2.jsp" method="post">
				�������鼮��Ϣ��<br><br>
				�鼮���ƣ�<input type="text" name="BookName">&nbsp;&nbsp;
				ͼ��ISBN��<input type="text" name="BookISBN"><br><br>
				ͼ�����ߣ�<input type="text" name="BookWriter">&nbsp;&nbsp;
				�����磺<input type="text" name="BookPublisher"><br><br>
				ͼ���飺<textarea name="BookIntro"></textarea>&nbsp;&nbsp;
				ͼ�����<select name="BookType">
					<%
						//�������ݿ�
						// ����JDBC-ODBC��������������
						//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
// 						Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
						//�������ݿ�URL
						//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
// 						String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
// 						Connection conn=DriverManager.getConnection( URL,"sa", "1064534251");
// 						Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
						String sql="select TypeName from BookType";
						List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
						
						//��ȡ�����б������
						if(null==rs){//�����ѯ��������
							out.println("���ݴ���");
						}
						else{//��ȡ������ʾ�������б��
// 							rs.beforeFirst();
// 							while(rs.next()){
							for(Map<String, Object> item:rs){
								String TypeName=""+item.get("TypeName");
								%>
									<option value="<%=TypeName%>"><%=TypeName%></option>
								<%
							}
// 							rs.close();
// 							stmt.close();
// 							conn.close();
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
		</div>
	</div>
</body>
</html>