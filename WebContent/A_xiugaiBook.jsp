<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改书籍信息</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
		
<!-- 		只有接受了修改信息才会打开页面 -->
			<form method="post" action="A_xiugai2.jsp">
			<%
// 		接收需要修改的ISBN
			if(null!=request.getParameter("ISBN")){
				String BookISBN=""+request.getParameter("ISBN");
				
				String sqlXiugai="select * from BookInfo where BookISBN='"+BookISBN+"'";
				List<Map<String, Object>> rsXiuGai=helperClass.SelectSQL(sqlXiugai);
				
				if(rsXiuGai.size()==0){//如果查询不到数据
					out.println("书籍信息查询失败！");
				}
				else{
					List<Book> bookList=helperClass.reBook(rsXiuGai);
					if(bookList.size()==0){//如果查询不到数据
						out.println("书籍信息转换失败！");
					}
					else{
						Book book=bookList.get(0);
						%>
						<div id="updateBook">
<!-- 						最开始的ISBN也存起来传过去 -->
							<input type="hidden" name="BeISBN" value="<%=BookISBN %>">
							书籍编号：<input type="text" name="BookISBN" value="<%=book.getBookISBN() %>">
							书籍名称：<input type="text" name="BookName" value="<%=book.getBookName() %>">
							书籍作者：<input type="text" name="BookWriter" value="<%=book.getBookWriter() %>">
							书籍类别：<select name="BookType">
										<%
										String typeSql="select TypeName from BookType";
										List<Map<String, Object>> rsType=helperClass.SelectSQL(typeSql);
										for(Map<String, Object> item:rsType){
											String TypeName=""+item.get("TypeName");
											%>
											<option value="<%=TypeName%>"><%=TypeName%></option>
											<%
											}
											%>
								</select><br>
							出版社：<input type="text" name="BookPublisher" value="<%=book.getBookPublisher() %>">
							
							书籍售价：<input type="text" name="BookSell" value="<%=book.getBookSell() %>">
							库存数量：<input type="text" name="BookCount" value="<%=book.getBookCount() %>"><br>
							
							书籍简介：<textarea name="BookIntro" cols="50" rows="10"><%=book.getBookIntro() %></textarea>
<!-- 							<textarea rows="" cols=""></textarea> -->
							
								书籍图片：<%
									if(book.getBookPic().equals("picture/")){
									out.print("暂无图片");
									}
									else{
									%>
									<img src=<%=book.getBookPic() %> width="150px">
									<%
									}
									%>
									<input type="hidden" name="BePic" value="<%=book.getBookPic() %>">
							<input type="file" name="file" value="<%=book.getBookPic() %>"><br>
							
					
							
							<input type="submit" value="确认修改">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="清空">
						</div>
						
						<%
						
					}
					
				}
			}
			
			%>
			
			</form>
		
		</div>
	</div>

</body>
</html>