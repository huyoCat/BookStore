<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>三味书屋</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
<!-- 	<script src="myJs.js"> -->

<!-- 	</script> -->
</head>
<body>
		<!-- 	网页头图  右上角 登录or 注册 -->
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
		
<!-- 					显示列表 -->
			<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="150px">图片</th>
							<th width="200px">名称</th>
							<th width="400px">详情</th>
							<th width="200px"></th>
						</tr>
<!-- 					连接数据库获取数据 ，下面是循环显示-->
						<%
							String sql2="select * from BookInfo";
							List<Map<String, Object>> rs2=helperClass.SelectSQL(sql2);
							
							if(null==rs2){//如果查询不到数据
								out.println("数据错误！");
							}
							else{
								List<Book> bookList=helperClass.reBook(rs2);
								if(null==bookList){//如果查询不到数据
									out.println("数据错误！");
								}
								else{
									for(Book book:bookList){
										%>
											<tr>
												<td><img src=<%=book.getBookPic() %> width="150px"></td>
												<td><%=book.getBookName() %></td>
												<td>作者：<%=book.getBookWriter() %><br>
													出版社：<%=book.getBookPublisher() %><br>
													简介：<%=book.getBookIntro() %><br>
													ISBN：<%=book.getBookISBN() %><br>
													售价：<%=book.getBookSell() %>
												</td>
												<td>
<!-- 													<form action=""> -->
													<input type="hidden" name="ID" value="<%=book.getBookID() %>">
													<a href="U_Car.jsp?ID=<%=book.getBookID() %>">购买</a>
													<a href="U_Star.jsp">收藏</a>
<!-- 														<input type="submit" value="收藏" name="star"><br> -->
<!-- 														<input type="submit" value="加入购物车" name="add"><br> -->
<!-- 														<input type="submit" value="立即购买" name="buy"> -->
<!-- 													</form> -->
												</td>
											</tr>
										<%
									}
								}
							}
						%>
					</table>
		</div>
	</div>
	
</body>
</html>