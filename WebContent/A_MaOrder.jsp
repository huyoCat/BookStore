<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>管理订单</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
	<script type="text/javascript">
		function OrderUpda(OrderID){
			var OrderID=OrderID;
			var flag=confirm("确认完成订单？");
			if(flag){
				window.location.href="A_MaOrder.jsp?OrderID="+OrderID+"&msg=complect";
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
			
			String SelectOrderInfo="select * from OrderInfo where 1=1";
		
			//如果有搜索限制条件
			if(!("null".equals(""+request.getParameter("limit")))){
				if("CancelOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where CancelOrder=1";
				}
				else if("CompOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where Orderstate=1";
				}
				else if("NotyetOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where Orderstate=0 and CancelOrder=0";
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
			
			//如果修改了订单状态
			if(null!=request.getParameter("msg")&&
					"complect".equals(request.getParameter("msg").toString())){
				
				int OrderID=Integer.parseInt(""+request.getParameter("OrderID"));
// 				String deleSql="delete from BookInfo where BookISBN='"+BookISBN+"'";

// 				先看看库存数量够不够
// 				通过orderID获取购买的书籍列表				
				String selectBook="select * from OrderInfo where OrderID="+OrderID+"";
				List<Map<String, Object>> rsGetList=helperClass.SelectSQL(selectBook);
				String BookList=""+rsGetList.get(0).get("BookList");
				List<Book_Number> buyList=helperClass.updateOrder(BookList);
				//根据书籍列表查看库存
				boolean flag=true;
				for(int i=0;i<buyList.size();i++){
					String sql="select * from BookInfo where BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					int count=Integer.parseInt(""+rs.get(0).get("BookCount"));
					if(count<buyList.get(i).getNumber()){
						out.println("库存不足");
						flag=false;
						break;
					}
				}
				if(flag){
					String sqlOrderSta="update OrderInfo set Orderstate=1 where OrderID="+OrderID+"";
					
					boolean flagDele=helperClass.SQL_ZSG(sqlOrderSta);
					
					boolean InfoFlag=true;
					if(flagDele){
						out.print("订单状态修改成功<br>");
						//修改BookInfo的销售信息和库存信息
						for(int i=0;i<buyList.size();i++){
							int count=buyList.get(i).getNumber();//用户购买的数量
							//查询前几条数据记录BookID
							String sql="select top "+count+" * from BookInfo where IsSell=0 and BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
							List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
// 							String[] IDList=new String[rs.size()];
// 							

							for(int j=0;j<count;j++){
								String BookID=""+rs.get(j).get("BookID");
								String Date=helperClass.getDate();
								String SellSql="update BookInfo set IsSell=1,OrderID="+OrderID+",BookOutDay='"+Date+"' where BookID="+BookID+"";
								InfoFlag=helperClass.SQL_ZSG(SellSql);
								if(!InfoFlag){
									out.print("数据库已售信息修改出错，已成功更改"+(j+1)+"本");
									break;
								}
							}
							if(!InfoFlag){
								break;
							}
							else{
// 								修改库存							
								String sqlCount="select BookISBN from BookInfo where IsSell=0 and BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
								List<Map<String, Object>> rsAmount=helperClass.SelectSQL(sqlCount);
								int BookAmount=rsAmount.size();
								//更新库存数据
								String updateSql="update BookInfo set BookCount="+BookAmount+" where BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
								boolean flagUpdate=helperClass.SQL_ZSG(updateSql);
								if(flagUpdate){
									out.println("库存数量修改成功！<BR>");
								}
								else{
									out.println("库存数量修改失败！<BR>");
								}
							}
						}
						if(InfoFlag){
							out.print("数据库书籍已售信息修改成功<BR>");
						}
						
					}
					else{
						out.print("订单状态修改失败");
					}	
				}
			}
			
		%>
		<form action="" method="post">
			<!-- 		一个搜索框 -->
			<div>
				<select name="limit">
					<option value="null">选择搜索条件</option>
					<option value="OrderID">按订单编号搜索</option>
					<option value="UserName">按购买用户搜索</option>
					<option value="NotyetOrder">查看未发货订单</option>
					<option value="CompOrder">查看已完成订单</option>
					<option value="CancelOrder">查看已取消订单</option>
				</select>
						
				<input type="text" name="search">&nbsp;&nbsp;
				<input type="submit" value="搜索">
			</div>
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
									<td><%=order.getOrderID() %><br></td>
									
									<td>
									购买用户：<%=order.getUserName() %><br>
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
									
									<td>
									<%
									if(order.getCancelOrder()==1){
										out.print("目前状态：已取消");
									}
									else{
										if(order.getOrderstate()==0){
											state="尚未发货";
											%>
											目前状态：<%=state %><br>
											<a href="#" onClick="OrderUpda(<%=order.getOrderID() %>)">完成订单</a>
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