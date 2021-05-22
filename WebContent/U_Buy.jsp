<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>ȷ�϶���</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
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
			//��ȡ�û���Ϣ
			String SelectInfo="select * from UserInfo where UserName='"+UserName+"'";
			User user=new User();
			List<Map<String, Object>> GetUser=helperClass.SelectSQL(SelectInfo);
			if(GetUser.size()!=0){
				List<User> userList=helperClass.reUser(GetUser);
				if(userList!=null){
					user=userList.get(0);
				}
			}
			
			
// 			�������������Ϣ��Ϊ��
			if((null!=request.getParameterValues("BuyISBN"))&&
					(null!=request.getParameterValues("number"))){
				String[] ISBN=request.getParameterValues("BuyISBN");
				String[] number=request.getParameterValues("number");
				//�ж������Ƿ�ȳ�
				if(ISBN.length==number.length){
					
//		 			�µ�ҳ��϶�Ҫ���Ź�����Ϣ�����������ʾ��Ϣ
					
					%>
					<form method="post" action="U_Confirmorder.jsp">
					<table border="3px" align="center" cellspacing="10px">
						<tr>
							<th>������Ϣ</th><!-- ���������� -->
						</tr>
						<% 
						float total=0;//���ۼ�
						for(int i=0;i<ISBN.length;i++){
							String SelectSql="select * from BookInfo where BookISBN='"+ISBN[i]+"'";
							List<Map<String, Object>> rsGetList=helperClass.SelectSQL(SelectSql);
							if(rsGetList.size()!=0){
								List<Book> bookList=helperClass.reBook(rsGetList);
								if(bookList.size()!=0){
									Book book=bookList.get(0);
									
									float price=book.getBookSell();
									int count=Integer.parseInt(number[i]);
									total+=price*count;
									%>
									<tr>
										<td>
										������
										<input type="text" value="<%=book.getBookName() %>" readOnly><br>
										ISBN:<input type="text" name="ISBN" value="<%=book.getBookISBN() %>" readOnly><br>
										����������<input type="text" name="number" value="<%=number[i] %>" readOnly>
										</td>
									</tr>
									<%
								}
								else{
									out.print("�鼮��Ϣת��ʧ��");
									%>
									<a href="U_Buy.jsp">���ˢ��</a>
									<%
								}
							}
							else{
								out.print("��ѯ�鼮��Ϣʧ��");
								%>
								<a href="U_Buy.jsp">���ˢ��</a>
								<%
							}
								
						}
						%>
						
					<tr>
						<td>
							�ܼۣ�<input type="text" name="Tprice" value="<%=total %>" readOnly>
						</td>
					</tr>
					
					<tr>
						<td>
							��ϵ��ʽ��<input type="text" name="phone" value="<%=user.getUserPhone() %>"><br>
							�ջ���ַ��<textarea name="address"><%=user.getUserAddress() %></textarea>
						</td>
					</tr>
						
					
					
					<tr>
					<td align="center"><input type="submit" value="�ύ����">&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:history.back(-1)">�����޸�</a>
					</td>
					</tr>
					</table>
					</form>
					<%
				}
				else{
					%>
					<a href="U_Buy.jsp">���ݳ������ˢ��</a>
					<%
				}

			}
			else{
				out.println("���ﳵ�տ���Ҳ");
				%>
				<a href="Index.jsp">������ҳ�����Ʒ</a>
				<%
			}
			
		}
		%>
		
		</div>
	</div>

</body>
</html>