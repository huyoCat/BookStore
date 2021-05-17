<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*,javax.script.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>删除/修改书籍信息</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Deleting(ISBN){
			var BookISBN=ISBN;
			var flag=confirm("确认删除书籍？");
			if(flag){
				window.location.href="A_DeleBook.jsp?ISBN="+BookISBN+"&msg=delete";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
		<!-- 	检测是否登录 -->
		<%
		if(null==session.getAttribute("UserName")
			||("".equals(session.getAttribute("UserName").toString()))){
			out.println("请先登录网站！");
			%>
			<br><a href="Login.jsp">登录</a><br>
			<a href="Register.jsp">注册</a>
			<%
		}
		else{//已登录
			String UserName=session.getAttribute("UserName").toString();
			
			String SelectBookInfo="select * from BookInfo where 1=1";
			//如果有搜索限制条件
			if(!("null".equals(""+request.getParameter("limit")))){
				//如果搜索框无数值
				if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
					out.print("请输入搜索关键词");
				}
				else{
					String limit=request.getParameter("limit").toString();
					String search=helperClass.zhuanma(request.getParameter("search").toString());
					SelectBookInfo+=" and "+limit+" like '%'+'"+search+"'+'%'";
				}
				
			}
			
			
			//如果修改或者删除了书籍
			if(null!=request.getParameter("msg")&&
					"delete".equals(request.getParameter("msg").toString())){//删除
				
				String BookISBN=request.getParameter("ISBN");
				String deleSql="delete from BookInfo where BookISBN='"+BookISBN+"'";
				boolean flagDele=helperClass.SQL_ZSG(deleSql);
				if(flagDele){
					out.print("书籍删除成功");
				}
				else{
					out.print("书籍删除失败");
				}	
			}
			
			//什么都没有的时候显示书籍列表
			%>
			<form method="post">
				<div>
<!-- 					搜索条件 -->
					<select name="limit">
						<option value="null">选择搜索条件</option>
						<option value="BookISBN">按书籍编号搜索</option>
						<option value="BookName">按书籍名称搜索</option>
						<option value="BookType">按书籍类别搜索</option>
						<option value="BookWriter">按书籍作者搜索</option>
					</select>
					
					<input type="text" name="search">&nbsp;&nbsp;
					<input type="submit" value="搜索">
				</div>
				
				<table border="3px" align="center" cellspacing="10px">
					<tr>
						<th width="150px">图片</th>
						<th width="300px">书籍信息</th>
						<th width="150px">操作</th>
					</tr>
					
					<%
					List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectBookInfo);
					if(StarList.size()==0){
						out.print("书籍结果集查询失败或书籍不存在");
					}
					else{
						List<Book> bookList=helperClass.reBook(StarList);
						if(bookList.size()==0){//如果查询不到数据
							out.println("书籍列表转化失败或书籍不存在！");
						}
						else{
							Set<String> ISBNSet=new TreeSet<>();
							for(Book book:bookList){
								//如果可以加进列表，说明没有重复，可以在列表显示
								if(ISBNSet.add(book.getBookISBN())){
									%>
									<tr>
										<td>
										<%
										if(book.getBookPic().equals("picture/")){
											out.print("暂无图片");
										}
										else{
										%>
											<img src=<%=book.getBookPic() %> width="150px">
										<%
										}
										%>
										</td>
										
										<td>
										书名：<%=book.getBookName() %><br>
										ISBN：<%=book.getBookISBN() %><br>
										作者：<%=book.getBookWriter() %><br>
										简介：<%=book.getBookIntro() %><br>
										出版社：<%=book.getBookPublisher() %><br>
										图书类别：<%=book.getBookType() %><br>
										进价：<%=book.getBookCost() %><br>
										售价：<%=book.getBookSell() %><br>
										库存数量：<%=book.getBookCount() %><br>
										</td>
										
										<td>
											<a href="A_xiugaiBook.jsp?ISBN=<%=book.getBookISBN() %>">修改信息</a><br>
											
											<a href="#" onClick="Deleting(<%=book.getBookISBN() %>)">删除书籍</a>
										</td>
									
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
		}
		%>
		
		</div>
	</div>
</body>
</html>