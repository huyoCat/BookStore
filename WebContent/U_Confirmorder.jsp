<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>提交订单</title>
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
			
// 			确定获取的信息不为空
			if(null!=request.getParameter("phone")&&!("".equals(""+request.getParameter("phone")))
			&&null!=request.getParameter("address")&&!("".equals(""+request.getParameter("address")))){
				
				String Address=""+request.getParameter("address");
				String Phone=""+request.getParameter("phone");
				
				String[] ISBN=request.getParameterValues("ISBN");
				String[] number=request.getParameterValues("number");
				
				String Price="";
				if(null!=request.getParameter("Tprice")){
					Price=request.getParameter("Tprice").toString();
					
				}
				float TotalPrice=Float.parseFloat(Price);
				String OrderDay=helperClass.getDate();
				
// 				合并字符串
				String BookList="";
				for(int i=0;i<ISBN.length;i++){
					if(i==ISBN.length-1){
						BookList+=ISBN[i]+","+number[i];
					}
					else{
						BookList+=ISBN[i]+","+number[i]+";";
					}
				}
				
				//修改书籍库信息,BookInfo要改，OrderInfo也要改
// 				修改OrderInfo
				String OrderSql="insert into OrderInfo (BookList,UserName,TotalPrice,OrderDay,Address,Phone) values('"+BookList+"','"+UserName+"',"+TotalPrice+",'"+OrderDay+"','"+Address+"','"+Phone+"')";
				boolean Orderflag=helperClass.SQL_ZSG(OrderSql);
				if(Orderflag){
					
					//如果是修改的订单
					if(null!=request.getParameter("msg")&&
						("updateOrder").equals(""+request.getParameter("msg"))){
						String OrderID=""+request.getParameter("OrderID");
						
						String updateSql="update OrderInfo set CancelOrder=1 where OrderID="+OrderID+"";
						boolean Deflag=helperClass.SQL_ZSG(updateSql);
						if(Deflag){
							out.println("原订单撤销成功！");
						}
						else{
							out.println("原订单撤销失败！");
						}
					}
					
					out.print("新订单信息添加成功！");
					%>
					<a href="Index.jsp">返回首页</a>
					<%
				}
				else{
					out.print("订单信息添加失败！");
					%>
					<a href="javascript:history.back(-1)">重新下单</a>
					<%
				}
				

			}
			else{
				out.print("请正确填写地址和电话号码");
				%>
				<a href="javascript:history.back(-1)">返回修改</a>
				<%
			}
			
		}
		%>
		
		</div>
	</div>
</body>
</html>