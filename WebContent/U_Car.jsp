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
		<form action="U_buy.jsp" method="post">
			<table>
				<tr>
					<th width="150px">ͼƬ</th>
					<th width="400px">��Ϣ</th>
					<th width="150px">��������</th>
					<th width="150px"><input type="button" value="ȫ������"></th>
				</tr>
				<%
				String ISBN=request.getParameter("ID");
				if("".equals(ISBN)||ISBN!=null){
						ISBN=helperClass.zhuanma(ISBN);
					String sql="select * from BookInfo where BookISBN='"+ISBN+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					if(rs==null){
						out.println("���빺�ﳵ����");
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
									<td><img src="<%=book.getBookPic() %>" width="150px"></td>
									<td>������<%=book.getBookName() %><br>
										���ߣ�<%=book.getBookWriter() %><br>
										�����磺<%=book.getBookPublisher() %><br>
										��飺<%=book.getBookIntro() %><br>
										ISBN��<%=book.getBookISBN() %><br>
										�ۼۣ�<%=book.getBookSell() %>
									</td>
									<td><input type="text" name="number"></td>
									<td><a href="delete.jsp?ISBN=<%=book.getBookISBN() %>">�Ƴ���Ʒ</a></td>
								</tr>	
							<%
							}
						}
					}
				}
			%>
			</table>
			</form>
			<%
			//��ISBN��������ӽ��б���
			List<String> buyList=new ArrayList<>();
// 			for()
				
			%>
		</div>
		
	</div>
</body>
</html>