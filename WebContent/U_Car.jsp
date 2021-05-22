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
		
// 		如果是带着移除收藏的值过来的DeleID
			if(null!=request.getParameter("DeleID")&&
			!("".equals(request.getParameter("DeleID").toString()))){
				String DeleID=request.getParameter("DeleID").toString();
				String selectCar="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(selectCar);
				if(StarList.size()==0){
					out.print("移除购物车的查询结果集失败！");
					%>
					<a href="Index.jsp">返回首页</a>
					<%
				}
				else{
					String NowCar=StarList.get(0).get("UserBuyCar").toString();
					String[] strArr=NowCar.split(",");
					String NowInter="";
					for(int i=0;i<strArr.length;i++){
						if(strArr[i].equals(DeleID)){
							continue;
						}
						NowInter+=strArr[i]+",";
					}
					
					if(NowInter.charAt(NowInter.length()-1)==','){
						NowInter=NowInter.substring(0, NowInter.length()-1);
					}
					
					String InserSQL="update UserInfo set UserBuyCar='"+NowInter+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(InserSQL);
					if(flag){
						out.print("移除购物车成功！");
						%>
						<a href="Index.jsp">返回首页</a>
						<%
					}
					else{
						out.print("移除购物车失败！");
						%>
						<a href="U_Car.jsp">点击刷新</a>
						<%
					}
				}
			}
			
// 			如果是带着加入购物车的值过来的
			if(null!=request.getParameter("ID")&&
			!("".equals(request.getParameter("ID").toString()))){
				String BISBN=request.getParameter("ID").toString();
				
				//如果购物车是空的直接加入
				String BeCarSql="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(BeCarSql);
				if(StarList.size()==0){
					out.print("查询购物车结果集失败！");
					%>
					<a href="Index.jsp">返回首页重新尝试</a>
					<%
				}
				else{
					if(null==StarList.get(0).get("UserBuyCar")||//如果购物车为空直接插入
							"".equals(StarList.get(0).get("UserBuyCar").toString())){
						String InsertCar="update UserInfo set UserBuyCar='"+BISBN+"' where UserName='"+UserName+"'";
						boolean flag=helperClass.SQL_ZSG(InsertCar);
						if(flag){
							out.print("加入购物车成功！");
							%>
							<a href="Index.jsp">返回首页</a>
							<%
						}
						else{
							out.print("加入购物车失败！");
							%>
							<a href="Index.jsp">返回首页重新添加</a>
							<%
						}
					}
					else{//不为空，比较之后再插入
						String strCar=StarList.get(0).get("UserBuyCar").toString();
						String[] NowCar=strCar.split(",");
						boolean IsCar=false;
						for(String str:NowCar){
							//如果有相同的显示已收藏
							if(str.equals(BISBN)){
								out.print("购物车里已经有啦");
								%>
								<a href="Index.jsp">返回首页</a>
								<%
								IsCar=true;
								break;
							}
						}
						if(!IsCar){//以前没有加过购物车
							strCar+=","+BISBN;
							String SqlAStar="update UserInfo set UserBuyCar='"+strCar+"' where UserName='"+UserName+"'";
							boolean flagA=helperClass.SQL_ZSG(SqlAStar);
							if(flagA){
								out.print("书籍加入购物车成功");
								%>
								<a href="Index.jsp">返回首页</a>
								<%
							}
							else{
								out.print("书籍添加购物车失败");
								%>
								<a href="Index.jsp">返回首页重新收藏</a>
								<%
							}
						}
					}
				}
			}
		
			//没有任何参数的情况下直接加载购物车
			%>
			<form method="post" action="U_Buy.jsp">
			<table>
			
				<tr>
					<th width="150px">图片</th>
					<th width="200px">详情</th>
					<th width="150px">购买数量</th>
					<th width="150px"><input type="submit" value="全部购买"></th>
				</tr>
				<tr>
					<td colspan="4"><hr width="100%" color="black"></td>
				</tr>
			
				<!-- 				读取数据循环显示 -->
				<%
				String SqlCar="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> rsCar=helperClass.SelectSQL(SqlCar);
				if(rsCar.size()==0){
					out.print("购物车");
					%>
					<a href="U_Car.jsp">点击刷新</a>
					<%
				}
				else{
					if(null==rsCar.get(0).get("UserBuyCar")||
							"".equals(rsCar.get(0).get("UserBuyCar").toString())){
								out.print("购物车内没有任何商品哦");
								%>
								<a href="Index.jsp">返回首页</a>
								<%
					}
					else{
						String strCar=rsCar.get(0).get("UserBuyCar").toString();
						String[] CarArr=strCar.split(",");
						for(String str:CarArr){
							String selectCar="select * from BookInfo where BookISBN='"+str+"'";
							List<Map<String, Object>> rsGetList=helperClass.SelectSQL(selectCar);
							if(rsGetList.size()!=0){
								List<Book> bookList=helperClass.reBook(rsGetList);
								if(bookList.size()!=0){
									Book book=bookList.get(0);
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
										书名：<%=book.getBookName() %>
										作者：<%=book.getBookWriter() %><br>
										出版社：<%=book.getBookPublisher() %><br>
										简介：<%=book.getBookIntro() %><br>
										ISBN：<%=book.getBookISBN() %><br>
										售价：<%=book.getBookSell() %>
										</td>
										
										<td align="center">
											<input type="hidden" value='<%=book.getBookISBN() %>' name="BuyISBN">
											请输入购买数量：<input type="text" name="number" value="1" size="5px">
											
										</td>
										
										<td align="center">
										<a href="U_Car.jsp?DeleID=<%=book.getBookISBN() %>">移除商品</a>
										</td>
									
									</tr>
									<tr>
										<td colspan="4"><hr width="100%" color="black"></td>
									</tr>
									<%
								}
								else{
									out.print("购物车列表转换失败");
									%>
									<a href="Index.jsp">返回首页</a>
									<%
								}
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