<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>��ζ����</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
<!-- 	<script src="myJs.js"> -->

<!-- 	</script> -->
</head>
<body>
		<!-- 	��ҳͷͼ  ���Ͻ� ��¼or ע�� -->
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		
		<form method="post">
				<!-- 		������ -->
			<div id="InsideBar">
				<select name="limit" id="insideChild">
					<option value="null">ѡ����������</option>
					<option value="BookISBN">���鼮�������</option>
					<option value="BookName">���鼮��������</option>
					<option value="BookType">���鼮�������</option>
					<option value="BookWriter">���鼮��������</option>
				</select>
					
				<input type="text" name="search">&nbsp;&nbsp;
				<input type="submit" value="����">
			
			</div>
			</form>
			
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
			
		<%
		String sql2="select * from BookInfo where 1=1";
		
		//�����������������
		if(!("null".equals(""+request.getParameter("limit")))){
			//�������������ֵ
			if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
// 				out.print("alert('�����������ؼ���')");
				%>
				<script type="text/javascript">
					alert('�����������ؼ���');
				</script>
				<%
			}
			else{
				String limit=request.getParameter("limit").toString();
				String search=request.getParameter("search").toString();
				sql2+=" and "+limit+" like '%'+'"+search+"'+'%'";
			}
			
		}
		
		%>
		
		<form method="post">
		
<!-- 					��ʾ�б� -->
			<div id="top">
			<table>
						<tr>
							<th width="150px">ͼƬ</th>
							<th width="200px">����</th>
							<th width="400px">����</th>
							<%
							if(null==session.getAttribute("iden")||!("iden".equals(""+session.getAttribute("iden")))){
								%>
								<th width="200px"></th>
								<%
							}
							%>
						</tr>
						<tr>
							<td colspan="4"><hr width="100%" color="black"></td>
						</tr>
<!-- 					�������ݿ��ȡ���� ��������ѭ����ʾ-->
						<%
							
							List<Map<String, Object>> rsList=helperClass.SelectSQL(sql2);
							
							if(rsList.size()==0){//�����ѯ��������
// 								out.println("�޽�� �� ���ݴ���");
								%>
								<script type="text/javascript">
									alert('�޽�� �� ���ݴ���');
								</script>
								<%
							}
							else{
								List<Book> bookList=helperClass.reBook(rsList);
								if(bookList.size()==0){//�����ѯ��������
// 									out.println("ͼ���б�ת��ʧ�ܣ�");
									%>
									<script type="text/javascript">
										alert('ͼ���б�ת��ʧ�ܣ�');
									</script>
									<%
								}
								else{
									Set<String> ISBNSet=new TreeSet<>();
									for(Book book:bookList){
										//������Լӽ��б�˵��û���ظ����������б���ʾ
										if(ISBNSet.add(book.getBookISBN())){
											%>
											<tr>
												<td><%
												if(book.getBookPic().equals("picture/")){
													out.print("����ͼƬ");
												}
												else{
													%>
													<img src=<%=book.getBookPic() %> width="150px">
													<%
												}
												%></td>
												<td align="center"><%=book.getBookName() %></td>
												<td>���ߣ�<%=book.getBookWriter() %><br>
													�����磺<%=book.getBookPublisher() %><br>
													��飺<%=book.getBookIntro() %><br>
													ISBN��<%=book.getBookISBN() %><br>
													ͼ�����<%=book.getBookType() %><br>
													�ۼۣ�<%=book.getBookSell() %>
													
													<%
													if(null!=session.getAttribute("iden")){
														%>
														<br>���������<%=book.getBookCount() %>
														<%
													}
													%>
												</td>
												<%
												if(null==session.getAttribute("iden")||!("iden".equals(""+session.getAttribute("iden")))){
													%>
													<td align="center">
														<input type="hidden" name="ID" value="<%=book.getBookISBN() %>">
														<a href="U_Star.jsp?ID=<%=book.getBookISBN() %>">�ղ�</a><br><br>
														<a href="U_Car.jsp?ID=<%=book.getBookISBN() %>">���빺�ﳵ</a>
														
													</td>
													<%
												}
												%>
											</tr>
											<tr>
												<td colspan="4"><hr width="100%" color="black"></td>
											</tr>
										<%
										}
									}
								}
							}
						%>
					</table></div></form>
		</div>
	</div>
	
</body>
</html>