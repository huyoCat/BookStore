<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>����鼮���</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Deleting(TypeID){
// 			alert("1");
			var TypeID=TypeID;
			var flag=confirm("ȷ��ɾ���鼮���");
			if(flag){
				window.location.href="A_MaType.jsp?TypeID="+TypeID+"&msg=deleteType";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		<form action="" method="post" id="InsideBar">
			<div>
	<!-- 			�����ʾĿǰӵ�е���� -->
				<select name="limit" id="insideChild">
					<option value="null">ѡ����������</option>
					<option value="TypeName">�������������</option>
					<option value="TypeID">�����������</option>
				</select>
										
				<input type="text" name="search">&nbsp;&nbsp;
				<input type="submit" value="����">
				
			</div>
		</form>
		
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		<%
		if(null==session.getAttribute("UserName")
		||("".equals(session.getAttribute("UserName").toString()))){
			out.println("���ȵ�¼��վ��");
			%>
			<br><a href="Login.jsp">��¼</a><br>
			<a href="Register.jsp">ע��</a>
			<%
		}
		else{//�ѵ�¼
			String UserName=session.getAttribute("UserName").toString();
			String sqlAllType="select * from BookType where 1=1";
		
			//�������������Ϣ
			if(!("null".equals(""+request.getParameter("limit")))){
				if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
					out.print("�����������ؼ���");
				}
				else{
					String limit=request.getParameter("limit").toString();
					String search=request.getParameter("search").toString();
					sqlAllType+=" and "+limit+" like '%'+'"+search+"'+'%'";
				}
				
			}
			
// 			��������޸Ļ���ɾ������Ϣ
			if(null!=request.getParameter("msg")&&!("".equals(request.getParameter("msg")))){
				String TypeID=request.getParameter("TypeID").toString();
				if("deleteType".equals(request.getParameter("msg").toString())){//ɾ������
					//�ж����ݿ����Ƿ��и������鼮��û�в�ɾ���ɹ�
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
							out.print("ɾ���ɹ���");
						}
						else{
							out.print("ɾ��ʧ�ܣ�");
						}
					}
					else{
						out.print("���ݿ��ڻ��и������鼮�����޸��鼮��Ϣ��ɾ����");
					}
				
				}
			}
			
// 			����������������Ϣ
			if(null!=request.getParameter("AddTypeName")&&
				!("".equals(request.getParameter("AddTypeName")))){
				String AddType=request.getParameter("AddTypeName").toString();
				//�����Ƿ�����
				String sql="select TypeName from BookType where TypeName='"+AddType+"'";
				boolean beFlag=helperClass.IsReName(sql);
				if(!beFlag){
					String insert="insert into BookType (TypeName) values('"+AddType+"')";
					boolean flag=helperClass.SQL_ZSG(insert);
					if(flag){
						out.print("�鼮�����ӳɹ���");
					}
					else{
						out.print("�鼮������ʧ�ܣ�");
					}
				}
				else{
					out.print("��Ҫ��ӵ�����Ѵ��ڣ�");
				}
			}
		
			%>

			<form method="post">
				
				<div id="addTypeLeft">
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="70px">�����</th>
							<th width="150px">�������</th>
							<th width="70px"></th>
						</tr>
						<%
						List<Map<String, Object>> TypeList=helperClass.SelectSQL(sqlAllType);
						if(TypeList.size()==0){
							out.print("����б�Ϊ�� �� �������ѯʧ��");
						}
						else{
							for(Map<String, Object> map:TypeList){
								%>
								<tr>
									<td align="center"><%=map.get("TypeID") %></td>
									<td align="center"><%=map.get("TypeName") %></td>
									<td align="center"><a href="#" onClick="Deleting(<%=map.get("TypeID") %>)">ɾ��</a><br>
										<a href="A_MaType2.jsp?msg=updateType&TypeID=<%=map.get("TypeID") %>">�޸�</a>
									</td>
								</tr>
								<%
							}
						}
						%>
						
					</table>
				</div>
				
				<div id="addTypeRight">
					��������Ҫ��ӵ�������ƣ�<br>
					<input type="text" name="AddTypeName">
					<input type="submit" value="���">
				</div>
			
			</form>
			
			
			<%
		
		}
		%>
		
		
		</div>
	</div>
	
</body>
</html>