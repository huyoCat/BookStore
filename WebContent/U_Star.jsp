<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>收藏夹</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
<!-- 		查看登录状态 -->
		<%
		if(null==session.getAttribute("UserName")
		||("".equals(session.getAttribute("UserName").toString()))){
			out.println("请先登录网站！");
		}
		else{//已登录
			String UserName=session.getAttribute("UserName").toString();
			
			//如果是带着取消收藏的值过来的,直接查询修改
			if(null!=request.getParameter("StarID")&&
			!("".equals(request.getParameter("StarID").toString()))){
				String deleStar=request.getParameter("StarID").toString();
				
				String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
				if(StarList.size()==0){
					out.print("取消收藏的查询结果集失败！");
				}
				else{
					String NowStar=StarList.get(0).get("UserStar").toString();
					String[] strArr=NowStar.split(",");
					String NowInter="";
					for(String str:strArr){
						if(str.equals(deleStar)){
							continue;
						}
						NowInter+=","+str;
					}
					String InserSQL="update UserInfo set UserStar='"+NowInter+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(InserSQL);
					if(flag){
						out.print("取消收藏成功！");
					}
					else{
						out.print("取消收藏失败！");
					}
				}
			}
			
			//如果是带着收藏的值过来的
			if(null!=request.getParameter("ID")&&
			!("".equals(request.getParameter("ID").toString()))){
				String StarID=request.getParameter("ID").toString();
				//查看是否已收藏
				String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
				
				List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
				if(StarList.size()==0){
					out.print("查询结果集失败！");
				}
				else{
					if(null==StarList.get(0).get("UserStar")||//如果收藏为空直接插入
							"".equals(StarList.get(0).get("UserStar").toString())){
// 						String strStar=StarList.get(0).get("UserStar").toString();
						String InserSql="update UserInfo set UserStar='"+StarID+"' where UserName='"+UserName+"'";
						boolean flag=helperClass.SQL_ZSG(InserSql);
						if(flag){
							out.print("收藏成功！");
// 							response.sendRedirect("U_Star.jsp");
						}
						else{
							out.print("收藏失败！");
// 							response.sendRedirect("U_Star.jsp");
						}
					}
					else{//收藏夹不为空
						String strStar=StarList.get(0).get("UserStar").toString();
						String[] StarArr=strStar.split(",");
						boolean IsStar=false;
						for(String str:StarArr){
							//如果有相同的显示已收藏
							if(str.equals(StarID)){
								out.print("书籍已经收藏过啦");
								IsStar=true;
								break;
							}
						}
						if(!IsStar){//没有收藏
							strStar+=","+StarID;
							String SqlAStar="update UserInfo set UserStar='"+strStar+"' where UserName='"+UserName+"'";
							boolean flagA=helperClass.SQL_ZSG(SqlAStar);
							if(flagA){
								out.print("书籍收藏成功");
							}
							else{
								out.print("书籍收藏失败");
							}
						}
					}
				}
			}
			
			
		%>
			<!-- 			直接点击查看收藏夹 -->
		<table border="3px" align="center" cellspacing="10px">
			<tr>
				<th width="150px">图片</th>
				<th width="200px">详情</th>
				<th width="150px"></th>
			</tr>
			<%
			
			String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
			List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
			if(StarList.size()==0){
				out.print("查询结果集失败！");
			}
			else{
				//保存的收藏列表字符串
				if(null==StarList.get(0).get("UserStar")||
				"".equals(StarList.get(0).get("UserStar").toString())){
					out.print("当前没有收藏任何书籍");
				}
				else{
					String StarStr=StarList.get(0).get("UserStar").toString();
					String[] StarArr=StarStr.split(",");
					for(String str:StarArr){
						//查找和输出收藏列表
						String SeleStarSql="select * from BookInfo where BookISBN='"+str+"'";
						List<Map<String, Object>> rsGetList=helperClass.SelectSQL(SeleStarSql);
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
									
									<td>作者：<%=book.getBookWriter() %><br>
										出版社：<%=book.getBookPublisher() %><br>
										简介：<%=book.getBookIntro() %><br>
										ISBN：<%=book.getBookISBN() %><br>
										售价：<%=book.getBookSell() %>
									</td>
									
									<td>
									<a>加入购物车</a><br>
									<form action="" method="post">
										<a href="U_Star.jsp?StarID=<%=book.getBookISBN() %>">取消收藏</a>
									</form>
									</td>
									
								</tr>
								<%
							}
							else{
								out.print("书籍列表转换失败");
							}
						}
					}
				}
			}
		}	
			%>
		</table>
		
		</div>
	</div>
</body>
</html>