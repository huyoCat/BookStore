<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>修改图书类别</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	左边 -->
		<%@ include file="Left.jsp"%>
<!-- 	中间的图书列表 -->
		<div id="bookTable">
		
<!-- 		先将BookInfo里的原本的类别先更改成现在的类别，然后修改BookType -->
		<%
			if(null!=request.getParameter("msg")&&
				!("".equals(request.getParameter("msg")))&&
				"updateType".equals(request.getParameter("msg"))){
				String TypeID=""+request.getParameter("TypeID");
				
				String getName="select TypeName from BookType where TypeID="+TypeID+"";
				List<Map<String, Object>> List=helperClass.SelectSQL(getName);
				
				String TypeName="";
				if(List.size()!=0){
					TypeName=""+List.get(0).get("TypeName");
				}
				%>
				<div id="person">
					<form method="post">
						<input type="hidden" name="BeTypeName" value="<%=TypeName %>">
						修改为：<input type="text" name="nowName">
						<input type="submit" value="确定">
					</form>
				</div>
				
				<%
				if(null!=request.getParameter("nowName")&&
						!("".equals(request.getParameter("nowName")))){
					String nowName=""+request.getParameter("nowName");
					String BeTypeName=""+request.getParameter("BeTypeName");
// 					先检测是否重名
					String reNameSql="select TypeName from BookType where TypeName='"+nowName+"'";
					if(!helperClass.IsReName(reNameSql)){
						//没有重名修改BookInfo
						String upda="update BookInfo set BookType='"+nowName+"' where BookType='"+BeTypeName+"'";
						boolean flagUp=helperClass.SQL_ZSG(upda);
						if(flagUp){
							//书籍信息修改成功，真正实施类型名的修改
							String upSql="update BookType set TypeName='"+nowName+"' where TypeID='"+TypeID+"'";
							boolean upTy=helperClass.SQL_ZSG(upSql);
							if(upTy){
								response.sendRedirect("A_MaType.jsp");
							}
							else{
								out.print("书籍类别修改失败");
							}
						}
						else{
							out.print("书籍信息修改失败");
						}
					
					}
					else{
						out.print("修改后的书籍类型名已经存在啦");
					}
				}
				
			}
		%>
		</div>
	</div>

</body>
</html>