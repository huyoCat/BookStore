<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>����鼮������</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		
		<div id="AddBook">
			<%
				//��ȡ����
				String BookName=request.getParameter("BookName");
// 				out.println(helperClass.zhuanma(BookName));
				String BookISBN=request.getParameter("BookISBN");
// 				out.println(BookISBN);
				String BookWriter=request.getParameter("BookWriter");
// 				out.println(helperClass.zhuanma(BookWriter));
				String BookPublisher=request.getParameter("BookPublisher");
// 				out.println(helperClass.zhuanma(BookPublisher));
				String BookIntro=request.getParameter("BookIntro");
// 				out.println(helperClass.zhuanma(BookIntro));
				String BookCost=request.getParameter("BookCost");
// 				out.println(BookCost);
				String BookSell=request.getParameter("BookSell");
// 				out.println(BookSell);
				String BookInDay=request.getParameter("BookInDay");
// 				out.println(BookInDay);
				//��ȡ�����б�򣬴������룬����Ҫ��ת��
				String BookType=request.getParameter("BookType");
// 				out.println(helperClass.zhuanma(BookType));
				
				//�������ݿ�
				// ����JDBC-ODBC��������������
				//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				//�������ݿ�URL
				//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
				String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
				Connection conn=DriverManager.getConnection( URL,"sa", "1064534251");
				Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				String sql="select TypeName from BookType";
				ResultSet rs=stmt.executeQuery(sql);
				
				//����
			%>
		
		</div>
	</div>
</body>
</html>