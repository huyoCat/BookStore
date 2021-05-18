<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�ҵ���ʷ����</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/>
	<script type="text/javascript">
		function OrderUpda(OrderID){
			var OrderID=OrderID;
			var flag=confirm("ȷ��ȡ��������");
			if(flag){
				window.location.href="U_hisOrder.jsp?OrderID="+OrderID+"&msg=deleOrder";
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
				String SelectOrderInfo="select * from OrderInfo where CancelOrder=0 and UserName='"+UserName+"'";
				
				//�����������������
				if(!("null".equals(""+request.getParameter("limit")))){
					if("CancelOrder".equals(request.getParameter("limit").toString())){
						SelectOrderInfo="select * from OrderInfo where CancelOrder=1 and UserName='"+UserName+"'";
					}
					//�������������ֵ
					else if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
						out.print("�����������ؼ���");
					}
					else{
						String limit=request.getParameter("limit").toString();
						String search=helperClass.zhuanma(request.getParameter("search").toString());
						SelectOrderInfo+=" and "+limit+" like '%'+'"+search+"'+'%'";
					}
					
				}
				
// 				�����ɾ����������Ϣ
				if(null!=request.getParameter("msg")&&
					"deleOrder".equals(request.getParameter("msg").toString())){
					int OrderID=Integer.parseInt(""+request.getParameter("OrderID"));
// 	 				String deleSql="delete from OrderInfo where OrderID='"+OrderID+"'";
					String sqlOrderSta="update OrderInfo set CancelOrder=1 where OrderID="+OrderID+"";
					
					boolean flagDele=helperClass.SQL_ZSG(sqlOrderSta);
					if(flagDele){
						out.print("ȡ�������ɹ�");
					}
					else{
						out.print("ȡ������ʧ��");
					}
					
				}
				
				%>
				<!-- 		���������û��ȷ���û�����ɾ������ -->
				<form action="" method="post">
					<!-- 		һ�������� -->
					<div>
						<select name="limit">
							<option value="null">ѡ����������</option>
							<option value="BookList">���鼮����</option>
							<option value="Orderstate">������״̬����</option>
							<option value="CancelOrder">�鿴��ȡ������</option>
						</select>
								
						<input type="text" name="search">&nbsp;&nbsp;
						<input type="submit" value="����">
					</div>
				
			<!-- 		һ�������б� -->
					<div>
						<table border="3px" align="center" cellspacing="10px">
							<tr>
								<th width="150px">�������</th>
								<th width="300px">������Ϣ</th>
								<th width="150px">����״̬</th>
							</tr>
							<%
							List<Map<String, Object>> StarList=helperClass.SelectSQL(SelectOrderInfo);
							if(StarList.size()==0){
								out.print("�����������ѯʧ��  ��  ����������");
							}
							else{
								List<Order> OrderList=helperClass.reOrder(StarList);
								if(OrderList.size()==0){//�����ѯ��������
									out.println("�����б�ת��ʧ��  ��  ���������ڣ�");
								}
								else{
									for(Order order:OrderList){
										//��ȡ�û������ͼ���б�
										List<String> BookList=helperClass.OrderBook(""+order.getBookList());
										
										String state="";
										%>
										<tr>
											<td><%=order.getOrderID() %><br></td>
											
											<td>
											����ͼ�飺<BR><BR>
											<div>
											<%
											for(String str:BookList){
												out.println(str+"<BR><BR>");
											}
											%>
											</div>
											�����ܼۣ�<%=order.getTotalPrice() %><br>
											�µ����ڣ�<%=order.getOrderDay() %><br>
											�ջ���ַ��<%=order.getAddress() %><br>
											��ϵ��ʽ��<%=order.getPhone() %><br>
											</td>
											
											<td>
												<%if(order.getOrderstate()==0){
													state="��δ����";
												}
												else{
													state="�������";
												}
												
												if(order.getCancelOrder()==0){
													%>
													Ŀǰ״̬��<%=state %><br>
													<a href="U_UpdaOrder.jsp?OrderID=<%=order.getOrderID() %>">�޸Ķ���</a><br>
													<a href="#" onClick="OrderUpda(<%=order.getOrderID() %>)">ȡ������</a>
													<%
												}
												else{
													%>
													Ŀǰ״̬����ȡ��<Br>
													<a href="U_UpdaOrder.jsp?OrderID=<%=order.getOrderID() %>">���¹���</a>
													<%
												}
												%>
												
												
											</td>
										</tr>
										<%
									
									}
								}
							}
							%>
						
						</table>
					</div>
				
				</form>
				<%
				
				
			}
			%>
		
		</div>
	</div>
</body>
</html>