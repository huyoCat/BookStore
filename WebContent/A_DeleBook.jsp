<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*,javax.script.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>ɾ��/�޸��鼮��Ϣ</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function Deleting(ISBN){
			var BookISBN=ISBN;
			var flag=confirm("ȷ��ɾ���鼮��");
			if(flag){
				window.location.href="A_DeleBook.jsp?ISBN="+BookISBN+"&msg=delete";
			}
		}
	</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
		<!-- 	����Ƿ��¼ -->
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
			
			String SelectBookInfo="select * from BookInfo where 1=1";
			//�����������������
			if(!("null".equals(""+request.getParameter("limit")))){
				//�������������ֵ
				if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
					out.print("�����������ؼ���");
				}
				else{
					String limit=request.getParameter("limit").toString();
					String search=helperClass.zhuanma(request.getParameter("search").toString());
					SelectBookInfo+=" and "+limit+" like '%'+'"+search+"'+'%'";
				}
				
			}
			
			
			//����޸Ļ���ɾ�����鼮
			if(null!=request.getParameter("msg")&&
					"delete".equals(request.getParameter("msg").toString())){//ɾ��
				
				String BookISBN=request.getParameter("ISBN");
				String deleSql="delete from BookInfo where BookISBN='"+BookISBN+"'";
				boolean flagDele=helperClass.SQL_ZSG(deleSql);
				if(flagDele){
					out.print("�鼮ɾ���ɹ�");
				}
				else{
					out.print("�鼮ɾ��ʧ��");
				}	
			}
			
			//ʲô��û�е�ʱ����ʾ�鼮�б�
			%>
			<form method="post">
				<div>
<!-- 					�������� -->
					<select name="limit">
						<option value="null">ѡ����������</option>
						<option value="BookISBN">���鼮�������</option>
						<option value="BookName">���鼮��������</option>
						<option value="BookType">���鼮�������</option>
						<option value="BookWriter">���鼮��������</option>
					</select>
					
					<input type="text" name="search">&nbsp;&nbsp;
					<input type="submit" value="����">
				</div>
				
				<table border="3px" align="center" cellspacing="10px">
					<tr>
						<th width="150px">ͼƬ</th>
						<th width="300px">�鼮��Ϣ</th>
						<th width="150px">����</th>
					</tr>
					
					<%
					List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectBookInfo);
					if(StarList.size()==0){
						out.print("�鼮�������ѯʧ�ܻ��鼮������");
					}
					else{
						List<Book> bookList=helperClass.reBook(StarList);
						if(bookList.size()==0){//�����ѯ��������
							out.println("�鼮�б�ת��ʧ�ܻ��鼮�����ڣ�");
						}
						else{
							Set<String> ISBNSet=new TreeSet<>();
							for(Book book:bookList){
								//������Լӽ��б�˵��û���ظ����������б���ʾ
								if(ISBNSet.add(book.getBookISBN())){
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
										
										<td>
										������<%=book.getBookName() %><br>
										ISBN��<%=book.getBookISBN() %><br>
										���ߣ�<%=book.getBookWriter() %><br>
										��飺<%=book.getBookIntro() %><br>
										�����磺<%=book.getBookPublisher() %><br>
										ͼ�����<%=book.getBookType() %><br>
										���ۣ�<%=book.getBookCost() %><br>
										�ۼۣ�<%=book.getBookSell() %><br>
										���������<%=book.getBookCount() %><br>
										</td>
										
										<td>
											<a href="A_xiugaiBook.jsp?ISBN=<%=book.getBookISBN() %>">�޸���Ϣ</a><br>
											
											<a href="#" onClick="Deleting(<%=book.getBookISBN() %>)">ɾ���鼮</a>
										</td>
									
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
		}
		%>
		
		</div>
	</div>
</body>
</html>