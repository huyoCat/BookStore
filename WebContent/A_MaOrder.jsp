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
			
			String SelectOrderInfo="select * from OrderInfo where 1=1";
		
			//�����������������
			if(!("null".equals(""+request.getParameter("limit")))){
				if("CancelOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where CancelOrder=1";
				}
				else if("CompOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where Orderstate=1";
				}
				else if("NotyetOrder".equals(""+request.getParameter("limit"))){
					SelectOrderInfo="select * from OrderInfo where Orderstate=0 and CancelOrder=0";
				}
				//�������������ֵ
				else if(null==request.getParameter("search")||"".equals(request.getParameter("search").toString())){
					out.print("�����������ؼ���");
				}
				else{
					String limit=request.getParameter("limit").toString();
					String search=request.getParameter("search").toString();
					SelectOrderInfo+=" and "+limit+" like '%'+'"+search+"'+'%'";
				}
				
			}
			
			//����޸��˶���״̬
			if(null!=request.getParameter("msg")&&
					"complect".equals(request.getParameter("msg").toString())){
				
				int OrderID=Integer.parseInt(""+request.getParameter("OrderID"));
// 				String deleSql="delete from BookInfo where BookISBN='"+BookISBN+"'";

// 				�ȿ����������������
// 				ͨ��orderID��ȡ������鼮�б�				
				String selectBook="select * from OrderInfo where OrderID="+OrderID+"";
				List<Map<String, Object>> rsGetList=helperClass.SelectSQL(selectBook);
				String BookList=""+rsGetList.get(0).get("BookList");
				List<Book_Number> buyList=helperClass.updateOrder(BookList);
				//�����鼮�б�鿴���
				boolean flag=true;
				for(int i=0;i<buyList.size();i++){
					String sql="select * from BookInfo where BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
					List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
					int count=Integer.parseInt(""+rs.get(0).get("BookCount"));
					if(count<buyList.get(i).getNumber()){
						out.println("��治��");
						flag=false;
						break;
					}
				}
				if(flag){
					String sqlOrderSta="update OrderInfo set Orderstate=1 where OrderID="+OrderID+"";
					
					boolean flagDele=helperClass.SQL_ZSG(sqlOrderSta);
					
					boolean InfoFlag=true;
					if(flagDele){
						out.print("����״̬�޸ĳɹ�<br>");
						//�޸�BookInfo��������Ϣ�Ϳ����Ϣ
						for(int i=0;i<buyList.size();i++){
							int count=buyList.get(i).getNumber();//�û����������
							//��ѯǰ�������ݼ�¼BookID
							String sql="select top "+count+" * from BookInfo where IsSell=0 and BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
							List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
// 							String[] IDList=new String[rs.size()];
// 							

							for(int j=0;j<count;j++){
								String BookID=""+rs.get(j).get("BookID");
								String Date=helperClass.getDate();
								String SellSql="update BookInfo set IsSell=1,OrderID="+OrderID+",BookOutDay='"+Date+"' where BookID="+BookID+"";
								InfoFlag=helperClass.SQL_ZSG(SellSql);
								if(!InfoFlag){
									out.print("���ݿ�������Ϣ�޸ĳ����ѳɹ�����"+(j+1)+"��");
									break;
								}
							}
							if(!InfoFlag){
								break;
							}
							else{
// 								�޸Ŀ��							
								String sqlCount="select BookISBN from BookInfo where IsSell=0 and BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
								List<Map<String, Object>> rsAmount=helperClass.SelectSQL(sqlCount);
								int BookAmount=rsAmount.size();
								//���¿������
								String updateSql="update BookInfo set BookCount="+BookAmount+" where BookISBN='"+buyList.get(i).getBook().getBookISBN()+"'";
								boolean flagUpdate=helperClass.SQL_ZSG(updateSql);
								if(flagUpdate){
									out.println("��������޸ĳɹ���<BR>");
								}
								else{
									out.println("��������޸�ʧ�ܣ�<BR>");
								}
							}
						}
						if(InfoFlag){
							out.print("���ݿ��鼮������Ϣ�޸ĳɹ�<BR>");
						}
						
					}
					else{
						out.print("����״̬�޸�ʧ��");
					}	
				}
			}
			
		%>
		<form action="" method="post">
			<!-- 		һ�������� -->
			<div>
				<select name="limit">
					<option value="null">ѡ����������</option>
					<option value="OrderID">�������������</option>
					<option value="UserName">�������û�����</option>
					<option value="NotyetOrder">�鿴δ��������</option>
					<option value="CompOrder">�鿴����ɶ���</option>
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
									<%
									if(order.getCancelOrder()==1){
										out.print("Ŀǰ״̬����ȡ��");
									}
									else{
										if(order.getOrderstate()==0){
											state="��δ����";
											%>
											Ŀǰ״̬��<%=state %><br>
											<a href="#" onClick="OrderUpda(<%=order.getOrderID() %>)">��ɶ���</a>
											<%
										}
										else{
											state="�������";
											%>
											Ŀǰ״̬��<%=state %><br>
											<%
										}
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