<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改书籍结果反馈</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
<!-- 		接收修改数据 -->
		<%		
				String BeISBN=request.getParameter("BeISBN");
				String number1=request.getParameter("BookCount");
				String BookName=request.getParameter("BookName");
				String BookISBN=request.getParameter("BookISBN");
				String BookWriter=request.getParameter("BookWriter");
				String BookPublisher=request.getParameter("BookPublisher");
				String BookIntro=request.getParameter("BookIntro");
				String Sell=request.getParameter("BookSell");
				//获取下拉列表框，存在乱码，中文要做转码
				String BookType=request.getParameter("BookType");
				
// 				判断有没有更改图片BePic
				String PicPath="";
				if(null==request.getParameter("file")||"".equals(""+request.getParameter("file"))){//没改
					PicPath=request.getParameter("BePic");
				}
				else{
					PicPath="picture/"+request.getParameter("file");
				}
				//判断价钱是否是数字
				double BookSell=0;
				int BookCount=0;
				try{
					BookSell=Double.parseDouble(Sell);
					BookCount=Integer.parseInt(number1);
				}
				catch(Exception e){
					out.println("请确认商品价格或书籍数目填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				if(null==BookName||"".equals(BookName)||null==BookISBN||"".equals(BookISBN)||
						null==BookWriter||"".equals(BookWriter)||
						null==BookPublisher||"".equals(BookPublisher)||
						null==BookIntro||"".equals(BookIntro)){
// 					if()
					out.println("请确认信息填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				
				String UpdateSql="update BookInfo set BookName='"+BookName+"',BookISBN='"+BookISBN+"',BookWriter='"+BookWriter+"',BookPublisher='"+BookPublisher+"',BookIntro='"+BookIntro+"',BookType='"+BookType+"',BookSell="+BookSell+",BookCount="+BookCount+",BookPic='"+PicPath+"' where BookISBN='"+BeISBN+"'";
				boolean flagUpdate=helperClass.SQL_ZSG(UpdateSql);
				if(flagUpdate){
					out.println("书籍信息修改成功！");
					%>
					<a href="Index.jsp">返回首页</a>
					<% 
				}
				else{
					out.println("书籍信息修改失败！");
					%>
					<a href="javascript:history.back(-1)">重新尝试</a>
					<% 
				}
		
		%>
		
		</div>
	</div>

</body>
</html>