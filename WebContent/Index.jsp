<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>三味书屋</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
<!-- 	hello world!<br> -->
		<!-- 	网页头图  右上角 登录or 注册 -->
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
		
			<%
			//如果没有登录信息，显示原始页面，如果有，右上角显示用户名
			//获取信息
				String userName=request.getParameter("userName");
// 				out.println(helperClass.zhuanma(userName));
				String password=request.getParameter("password");
// 				out.println(helperClass.zhuanma(password));
				//没有登录信息
				if("".equals(userName)||userName==null){
					%>
<!-- 					显示列表 -->
				
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="150px">图片</th>
							<th width="200px">名称</th>
							<th width="400px">详情</th>
							<th width="200px">价格</th>
						</tr>
<!-- 					连接数据库获取数据 ，下面是循环显示-->
						<%
							String sql="select * from BookInfo";
							List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
							
							if(null==rs){//如果查询不到数据
								out.println("数据错误！");
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
												<td><img src=<%=book.getBookPic() %> width="150px"></td>
												<td><%=book.getBookName() %></td>
												<td>作者：<%=book.getBookWriter() %><br>
													出版社：<%=book.getBookPublisher() %><br>
													简介：<%=book.getBookIntro() %><br>
													ISBN：<%=book.getBookISBN() %>
												</td>
												<td><%=book.getBookSell() %></td>
											</tr>
										<%
									}
								}
							}
						%>
					</table>
					<% 
				}
				//连接数据库获取登录数据    如果没有登录信息左侧的东西也用不了
				else{//比较数据信息
					String sql="select * from UserInfo where UserName='"+userName+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					
					if(null==rs){//如果查询不到数据
						out.println("该用户不存在！");
						%>
						<a href="Login.jsp">重新登录</a>
						<%
					}
					else{//这里要区分是用户还是管理员
						for(Map<String, Object> item:rs){
							if(password.equals(""+item.get("UserPwd"))){
								out.println("欢迎登录！"+userName+"！");
							}
							else{
								out.println("密码错误，请重新输入密码。");
								%>
								<a href="javascript:history.back(-1)">重新登录</a>
								<%
							}
						}
						
						
					}
				}
			%>
		
			
		</div>
	</div>
	
</body>
</html>