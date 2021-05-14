<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>购物车</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的购物车列表 -->
		<div id="bookTable">
		<form action="U_buy.jsp" method="post">
			<table>
				<tr>
					<th width="150px">图片</th>
					<th width="400px">信息</th>
					<th width="150px">购买数量</th>
					<th width="150px"><input type="button" value="全部购买"></th>
				</tr>
				<%
				String ISBN=request.getParameter("ID");
				if("".equals(ISBN)||ISBN!=null){
						ISBN=helperClass.zhuanma(ISBN);
					String sql="select * from BookInfo where BookISBN='"+ISBN+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					if(rs==null){
						out.println("加入购物车错误！");
					}
					else{
						List<Book> bookList=helperClass.reBook(rs);
						if(null==bookList){//如果查询不到数据
							out.println("数据错误！");
						}
						else{
							for(Book book:bookList){
							%>
								<tr>
									<td><img src="<%=book.getBookPic() %>" width="150px"></td>
									<td>书名：<%=book.getBookName() %><br>
										作者：<%=book.getBookWriter() %><br>
										出版社：<%=book.getBookPublisher() %><br>
										简介：<%=book.getBookIntro() %><br>
										ISBN：<%=book.getBookISBN() %><br>
										售价：<%=book.getBookSell() %>
									</td>
									<td><input type="text" name="number"></td>
									<td><a href="delete.jsp?ISBN=<%=book.getBookISBN() %>">移除商品</a></td>
								</tr>	
							<%
							}
						}
					}
				}
			%>
			</table>
			</form>
			<%
			//将ISBN和数量添加进列表里
			List<String> buyList=new ArrayList<>();
// 			for()
				
			%>
		</div>
		
	</div>
</body>
</html>