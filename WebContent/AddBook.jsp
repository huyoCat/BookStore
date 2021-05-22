<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>添加书籍</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	
 	
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的添加书籍 -->
		<div id="AddBook"><!-- = = method改成post再转码才不会乱码 -->
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
		
			%>
			<form action="AddBook_2.jsp" method="post" id="ABook">
				请输入书籍信息：<br><br>
				书籍名称：<input type="text" name="BookName">&nbsp;&nbsp;
				图书ISBN：<input type="text" name="BookISBN"><br><br>
				图书作者：<input type="text" name="BookWriter">&nbsp;&nbsp;
				出版社：<input type="text" name="BookPublisher"><br><br>
				图书简介：<textarea name="BookIntro"></textarea>&nbsp;&nbsp;
				图书类别：<select name="BookType">
					<%
						String sqlGetType="select TypeName from BookType";
						List<Map<String, Object>> rsGetType=helperClass.SelectSQL(sqlGetType);
						
						//获取下拉列表框数据
						if(rsGetType.size()==0){//如果查询不到数据
							out.println("数据错误！");
						}
						else{//读取数据显示在下拉列表框
							for(Map<String, Object> item:rsGetType){
								String TypeName=""+item.get("TypeName");
								%>
									<option value="<%=TypeName%>"><%=TypeName%></option>
								<%
							}
						}
					%>
				</select><br><br>
				进货价格：<input type="text" name="BookCost">&nbsp;&nbsp;
				出售价格：<input type="text" name="BookSell"><br><br>
				进货日期：<input type="text" name="BookInDay"><!-- 要做格式判断 -->&nbsp;&nbsp;
				商品图片：<input type="file" name="file">
				
				<!-- 获取文件 -->
				<!-- 				库存数量写一个函数自动修改添加 -->
				<br><br>
				输入数目：<input type="text" name="number">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="清空">
			</form>
			
			<%
		}
		%>
		
			
		</div>
	</div>
</body>
</html>