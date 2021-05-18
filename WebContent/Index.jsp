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
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		
<!-- 					��ʾ�б� -->
			<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th width="150px">ͼƬ</th>
							<th width="200px">����</th>
							<th width="400px">����</th>
							<th width="200px"></th>
						</tr>
<!-- 					�������ݿ��ȡ���� ��������ѭ����ʾ-->
						<%
							String sql2="select * from BookInfo";
							List<Map<String, Object>> rsList=helperClass.SelectSQL(sql2);
							
							if(rsList.size()==0){//�����ѯ��������
								out.println("���ݴ���");
							}
							else{
								List<Book> bookList=helperClass.reBook(rsList);
								if(bookList.size()==0){//�����ѯ��������
									out.println("���ݴ���");
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
												<td><%=book.getBookName() %></td>
												<td>���ߣ�<%=book.getBookWriter() %><br>
													�����磺<%=book.getBookPublisher() %><br>
													��飺<%=book.getBookIntro() %><br>
													ISBN��<%=book.getBookISBN() %><br>
													ͼ�����<%=book.getBookType() %><br>
													�ۼۣ�<%=book.getBookSell() %>
												</td>
												<td>
<!-- 													<form action=""> -->
													<input type="hidden" name="ID" value="<%=book.getBookISBN() %>">
													<a href="U_Car.jsp?ID=<%=book.getBookISBN() %>">���빺�ﳵ</a>
<!-- 													�����������ղز���Ҫ��ת��������һ������ʾ�ղسɹ� -->
													<form method="post">
														<a href="U_Star.jsp?ID=<%=book.getBookISBN() %>">�ղ�</a>
													</form>
<!-- 														<input type="submit" value="�ղ�" name="star"><br> -->
<!-- 														<input type="submit" value="���빺�ﳵ" name="add"><br> -->
<!-- 														<input type="submit" value="��������" name="buy"> -->
<!-- 													</form> -->
												</td>
											</tr>
										<%
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