<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>添加书籍处理结果</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
		
		<div id="AddBook">
			<%
				//获取数据
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
				//获取下拉列表框，存在乱码，中文要做转码
				String BookType=request.getParameter("BookType");
// 				out.println(helperClass.zhuanma(BookType));
				
				//连接数据库
				// 加载JDBC-ODBC桥驱动驱动程序
				//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				//连接数据库URL
				//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
				String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
				Connection conn=DriverManager.getConnection( URL,"sa", "1064534251");
				Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				String sql="select TypeName from BookType";
				ResultSet rs=stmt.executeQuery(sql);
				
				//存入
			%>
		
		</div>
	</div>
</body>
</html>