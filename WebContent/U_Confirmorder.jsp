<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�ύ����</title>
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
			
// 			ȷ����ȡ����Ϣ��Ϊ��
			if(null!=request.getParameter("phone")&&!("null".equals(""+request.getParameter("phone")))&&!("".equals(""+request.getParameter("phone")))
			&&null!=request.getParameter("address")&&!("null".equals(""+request.getParameter("address")))&&!("".equals(""+request.getParameter("address")))){
				
				String Address=""+request.getParameter("address");
				String Phone=""+request.getParameter("phone");
				
				String[] ISBN=request.getParameterValues("ISBN");
				String[] number=request.getParameterValues("number");
				
				String Price="";
				if(null!=request.getParameter("Tprice")){
					Price=request.getParameter("Tprice").toString();
					
				}
				float TotalPrice=Float.parseFloat(Price);
				String OrderDay=helperClass.getDate();
				
// 				String newCarList="";
// 				�ϲ��ַ���
				String BookList="";
				for(int i=0;i<ISBN.length;i++){
					if(i==ISBN.length-1){
						BookList+=ISBN[i]+","+number[i];
					}
					else{
						BookList+=ISBN[i]+","+number[i]+";";
					}
				}
				
				//�޸��鼮����Ϣ��OrderInfoҪ��,������Ƴ����ﳵ
// 				�޸�OrderInfo
				String OrderSql="insert into OrderInfo (BookList,UserName,TotalPrice,OrderDay,Address,Phone) values('"+BookList+"','"+UserName+"',"+TotalPrice+",'"+OrderDay+"','"+Address+"','"+Phone+"')";
				boolean Orderflag=helperClass.SQL_ZSG(OrderSql);
				if(Orderflag){
					
					//������޸ĵĶ���
					if(null!=request.getParameter("msg")&&
						("updateOrder").equals(""+request.getParameter("msg"))){
						String OrderID=""+request.getParameter("OrderID");
						
						String updateSql="update OrderInfo set CancelOrder=1 where OrderID="+OrderID+"";
						boolean Deflag=helperClass.SQL_ZSG(updateSql);
						if(Deflag){
							out.println("ԭ���������ɹ���");
						}
						else{
							out.println("ԭ��������ʧ�ܣ�");
						}
					}
					else{
						//�Ƴ����ﳵ
						String deleCar="update UserInfo set UserBuyCar=null where UserName='"+UserName+"'";
						boolean DeC=helperClass.SQL_ZSG(deleCar);
						if(DeC){
							out.print("��չ��ﳵ�ɹ���");
						}
						else{
							out.print("��չ��ﳵʧ�ܣ�");
						}
					}
					
					out.print("�¶�����Ϣ��ӳɹ���");
					%>
					<a href="Index.jsp">������ҳ</a>
					<%
				}
				else{
					out.print("������Ϣ���ʧ�ܣ�");
					%>
					<a href="javascript:history.back(-1)">�����µ�</a>
					<%
				}
				

			}
			else{
				out.print("����ȷ��д��ַ�͵绰����");
				%>
				<a href="javascript:history.back(-1)">�����޸�</a>
				<%
			}
			
		}
		%>
		
		</div>
	</div>
</body>
</html>