<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>添加书籍处理结果</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>

	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
		
		<div id="AddBook">
			<%
				//获取数据
				
				String number1=request.getParameter("number");
				String BookName=request.getParameter("BookName");
// 				out.println(helperClass.zhuanma(BookName));
				String BookISBN=request.getParameter("BookISBN");
// 				out.println(BookISBN);
				String BookWriter=request.getParameter("BookWriter");
// 				out.println(helperClass.zhuanma(BookWriter));
				String BookPublisher=request.getParameter("BookPublisher");
// 				out.println(helperClass.zhuanma(BookPublisher));
				String BookIntro=request.getParameter("BookIntro");
// 				out.println(helperClass.zhuanma(BookIntro));

				String Cost=request.getParameter("BookCost");
// 				out.println(BookCost);
				String Sell=request.getParameter("BookSell");
// 				out.println(BookSell);
				String BookInDay=request.getParameter("BookInDay");
// 				out.println(BookInDay);
				//获取下拉列表框，存在乱码，中文要做转码
				String BookType=request.getParameter("BookType");
				
				String PicPath="picture/"+request.getParameter("file");
// 				String PicPath=request.getServletPath("file");//这个是获取本jsp文件的相对路径
// 				out.println(helperClass.zhuanma(PicPath));
// 				out.println(helperClass.zhuanma(BookType));
				//验证取值
				//判断价钱是否是数字
				double BookCost=0;
				double BookSell=0;
				int number=0;
				try{
					BookCost=Double.parseDouble(Cost);
					BookSell=Double.parseDouble(Sell);
					number=Integer.parseInt(number1);
				}
				catch(Exception e){
					out.println("请确认商品价格或书籍数目填写正确！");
					%>
					<a href="javascript:history.back(-1)">返回重填</a>
					<% 
					return;
				}
				if(!helperClass.isDate(BookInDay)){
					out.println("请确认进货日期填写正确！");
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
				
				//查询有没有一样的ISBN，再存入   逻辑不对，可以插入，可以加一个一共多少本循环插入
				
				//存入数据
				
				String Addsql="insert into BookInfo (BookName,BookISBN,BookWriter,BookPublisher,BookIntro,BookCost,BookSell,BookInDay,BookType,BookPic) "+
					"values('"+BookName+"','"+BookISBN+"','"+BookWriter+"','"+BookPublisher+"','"+BookIntro+"',"+BookCost+","+BookSell+",'"+BookInDay+"','"+BookType+"','"+PicPath+"')";
// 				ResultSet rInser=stmt.executeQuery(Addsql);
				int count=0;//记录次数
				boolean flag=true;
				for(int i=0;i<number;i++){
					flag=helperClass.SQL_ZSG(Addsql);
					count++;
					if(!flag){
						break;
					}
				}
				if(flag&&count==number){
					out.println("书籍添加成功！");
					%>
					<a href="AddBook.jsp">继续添加</a>
					<% 
				}
				else{
					out.println("书籍添加失败！添加了"+count+"本");
					%>
					<a href="javascript:history.back(-1)">重新添加</a>
					<% 
				}
			%>
		
		</div>
	</div>
</body>
</html>