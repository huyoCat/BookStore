<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>������</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
	<script type="text/javascript">
		function OrderUpda(OrderID){
			var OrderID=OrderID;
			var flag=confirm("ȷ����ɶ�����");
			if(flag){
				window.location.href="A_MaOrder.jsp?OrderID="+OrderID+"&msg=complect";
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
			
			String SelectOrderInfo="select * from OrderInfo where CancelOrder=0";
		
			//�����������������
			if(!("null".equals(""+request.getParameter("limit")))){
				if("CancelOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where CancelOrder=1";
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
			
			//����޸��˶���״̬
			if(null!=request.getParameter("msg")&&
					"complect".equals(request.getParameter("msg").toString())){
				int OrderID=Integer.parseInt(""+request.getParameter("OrderID"));
// 				String deleSql="delete from BookInfo where BookISBN='"+BookISBN+"'";
				String sqlOrderSta="update OrderInfo set Orderstate=1 where OrderID="+OrderID+"";
				
				boolean flagDele=helperClass.SQL_ZSG(sqlOrderSta);
				if(flagDele){
					out.print("����״̬�޸ĳɹ�");
				}
				else{
					out.print("����״̬�޸�ʧ��");
				}	
				
			}
			
		%>
		<form action="" method="post">
			<!-- 		һ�������� -->
			<div>
				<select name="limit">
					<option value="null">ѡ����������</option>
					<option value="BookList">���鼮����</option>
					<option value="OrderID">�������������</option>
					<option value="Orderstate">������״̬����</option>
					<option value="UserName">�������û�����</option>
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
									�����û���<%=order.getUserName() %><br>
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
										%>
										Ŀǰ״̬��<%=state %><br>
									<a href="#" onClick="OrderUpda(<%=order.getOrderID() %>)">��ɶ���</a>
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