<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>���ﳵ</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м�Ĺ��ﳵ�б� -->
		<div id="bookTable">
		<%
		if(null==session.getAttribute("UserName")
		||("".equals(session.getAttribute("UserName").toString()))){
			out.println("���ȵ�¼��վ��");
		}
		else{
			%>
			<form action="U_buy.jsp" method="post">
				<table border="3">
					<tr>
						<th width="150px">ͼƬ</th>
						<th width="400px">��Ϣ</th>
						<th width="150px">��������</th>
						<th width="150px"><input type="button" value="ȫ������"></th>
					</tr>
					<%
					String ISBN=request.getParameter("ID");
//	 				out.println(ISBN);
					if(!("".equals(ISBN))&&ISBN!=null){
						ISBN=helperClass.zhuanma(ISBN);
						String sqlCar="select * from BookInfo where BookISBN='"+ISBN+"'";
						List<Map<String, Object>> rsCar=helperClass.SelectSQL(sqlCar);
						if(rsCar.size()==0){
							out.println("���빺�ﳵ����");
						}
						else{
							List<Book> bookList=helperClass.reBook(rsCar);
							if(bookList.size()==0){//�����ѯ��������
								out.println("���ݴ���");
							}
							else{
								for(Book book:bookList){
								%>
									<tr>
										<td><img src="<%=book.getBookPic() %>" width="150px"></td>
										<td>������<%=book.getBookName() %><br>
											���ߣ�<%=book.getBookWriter() %><br>
											�����磺<%=book.getBookPublisher() %><br>
											��飺<%=book.getBookIntro() %><br>
											ISBN��<%=book.getBookISBN() %><br>
											�ۼۣ�<%=book.getBookSell() %>
										</td>
										<td>�����빺��������<input type="text" name="number"></td>
										<td><a href="delete.jsp?ISBN=<%=book.getBookISBN() %>">�Ƴ���Ʒ</a></td>
									</tr>	
								<%
								}
							}
						}
					}
					else{
						out.println("��ȡISBNʧ�ܣ�");
					}
				%>
				</table>
				</form>
				<%
		}
		
			//��ISBN��������ӽ��б���
			List<String> buyList=new ArrayList<>();
// 			for()
				
			%>
		</div>
		
	</div>
</body>
</html>