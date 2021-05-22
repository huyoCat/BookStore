<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改订单</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
// 		var total=document.getElementByName('Tprice').value;
		function getNum(){
// 			alert("1");
			var price=document.getElementsByName("Cost");
			var number=document.getElementsByName("number");
// 			var price=new Array();
// 			alert("1");
			var total=0;
			for(var i=0;i<price.length;i++){
// 				alert(price[i].value);
// 				alert(number[i].value);
				total+=price[i].value*number[i].value;
				
			}
// 			alert(total);
// 			return total;
			document.getElementById("Tprice").value=""+total;
// 			vartp=document.getElementByName("Tprice");
// 			tp.value=total;
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
		<%//确认是否登录网站
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
				String OrderID=request.getParameter("OrderID").toString();
				
				%>
				<form method="post" action="U_Confirmorder.jsp?msg=updateOrder&OrderID=<%=OrderID %>">
					<table align="center">
						<tr>
							<th>书籍图片</th>
							<th>书籍信息</th>
							<th>修改</th>
						</tr>
						<tr>
							<td colspan="4"><hr width="100%" color="black"></td>
						</tr>
						<%
// 						根据订单查询购书信息
						String sqlOrder="select * from OrderInfo where OrderID="+OrderID+"";
						List<Map<String, Object>> StarList=helperClass.SelectSQL(sqlOrder);
						if(StarList.size()==0){
							out.print("订单结果集查询失败  或  订单不存在");
						}
						else{
							List<Order> OrderList=helperClass.reOrder(StarList);
							if(OrderList.size()==0){//如果查询不到数据
								out.println("订单列表转化失败  或  订单不存在！");
							}
							else{
								Order order=OrderList.get(0);
								
								//获取用户购买的图书列表
								List<Book_Number> BookList=helperClass.updateOrder(""+order.getBookList());
// 								Map<Book,Integer> BookList=helperClass.updateOrder(""+order.getBookList());
// 								List<String[]>

								float total=0;
// 								获取购买数量
								for(Book_Number book_number:BookList){
									Book book=book_number.getBook();
									int BuyNumber=book_number.getNumber();
									%>
									<tr>
										<td align="center"><%
												if(book.getBookPic().equals("picture/")){
													out.print("暂无图片");
												}
												else{
													%>
													<img src=<%=book.getBookPic() %> width="150px">
													<%
												}
												%></td>
										<td>
											书名：<input type="text" value="<%=book.getBookName() %>" readOnly><br>
											ISBN：<input type="text" name="ISBN" value="<%=book.getBookISBN() %>" readOnly><br>
											单价：<input type="text" name="Cost" value="<%=book.getBookSell() %>" readOnly><br>
										</td>
										<td>
										 	购买数量：<input type="text" name="number" value="<%=BuyNumber %>" OnInput="getNum()">
										</td>
									</tr>
									<tr>
										<td colspan="4"><hr width="100%" color="black"></td>
									</tr>
									<%
// 									int n=request.getParameter("number");
// 									total+=book.getBookCost()*n;
								}
								%>
								<tr>
									<td colspan="2">
										联系方式：<input type="text" name="phone" value=<%=order.getPhone() %>><br>
										收货地址：<textarea name="address" ><%=order.getAddress() %></textarea>
									</td>
									<td>
										总价=<input type="text" name="Tprice" id="Tprice" value=<%=order.getTotalPrice() %> readOnly>
									</td>
								</tr>
								
								<tr>
									<td colspan="3" align="center">
										<input type="submit" value="提交订单">
									</td>
								</tr>
								
								<%
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