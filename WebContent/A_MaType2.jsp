<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸�ͼ�����</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		
<!-- 		�Ƚ�BookInfo���ԭ��������ȸ��ĳ����ڵ����Ȼ���޸�BookType -->
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
						�޸�Ϊ��<input type="text" name="nowName">
						<input type="submit" value="ȷ��">
					</form>
				</div>
				
				<%
				if(null!=request.getParameter("nowName")&&
						!("".equals(request.getParameter("nowName")))){
					String nowName=""+request.getParameter("nowName");
					String BeTypeName=""+request.getParameter("BeTypeName");
// 					�ȼ���Ƿ�����
					String reNameSql="select TypeName from BookType where TypeName='"+nowName+"'";
					if(!helperClass.IsReName(reNameSql)){
						//û�������޸�BookInfo
						String upda="update BookInfo set BookType='"+nowName+"' where BookType='"+BeTypeName+"'";
						boolean flagUp=helperClass.SQL_ZSG(upda);
						if(flagUp){
							//�鼮��Ϣ�޸ĳɹ�������ʵʩ���������޸�
							String upSql="update BookType set TypeName='"+nowName+"' where TypeID='"+TypeID+"'";
							boolean upTy=helperClass.SQL_ZSG(upSql);
							if(upTy){
								response.sendRedirect("A_MaType.jsp");
							}
							else{
								out.print("�鼮����޸�ʧ��");
							}
						}
						else{
							out.print("�鼮��Ϣ�޸�ʧ��");
						}
					
					}
					else{
						out.print("�޸ĺ���鼮�������Ѿ�������");
					}
				}
				
			}
		%>
		</div>
	</div>

</body>
</html>