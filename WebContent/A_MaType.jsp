<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>添加书籍类别</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Deleting(TypeID){
// 			alert("1");
			var TypeID=TypeID;
			var flag=confirm("确认删除书籍类别？");
			if(flag){
				window.location.href="A_MaType.jsp?TypeID="+TypeID+"&msg=deleteType";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
		<form action="" method="post" id="InsideBar">
			<div>
	<!-- 			左边显示目前拥有的类别 -->
				<select name="limit" id="insideChild">
					<option value="null">选择搜索条件</option>
					<option value="TypeName">按类别名称搜索</option>
					<option value="TypeID">按类别编号搜索</option>
				</select>
										
				<input type="text" name="search">&nbsp;&nbsp;
				<input type="submit" value="搜索">
				
			</div>
		</form>
		
<!-- 	中间的图书列表 -->
		<div id="bookTable">
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
			String sqlAllType="select * from BookType where 1=1";
		
			//如果带着搜索信息
			if(!("null".equals(""+request.getParameter("limit")))){
				if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
					out.print("请输入搜索关键词");
				}
				else{
					String limit=request.getParameter("limit").toString();
					String search=request.getParameter("search").toString();
					sqlAllType+=" and "+limit+" like '%'+'"+search+"'+'%'";
				}
				
			}
			
// 			如果带着修改或者删除的信息
			if(null!=request.getParameter("msg")&&!("".equals(request.getParameter("msg")))){
				String TypeID=request.getParameter("TypeID").toString();
				if("deleteType".equals(request.getParameter("msg").toString())){//删除请求
					//判断数据库中是否还有该类别的书籍，没有才删除成功
					String sqlBe="select TypeName from BookType where TypeID="+TypeID+"";
					List<Map<String, Object>> List=helperClass.SelectSQL(sqlBe);
					String TypeName="";
					if(List.size()!=0){
						TypeName=""+List.get(0).get("TypeName");
					}
					String sqlTy="select BookType from BookInfo where BookType='"+TypeName+"'";
					List<Map<String, Object>> StarList=helperClass.Not_Select(sqlTy);
					if(StarList.size()==0){
						String dele="delete from BookType where TypeName='"+TypeName+"'";
						boolean flag=helperClass.Not_ZSG(dele);
						if(flag){
							out.print("删除成功！");
						}
						else{
							out.print("删除失败！");
						}
					}
					else{
						out.print("数据库内还有该类别的书籍，请修改书籍信息后删除！");
					}
				
				}
			}
			
// 			如果带着添加类别的信息
			if(null!=request.getParameter("AddTypeName")&&
				!("".equals(request.getParameter("AddTypeName")))){
				String AddType=request.getParameter("AddTypeName").toString();
				//搜索是否重名
				String sql="select TypeName from BookType where TypeName='"+AddType+"'";
				boolean beFlag=helperClass.IsReName(sql);
				if(!beFlag){
					String insert="insert into BookType (TypeName) values('"+AddType+"')";
					boolean flag=helperClass.SQL_ZSG(insert);
					if(flag){
						out.print("书籍类别添加成功！");
					}
					else{
						out.print("书籍类别添加失败！");
					}
				}
				else{
					out.print("您要添加的类别已存在！");
				}
			}
		
			%>

			<form method="post">
				
				<div id="addTypeLeft">
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="70px">类别编号</th>
							<th width="150px">类别名称</th>
							<th width="70px"></th>
						</tr>
						<%
						List<Map<String, Object>> TypeList=helperClass.SelectSQL(sqlAllType);
						if(TypeList.size()==0){
							out.print("类别列表为空 或 结果集查询失败");
						}
						else{
							for(Map<String, Object> map:TypeList){
								%>
								<tr>
									<td align="center"><%=map.get("TypeID") %></td>
									<td align="center"><%=map.get("TypeName") %></td>
									<td align="center"><a href="#" onClick="Deleting(<%=map.get("TypeID") %>)">删除</a><br>
										<a href="A_MaType2.jsp?msg=updateType&TypeID=<%=map.get("TypeID") %>">修改</a>
									</td>
								</tr>
								<%
							}
						}
						%>
						
					</table>
				</div>
				
				<div id="addTypeRight">
					请输入需要添加的类别名称：<br>
					<input type="text" name="AddTypeName">
					<input type="submit" value="添加">
				</div>
			
			</form>
			
			
			<%
		
		}
		%>
		
		
		</div>
	</div>
	
</body>
</html>