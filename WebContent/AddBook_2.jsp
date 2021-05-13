<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
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

				String Cost=request.getParameter("BookCost");
// 				out.println(BookCost);
				String Sell=request.getParameter("BookSell");
// 				out.println(BookSell);
				String BookInDay=request.getParameter("BookInDay");
// 				out.println(BookInDay);
				//获取下拉列表框，存在乱码，中文要做转码
				String BookType=request.getParameter("BookType");
// 				out.println(helperClass.zhuanma(BookType));
				//验证取值
				//判断价钱是否是数字
				double BookCost=0;
				double BookSell=0;
				try{
					BookCost=Double.parseDouble(Cost);
					BookSell=Double.parseDouble(Sell);
				}
				catch(Exception e){
					out.println("请确认商品价格填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				if(!helperClass.isDate(BookInDay)){
					out.println("请确认进货日期填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				if(null==BookName||"".equals(BookName)||null==BookISBN||"".equals(BookISBN)||
						null==BookWriter||"".equals(BookWriter)||
						null==BookPublisher||"".equals(BookPublisher)||
						null==BookIntro||"".equals(BookIntro)){
// 					if()
					out.println("请确认信息填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				
				//连接数据库
				// 加载JDBC-ODBC桥驱动驱动程序
				//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
// 				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				//连接数据库URL
				//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
// 				String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
// 				Connection conn=DriverManager.getConnection( URL,"sa", "1064534251");
// 				Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				
				
				//查询有没有一样的ISBN，再存入   逻辑不对，可以插入，可以加一个一共多少本循环插入
				String sql="select BookISBN from BookInfo";
				List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
				if(null==rs){//如果查询不到数据
					out.println("数据错误！");
				}
				else{
					for(Map<String, Object> item:rs){
						String ISBN=""+item.get("BookISBN");
						if(BookISBN==ISBN){
							out.println("书籍ISBN已存在！");
							%>
							<a href="javascript:history.back(-1)">返回重填</a>
							<% 
							return;
						}
					}
				}
				
				//存入数据
				
				String Addsql="insert into BookInfo (BookName,BookISBN,BookWriter,BookPublisher,BookIntro,BookCost,BookSell,BookInDay,BookType) "+
					"values('"+BookName+"','"+BookISBN+"','"+BookWriter+"','"+BookPublisher+"','"+BookIntro+"',"+BookCost+","+BookSell+",'"+BookInDay+"','"+BookType+"')";
// 				ResultSet rInser=stmt.executeQuery(Addsql);
				boolean flag=helperClass.SQL_ZSG(Addsql);
				if(flag){
					out.println("书籍添加成功！");
					%>
					<a href="AddBook.jsp">继续添加</a>
					<% 
				}
				else{
					out.println("书籍添加失败！");
					%>
					<a href="javascript:history.back(-1)">重新添加</a>
					<% 
				}
			%>
		
		</div>
	</div>
</body>
</html>