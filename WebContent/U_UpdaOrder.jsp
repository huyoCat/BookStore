<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸Ķ���</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
// 		var total=document.getElementByName('Tprice').value;
		function getNum(){
// 			alert("1");
			var price=document.getElementsByName("Cost");
			var number=document.getElementsByName("number");
// 			var price=new Array();
// 			alert("1");
			var total=0;
			for(var i=0;i<price.length;i++){
// 				alert(price[i].value);
// 				alert(number[i].value);
				total+=price[i].value*number[i].value;
				
			}
// 			alert(total);
// 			return total;
			document.getElementById("Tprice").value=""+total;
// 			vartp=document.getElementByName("Tprice");
// 			tp.value=total;
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
		<%//ȷ���Ƿ��¼��վ
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
				String OrderID=request.getParameter("OrderID").toString();
				
				%>
				<form method="post" action="U_Confirmorder.jsp?msg=updateOrder&OrderID=<%=OrderID %>">
					<table align="center">
						<tr>
							<th>�鼮ͼƬ</th>
							<th>�鼮��Ϣ</th>
							<th>�޸�</th>
						</tr>
						<tr>
							<td colspan="4"><hr width="100%" color="black"></td>
						</tr>
						<%
// 						���ݶ�����ѯ������Ϣ
						String sqlOrder="select * from OrderInfo where OrderID="+OrderID+"";
						List<Map<String, Object>> StarList=helperClass.SelectSQL(sqlOrder);
						if(StarList.size()==0){
							out.print("�����������ѯʧ��  ��  ����������");
						}
						else{
							List<Order> OrderList=helperClass.reOrder(StarList);
							if(OrderList.size()==0){//�����ѯ��������
								out.println("�����б�ת��ʧ��  ��  ���������ڣ�");
							}
							else{
								Order order=OrderList.get(0);
								
								//��ȡ�û������ͼ���б�
								List<Book_Number> BookList=helperClass.updateOrder(""+order.getBookList());
// 								Map<Book,Integer> BookList=helperClass.updateOrder(""+order.getBookList());
// 								List<String[]>

								float total=0;
// 								��ȡ��������
								for(Book_Number book_number:BookList){
									Book book=book_number.getBook();
									int BuyNumber=book_number.getNumber();
									%>
									<tr>
										<td align="center"><%
												if(book.getBookPic().equals("picture/")){
													out.print("����ͼƬ");
												}
												else{
													%>
													<img src=<%=book.getBookPic() %> width="150px">
													<%
												}
												%></td>
										<td>
											������<input type="text" value="<%=book.getBookName() %>" readOnly><br>
											ISBN��<input type="text" name="ISBN" value="<%=book.getBookISBN() %>" readOnly><br>
											���ۣ�<input type="text" name="Cost" value="<%=book.getBookSell() %>" readOnly><br>
										</td>
										<td>
										 	����������<input type="text" name="number" value="<%=BuyNumber %>" OnInput="getNum()">
										</td>
									</tr>
									<tr>
										<td colspan="4"><hr width="100%" color="black"></td>
									</tr>
									<%
// 									int n=request.getParameter("number");
// 									total+=book.getBookCost()*n;
								}
								%>
								<tr>
									<td colspan="2">
										��ϵ��ʽ��<input type="text" name="phone" value=<%=order.getPhone() %>><br>
										�ջ���ַ��<textarea name="address" ><%=order.getAddress() %></textarea>
									</td>
									<td>
										�ܼ�=<input type="text" name="Tprice" id="Tprice" value=<%=order.getTotalPrice() %> readOnly>
									</td>
								</tr>
								
								<tr>
									<td colspan="3" align="center">
										<input type="submit" value="�ύ����">
									</td>
								</tr>
								
								<%
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