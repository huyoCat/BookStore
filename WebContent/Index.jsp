<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��ζ����</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
<!-- 	hello world!<br> -->
		<!-- 	��ҳͷͼ  ���Ͻ� ��¼or ע�� -->
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		
			<%
			//���û�е�¼��Ϣ����ʾԭʼҳ�棬����У����Ͻ���ʾ�û���
			//��ȡ��Ϣ
				String userName=request.getParameter("userName");
// 				out.println(helperClass.zhuanma(userName));
				String password=request.getParameter("password");
// 				out.println(helperClass.zhuanma(password));
				//û�е�¼��Ϣ
				if("".equals(userName)||userName==null){
					%>
<!-- 					��ʾ�б� -->
				
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="150px">ͼƬ</th>
							<th width="200px">����</th>
							<th width="400px">����</th>
							<th width="200px">�۸�</th>
						</tr>
<!-- 					�������ݿ��ȡ���� ��������ѭ����ʾ-->
						<%
							String sql="select * from BookInfo";
							List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
							
							if(null==rs){//�����ѯ��������
								out.println("���ݴ���");
							}
							else{
								List<Book> bookList=helperClass.reBook(rs);
								if(null==bookList){//�����ѯ��������
									out.println("���ݴ���");
								}
								else{
									for(Book book:bookList){
										%>
											<tr>
												<td><img src=<%=book.getBookPic() %> width="150px"></td>
												<td><%=book.getBookName() %></td>
												<td>���ߣ�<%=book.getBookWriter() %><br>
													�����磺<%=book.getBookPublisher() %><br>
													��飺<%=book.getBookIntro() %><br>
													ISBN��<%=book.getBookISBN() %>
												</td>
												<td><%=book.getBookSell() %></td>
											</tr>
										<%
									}
								}
							}
						%>
					</table>
					<% 
				}
				//�������ݿ��ȡ��¼����    ���û�е�¼��Ϣ���Ķ���Ҳ�ò���
				else{//�Ƚ�������Ϣ
					String sql="select * from UserInfo where UserName='"+userName+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					
					if(null==rs){//�����ѯ��������
						out.println("���û������ڣ�");
						%>
						<a href="Login.jsp">���µ�¼</a>
						<%
					}
					else{//����Ҫ�������û����ǹ���Ա
						for(Map<String, Object> item:rs){
							if(password.equals(""+item.get("UserPwd"))){
								out.println("��ӭ��¼��"+userName+"��");
							}
							else{
								out.println("��������������������롣");
								%>
								<a href="javascript:history.back(-1)">���µ�¼</a>
								<%
							}
						}
						
						
					}
				}
			%>
		
			
		</div>
	</div>
	
</body>
</html>