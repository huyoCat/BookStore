<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>Insert title here</title>
	
	<link type="text/css" rel="stylesheet" href="left.css"/>
</head>
<body>
	<div id="Left">
<!-- 		通过循环加载图书分类 -->
		
		<table border="3px" align="center" cellspacing="10px">
			<tr><th>书籍类别</th></tr>
		<%
			String sqlBType="select TypeName from BookType";
			List<Map<String, Object>> rsBType=helperClass.SelectSQL(sqlBType);
			if(rsBType.size()==0){
				out.println("数据错误！显示图书类别失败！");
			}
			else{
				for(Map<String, Object> item:rsBType){
					%>
					<tr><td><%=""+item.get("TypeName") %></td></tr>
					<%
				}
				
			}
		%>
			
		</table>
<!-- 		<img id="tag" src="picture/个人中心.png"> -->
<!-- 		<img id="tag" src="picture/购物车.png"> -->
<!-- 		<img id="tag" src="picture/收藏夹.png"> -->
<!-- 		<img id="tag" src="picture/我的订单.png"> -->
	</div>
</body>
</html>