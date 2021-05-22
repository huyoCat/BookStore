<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>确认订单</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
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
			//获取用户信息
			String SelectInfo="select * from UserInfo where UserName='"+UserName+"'";
			User user=new User();
			List<Map<String, Object>> GetUser=helperClass.SelectSQL(SelectInfo);
			if(GetUser.size()!=0){
				List<User> userList=helperClass.reUser(GetUser);
				if(userList!=null){
					user=userList.get(0);
				}
			}
			
			
// 			如果传过来的信息不为空
			if((null!=request.getParameterValues("BuyISBN"))&&
					(null!=request.getParameterValues("number"))){
				String[] ISBN=request.getParameterValues("BuyISBN");
				String[] number=request.getParameterValues("number");
				//判断数组是否等长
				if(ISBN.length==number.length){
					
//		 			下单页面肯定要带着购物信息过来，表格显示信息
					
					%>
					<form method="post" action="U_Confirmorder.jsp">
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th>购物信息</th><!-- 书名和数量 -->
						</tr>
						<% 
						float total=0;//总售价
						for(int i=0;i<ISBN.length;i++){
							String SelectSql="select * from BookInfo where BookISBN='"+ISBN[i]+"'";
							List<Map<String, Object>> rsGetList=helperClass.SelectSQL(SelectSql);
							if(rsGetList.size()!=0){
								List<Book> bookList=helperClass.reBook(rsGetList);
								if(bookList.size()!=0){
									Book book=bookList.get(0);
									
									float price=book.getBookSell();
									int count=Integer.parseInt(number[i]);
									total+=price*count;
									%>
									<tr>
										<td>
										书名：
										<input type="text" value="<%=book.getBookName() %>" readOnly><br>
										ISBN:<input type="text" name="ISBN" value="<%=book.getBookISBN() %>" readOnly><br>
										购买数量：<input type="text" name="number" value="<%=number[i] %>" readOnly>
										</td>
									</tr>
									<%
								}
								else{
									out.print("书籍信息转换失败");
									%>
									<a href="U_Buy.jsp">点击刷新</a>
									<%
								}
							}
							else{
								out.print("查询书籍信息失败");
								%>
								<a href="U_Buy.jsp">点击刷新</a>
								<%
							}
								
						}
						%>
						
					<tr>
						<td>
							总价：<input type="text" name="Tprice" value="<%=total %>" readOnly>
						</td>
					</tr>
					
					<tr>
						<td>
							联系方式：<input type="text" name="phone" value="<%=user.getUserPhone() %>"><br>
							收货地址：<textarea name="address"><%=user.getUserAddress() %></textarea>
						</td>
					</tr>
						
					
					
					<tr>
					<td align="center"><input type="submit" value="提交订单">&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:history.back(-1)">返回修改</a>
					</td>
					</tr>
					</table>
					</form>
					<%
				}
				else{
					%>
					<a href="U_Buy.jsp">数据出错，点击刷新</a>
					<%
				}

			}
			else{
				out.println("购物车空空如也");
				%>
				<a href="Index.jsp">返回首页添加商品</a>
				<%
			}
			
		}
		%>
		
		</div>
	</div>

</body>
</html>