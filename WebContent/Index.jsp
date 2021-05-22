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
		
		<form method="post">
				<!-- 		搜索框 -->
			<div id="InsideBar">
				<select name="limit" id="insideChild">
					<option value="null">选择搜索条件</option>
					<option value="BookISBN">按书籍编号搜索</option>
					<option value="BookName">按书籍名称搜索</option>
					<option value="BookType">按书籍类别搜索</option>
					<option value="BookWriter">按书籍作者搜索</option>
				</select>
					
				<input type="text" name="search">&nbsp;&nbsp;
				<input type="submit" value="搜索">
			
			</div>
			</form>
			
<!-- 	中间的图书列表 -->
		<div id="bookTable">
			
		<%
		String sql2="select * from BookInfo where 1=1";
		
		//如果有搜索限制条件
		if(!("null".equals(""+request.getParameter("limit")))){
			//如果搜索框无数值
			if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
// 				out.print("alert('请输入搜索关键词')");
				%>
				<script type="text/javascript">
					alert('请输入搜索关键词');
				</script>
				<%
			}
			else{
				String limit=request.getParameter("limit").toString();
				String search=request.getParameter("search").toString();
				sql2+=" and "+limit+" like '%'+'"+search+"'+'%'";
			}
			
		}
		
		%>
		
		<form method="post">
		
<!-- 					显示列表 -->
			<div id="top">
			<table>
						<tr>
							<th width="150px">图片</th>
							<th width="200px">名称</th>
							<th width="400px">详情</th>
							<%
							if(null==session.getAttribute("iden")||!("iden".equals(""+session.getAttribute("iden")))){
								%>
								<th width="200px"></th>
								<%
							}
							%>
						</tr>
						<tr>
							<td colspan="4"><hr width="100%" color="black"></td>
						</tr>
<!-- 					连接数据库获取数据 ，下面是循环显示-->
						<%
							
							List<Map<String, Object>> rsList=helperClass.SelectSQL(sql2);
							
							if(rsList.size()==0){//如果查询不到数据
// 								out.println("无结果 或 数据错误！");
								%>
								<script type="text/javascript">
									alert('无结果 或 数据错误！');
								</script>
								<%
							}
							else{
								List<Book> bookList=helperClass.reBook(rsList);
								if(bookList.size()==0){//如果查询不到数据
// 									out.println("图书列表转化失败！");
									%>
									<script type="text/javascript">
										alert('图书列表转化失败！');
									</script>
									<%
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
												<td align="center"><%=book.getBookName() %></td>
												<td>作者：<%=book.getBookWriter() %><br>
													出版社：<%=book.getBookPublisher() %><br>
													简介：<%=book.getBookIntro() %><br>
													ISBN：<%=book.getBookISBN() %><br>
													图书类别：<%=book.getBookType() %><br>
													售价：<%=book.getBookSell() %>
													
													<%
													if(null!=session.getAttribute("iden")){
														%>
														<br>库存数量：<%=book.getBookCount() %>
														<%
													}
													%>
												</td>
												<%
												if(null==session.getAttribute("iden")||!("iden".equals(""+session.getAttribute("iden")))){
													%>
													<td align="center">
														<input type="hidden" name="ID" value="<%=book.getBookISBN() %>">
														<a href="U_Star.jsp?ID=<%=book.getBookISBN() %>">收藏</a><br><br>
														<a href="U_Car.jsp?ID=<%=book.getBookISBN() %>">加入购物车</a>
														
													</td>
													<%
												}
												%>
											</tr>
											<tr>
												<td colspan="4"><hr width="100%" color="black"></td>
											</tr>
										<%
										}
									}
								}
							}
						%>
					</table></div></form>
		</div>
	</div>
	
</body>
</html>