<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�ղؼ�</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
<!-- 		�鿴��¼״̬ -->
		<%
		if(null==session.getAttribute("UserName")
		||("".equals(session.getAttribute("UserName").toString()))){
// 			out.println("���ȵ�¼��վ��");
			%>
			<script type="text/javascript">
				alert('���ȵ�¼��վ��');
			</script>
			<br><a href="Login.jsp">��¼</a><br>
			<a href="Register.jsp">ע��</a>
			<%
		}
		else{//�ѵ�¼
			String UserName=session.getAttribute("UserName").toString();
			
			//����Ǵ���ȡ���ղص�ֵ������,ֱ�Ӳ�ѯ�޸�
			if(null!=request.getParameter("StarID")&&
			!("".equals(request.getParameter("StarID").toString()))){
				String deleStar=request.getParameter("StarID").toString();
				
				String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
				if(StarList.size()==0){
					%>
					<script type="text/javascript">
						alert('ȡ���ղصĲ�ѯ�����ʧ��');
					</script>
					<%
// 					out.print("ȡ���ղصĲ�ѯ�����ʧ�ܣ�");
					%>
					<a href="Index.jsp">������ҳ</a>
					<%
				}
				else{
					String NowStar=StarList.get(0).get("UserStar").toString();
					String[] strArr=NowStar.split(",");
					String NowInter="";
					for(int i=0;i<strArr.length;i++){
						if(strArr[i].equals(deleStar)){
							continue;
						}
						NowInter+=strArr[i]+",";
					}
					if(NowInter.length()>0&&NowInter.charAt(NowInter.length()-1)==','){
						NowInter=NowInter.substring(0, NowInter.length()-1);
					}
					String InserSQL="update UserInfo set UserStar='"+NowInter+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(InserSQL);
					if(flag){
// 						out.print("ȡ���ղسɹ���");
						%>
						<script type="text/javascript">
							alert('ȡ���ղسɹ���');
						</script>
<!-- 						<a href="Index.jsp">ȡ���ղسɹ���������ҳ</a> -->
						<%
					}
					else{
// 						out.print("ȡ���ղ�ʧ�ܣ�");
						%>
						<a href="U_Star.jsp">ȡ���ղ�ʧ�ܣ����ˢ��</a>
						<%
					}
				}
			}
			
			//����Ǵ����ղص�ֵ������
			if(null!=request.getParameter("ID")&&
			!("".equals(request.getParameter("ID").toString()))){
				String StarID=request.getParameter("ID").toString();
				//�鿴�Ƿ����ղ�
				String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
				
				List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
				if(StarList.size()==0){
					%>
					<script type="text/javascript">
						alert('��ѯ�����ʧ�ܣ�');
					</script>
					<%
// 					out.print("��ѯ�����ʧ�ܣ�");
					%>
					<a href="Index.jsp">������ҳ</a>
					<%
				}
				else{
					if(null==StarList.get(0).get("UserStar")||//����ղ�Ϊ��ֱ�Ӳ���
							"".equals(StarList.get(0).get("UserStar").toString())){
// 						String strStar=StarList.get(0).get("UserStar").toString();
						String InserSql="update UserInfo set UserStar='"+StarID+"' where UserName='"+UserName+"'";
						boolean flag=helperClass.SQL_ZSG(InserSql);
						if(flag){
							out.print("�ղسɹ���");
							%>
							<a href="Index.jsp">������ҳ</a>
							<%
// 							response.sendRedirect("U_Star.jsp");
						}
						else{
							out.print("�ղ�ʧ�ܣ�");
							%>
							<a href="Index.jsp">������ҳ�����ղ�</a>
							<%
// 							response.sendRedirect("U_Star.jsp");
						}
					}
					else{//�ղؼв�Ϊ��
						String strStar=StarList.get(0).get("UserStar").toString();
						String[] StarArr=strStar.split(",");
						boolean IsStar=false;
						for(String str:StarArr){
							//�������ͬ����ʾ���ղ�
							if(str.equals(StarID)){
								out.print("�鼮�Ѿ��ղع���");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
								IsStar=true;
								break;
							}
						}
						if(!IsStar){//û���ղ�
							strStar+=","+StarID;
							String SqlAStar="update UserInfo set UserStar='"+strStar+"' where UserName='"+UserName+"'";
							boolean flagA=helperClass.SQL_ZSG(SqlAStar);
							if(flagA){
								out.print("�鼮�ղسɹ�");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
							}
							else{
								out.print("�鼮�ղ�ʧ��");
								%>
								<a href="Index.jsp">������ҳ�����ղ�</a>
								<%
							}
						}
					}
				}
			}
			
			
		%>
			<!-- 			ֱ�ӵ���鿴�ղؼ� -->
		<table >
			<tr>
				<th width="150px">ͼƬ</th>
				<th width="200px">����</th>
				<th width="150px"></th>
			</tr>
			<tr>
				<td colspan="4"><hr width="100%" color="black"></td>
			</tr>
			<%
			
			String SelectStar="select UserStar from UserInfo where UserName='"+UserName+"'";
			List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectStar);
			if(StarList.size()==0){
				out.print("��ѯ�����ʧ�ܣ�");
			}
			else{
				//������ղ��б��ַ���
				if(null==StarList.get(0).get("UserStar")||
				"".equals(StarList.get(0).get("UserStar").toString())){
					out.print("��ǰû���ղ��κ��鼮");
					%>
					<a href="Index.jsp">������ҳ</a>
					<%
				}
				else{
					String StarStr=StarList.get(0).get("UserStar").toString();
					String[] StarArr=StarStr.split(",");
					for(String str:StarArr){
						//���Һ�����ղ��б�
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
										out.print("����ͼƬ");
									}
									else{
									%>
										<img src=<%=book.getBookPic() %> width="150px">
									<%
									}
									%>
									</td>
									
									<td>������<%=book.getBookName() %><br>
										���ߣ�<%=book.getBookWriter() %><br>
										�����磺<%=book.getBookPublisher() %><br>
										��飺<%=book.getBookIntro() %><br>
										ISBN��<%=book.getBookISBN() %><br>
										�ۼۣ�<%=book.getBookSell() %>
									</td>
									
									<td align="center">
									<a href="U_Car.jsp?ID=<%=book.getBookISBN() %>">���빺�ﳵ</a><br>
									<form action="" method="post">
										<a href="U_Star.jsp?StarID=<%=book.getBookISBN() %>">ȡ���ղ�</a>
									</form>
									</td>
									
								</tr>
								<tr>
									<td colspan="4"><hr width="100%" color="black"></td>
								</tr>
								<%
							}
							else{
								out.print("�鼮�б�ת��ʧ��");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
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