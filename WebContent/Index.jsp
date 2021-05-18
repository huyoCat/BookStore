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
							List<Map<String, Object>> rsList=helperClass.SelectSQL(sql2);
							
							if(rsList.size()==0){//如果查询不到数据
								out.println("数据错误！");
							}
							else{
								List<Book> bookList=helperClass.reBook(rsList);
								if(bookList.size()==0){//如果查询不到数据
									out.println("数据错误！");
								}
								else{
									Set<String> ISBNSet=new TreeSet<>();
									for(Book book:bookList){
										//如果可以加进列表，说明没有重复，可以在列表显示
										if(ISBNSet.add(book.getBookISBN())){
											%>
											<tr>
												<td><%
												if(book.getBookPic().equals("picture/")){
													out.print("暂无图片");
												}
												else{
													%>
													<img src=<%=book.getBookPic() %> width="150px">
													<%
												}
												%></td>
												<td><%=book.getBookName() %></td>
												<td>作者：<%=book.getBookWriter() %><br>
													出版社：<%=book.getBookPublisher() %><br>
													简介：<%=book.getBookIntro() %><br>
													ISBN：<%=book.getBookISBN() %><br>
													图书类别：<%=book.getBookType() %><br>
													售价：<%=book.getBookSell() %>
												</td>
												<td>
<!-- 													<form action=""> -->
													<input type="hidden" name="ID" value="<%=book.getBookISBN() %>">
													<a href="U_Car.jsp?ID=<%=book.getBookISBN() %>">加入购物车</a>
<!-- 													这里做点了收藏不需要跳转，跳出来一个框提示收藏成功 -->
													<form method="post">
														<a href="U_Star.jsp?ID=<%=book.getBookISBN() %>">收藏</a>
													</form>
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
							}
						%>
					</table>
		</div>
	</div>
	
</body>
</html>