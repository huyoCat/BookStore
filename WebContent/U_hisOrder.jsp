<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>我的历史订单</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function OrderUpda(OrderID){
			var OrderID=OrderID;
			var flag=confirm("确认取消订单？");
			if(flag){
				window.location.href="U_hisOrder.jsp?OrderID="+OrderID+"&msg=deleOrder";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
											<!-- 		一个搜索框 -->
				<form method="post">
				<div id="InsideBar">
					<select name="limit" id="insideChild">
						<option value="null">选择搜索条件</option>
						<option value="OrderID">按订单编号搜索</option>
						<option value="NotyetOrder">查看未发货订单</option>
						<option value="CompOrder">查看已完成订单</option>
						<option value="CancelOrder">查看已取消订单</option>
					</select>
							
					<input type="text" name="search">&nbsp;&nbsp;
					<input type="submit" value="搜索">
				</div>
				</form>
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
				String SelectOrderInfo="select * from OrderInfo where UserName='"+UserName+"'";
				
				//如果有搜索限制条件
				if(!("null".equals(""+request.getParameter("limit")))){
					
					if("CancelOrder".equals(""+request.getParameter("limit"))){
						SelectOrderInfo="select * from OrderInfo where CancelOrder=1 and UserName='"+UserName+"'";
					}
					else if("CompOrder".equals(""+request.getParameter("limit"))){
						SelectOrderInfo="select * from OrderInfo where Orderstate=1 and UserName='"+UserName+"'";
					}
					else if("NotyetOrder".equals(""+request.getParameter("limit"))){
						SelectOrderInfo="select * from OrderInfo where Orderstate=0 and CancelOrder=0 and UserName='"+UserName+"'";
					}
					
					//如果搜索框无数值
					else if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
						out.print("请输入搜索关键词");
					}
					else{
						String limit=request.getParameter("limit").toString();
						String search=request.getParameter("search").toString();
						SelectOrderInfo+=" and "+limit+" like '%'+'"+search+"'+'%'";
					}
					
				}
				
// 				如果有删除订单的信息
				if(null!=request.getParameter("msg")&&
					"deleOrder".equals(request.getParameter("msg").toString())){
					int OrderID=Integer.parseInt(""+request.getParameter("OrderID"));
// 	 				String deleSql="delete from OrderInfo where OrderID='"+OrderID+"'";
					String sqlOrderSta="update OrderInfo set CancelOrder=1 where OrderID="+OrderID+"";
					
					boolean flagDele=helperClass.SQL_ZSG(sqlOrderSta);
					if(flagDele){
						out.print("取消订单成功");
					}
					else{
						out.print("取消订单失败");
					}
					
				}
				
				%>
				<!-- 		如果订单还没有确认用户可以删除订单 -->
				<form method="post">
			<!-- 		一个订单列表 -->
					<div>
						<table border="3px" align="center" cellspacing="10px">
							<tr>
								<th width="150px">订单编号</th>
								<th width="300px">订单信息</th>
								<th width="150px">订单状态</th>
							</tr>
							<%
							List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectOrderInfo);
							if(StarList.size()==0){
								out.print("订单结果集查询失败  或  订单不存在");
							}
							else{
								List<Order> OrderList=helperClass.reOrder(StarList);
								if(OrderList.size()==0){//如果查询不到数据
									out.println("订单列表转化失败  或  订单不存在！");
								}
								else{
									for(Order order:OrderList){
										//获取用户购买的图书列表
										List<String> BookList=helperClass.OrderBook(""+order.getBookList());
										
										String state="";
										%>
										<tr>
											<td align="center"><%=order.getOrderID() %><br></td>
											
											<td>
											购买图书：<BR><BR>
											<div>
											<%
											for(String str:BookList){
												out.println(str+"<BR><BR>");
											}
											%>
											</div>
											订单总价：<%=order.getTotalPrice() %><br>
											下单日期：<%=order.getOrderDay() %><br>
											收货地址：<%=order.getAddress() %><br>
											联系方式：<%=order.getPhone() %><br>
											</td>
											
											<td align="center">
												<%
												if(order.getCancelOrder()==1){
													%>
													目前状态：已取消<Br>
													<a href="U_UpdaOrder.jsp?OrderID=<%=order.getOrderID() %>">重新购买</a>
													<%
												}
												else{
													if(order.getOrderstate()==0){
														state="尚未发货";
														%>
														目前状态：<%=state %><br>
														<a href="U_UpdaOrder.jsp?OrderID=<%=order.getOrderID() %>">修改订单</a><br>
														<a href="#" onClick="OrderUpda(<%=order.getOrderID() %>)">取消购买</a>
														<%
													}
													else{
														state="订单完成";
														%>
														目前状态：<%=state %><br>
														<%
													}
												}
												%>
												
												
											</td>
										</tr>
										<%
									
									}
								}
							}
							%>
						
						</table>
					</div>
				
				</form>
				<%
				
				
			}
			%>
		
		</div>
	</div>
</body>
</html>