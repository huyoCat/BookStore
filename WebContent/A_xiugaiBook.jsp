<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸��鼮��Ϣ</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		
<!-- 		ֻ�н������޸���Ϣ�Ż��ҳ�� -->
			<form method="post" action="A_xiugai2.jsp">
			<%
// 		������Ҫ�޸ĵ�ISBN
			if(null!=request.getParameter("ISBN")){
				String BookISBN=""+request.getParameter("ISBN");
				
				String sqlXiugai="select * from BookInfo where BookISBN='"+BookISBN+"'";
				List<Map<String, Object>> rsXiuGai=helperClass.SelectSQL(sqlXiugai);
				
				if(rsXiuGai.size()==0){//�����ѯ��������
					out.println("�鼮��Ϣ��ѯʧ�ܣ�");
				}
				else{
					List<Book> bookList=helperClass.reBook(rsXiuGai);
					if(bookList.size()==0){//�����ѯ��������
						out.println("�鼮��Ϣת��ʧ�ܣ�");
					}
					else{
						Book book=bookList.get(0);
						%>
						<div id="updateBook">
<!-- 						�ʼ��ISBNҲ����������ȥ -->
							<input type="hidden" name="BeISBN" value="<%=BookISBN %>">
							�鼮��ţ�<input type="text" name="BookISBN" value="<%=book.getBookISBN() %>">
							�鼮���ƣ�<input type="text" name="BookName" value="<%=book.getBookName() %>">
							�鼮���ߣ�<input type="text" name="BookWriter" value="<%=book.getBookWriter() %>">
							�鼮���<select name="BookType">
										<%
										String typeSql="select TypeName from BookType";
										List<Map<String, Object>> rsType=helperClass.SelectSQL(typeSql);
										for(Map<String, Object> item:rsType){
											String TypeName=""+item.get("TypeName");
											%>
											<option value="<%=TypeName%>"><%=TypeName%></option>
											<%
											}
											%>
								</select><br>
							�����磺<input type="text" name="BookPublisher" value="<%=book.getBookPublisher() %>">
							
							�鼮�ۼۣ�<input type="text" name="BookSell" value="<%=book.getBookSell() %>">
							���������<input type="text" name="BookCount" value="<%=book.getBookCount() %>"><br>
							
							�鼮��飺<textarea name="BookIntro" cols="50" rows="10"><%=book.getBookIntro() %></textarea>
<!-- 							<textarea rows="" cols=""></textarea> -->
							
								�鼮ͼƬ��<%
									if(book.getBookPic().equals("picture/")){
									out.print("����ͼƬ");
									}
									else{
									%>
									<img src=<%=book.getBookPic() %> width="150px">
									<%
									}
									%>
									<input type="hidden" name="BePic" value="<%=book.getBookPic() %>">
							<input type="file" name="file" value="<%=book.getBookPic() %>"><br>
							
					
							
							<input type="submit" value="ȷ���޸�">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="���">
						</div>
						
						<%
						
					}
					
				}
			}
			
			%>
			
			</form>
		
		</div>
	</div>

</body>
</html>