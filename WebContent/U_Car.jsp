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
		
// 		����Ǵ����Ƴ��ղص�ֵ������DeleID
			if(null!=request.getParameter("DeleID")&&
			!("".equals(request.getParameter("DeleID").toString()))){
				String DeleID=request.getParameter("DeleID").toString();
				String selectCar="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(selectCar);
				if(StarList.size()==0){
					out.print("�Ƴ����ﳵ�Ĳ�ѯ�����ʧ�ܣ�");
					%>
					<a href="Index.jsp">������ҳ</a>
					<%
				}
				else{
					String NowCar=StarList.get(0).get("UserBuyCar").toString();
					String[] strArr=NowCar.split(",");
					String NowInter="";
					for(int i=0;i<strArr.length;i++){
						if(strArr[i].equals(DeleID)){
							continue;
						}
						NowInter+=strArr[i]+",";
					}
					
					if(NowInter.charAt(NowInter.length()-1)==','){
						NowInter=NowInter.substring(0, NowInter.length()-1);
					}
					
					String InserSQL="update UserInfo set UserBuyCar='"+NowInter+"' where UserName='"+UserName+"'";
					boolean flag=helperClass.SQL_ZSG(InserSQL);
					if(flag){
						out.print("�Ƴ����ﳵ�ɹ���");
						%>
						<a href="Index.jsp">������ҳ</a>
						<%
					}
					else{
						out.print("�Ƴ����ﳵʧ�ܣ�");
						%>
						<a href="U_Car.jsp">���ˢ��</a>
						<%
					}
				}
			}
			
// 			����Ǵ��ż��빺�ﳵ��ֵ������
			if(null!=request.getParameter("ID")&&
			!("".equals(request.getParameter("ID").toString()))){
				String BISBN=request.getParameter("ID").toString();
				
				//������ﳵ�ǿյ�ֱ�Ӽ���
				String BeCarSql="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> StarList=helperClass.SelectSQL(BeCarSql);
				if(StarList.size()==0){
					out.print("��ѯ���ﳵ�����ʧ�ܣ�");
					%>
					<a href="Index.jsp">������ҳ���³���</a>
					<%
				}
				else{
					if(null==StarList.get(0).get("UserBuyCar")||//������ﳵΪ��ֱ�Ӳ���
							"".equals(StarList.get(0).get("UserBuyCar").toString())){
						String InsertCar="update UserInfo set UserBuyCar='"+BISBN+"' where UserName='"+UserName+"'";
						boolean flag=helperClass.SQL_ZSG(InsertCar);
						if(flag){
							out.print("���빺�ﳵ�ɹ���");
							%>
							<a href="Index.jsp">������ҳ</a>
							<%
						}
						else{
							out.print("���빺�ﳵʧ�ܣ�");
							%>
							<a href="Index.jsp">������ҳ�������</a>
							<%
						}
					}
					else{//��Ϊ�գ��Ƚ�֮���ٲ���
						String strCar=StarList.get(0).get("UserBuyCar").toString();
						String[] NowCar=strCar.split(",");
						boolean IsCar=false;
						for(String str:NowCar){
							//�������ͬ����ʾ���ղ�
							if(str.equals(BISBN)){
								out.print("���ﳵ���Ѿ�����");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
								IsCar=true;
								break;
							}
						}
						if(!IsCar){//��ǰû�мӹ����ﳵ
							strCar+=","+BISBN;
							String SqlAStar="update UserInfo set UserBuyCar='"+strCar+"' where UserName='"+UserName+"'";
							boolean flagA=helperClass.SQL_ZSG(SqlAStar);
							if(flagA){
								out.print("�鼮���빺�ﳵ�ɹ�");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
							}
							else{
								out.print("�鼮��ӹ��ﳵʧ��");
								%>
								<a href="Index.jsp">������ҳ�����ղ�</a>
								<%
							}
						}
					}
				}
			}
		
			//û���κβ����������ֱ�Ӽ��ع��ﳵ
			%>
			<form method="post" action="U_Buy.jsp">
			<table>
			
				<tr>
					<th width="150px">ͼƬ</th>
					<th width="200px">����</th>
					<th width="150px">��������</th>
					<th width="150px"><input type="submit" value="ȫ������"></th>
				</tr>
				<tr>
					<td colspan="4"><hr width="100%" color="black"></td>
				</tr>
			
				<!-- 				��ȡ����ѭ����ʾ -->
				<%
				String SqlCar="select UserBuyCar from UserInfo where UserName='"+UserName+"'";
				List<Map<String, Object>> rsCar=helperClass.SelectSQL(SqlCar);
				if(rsCar.size()==0){
					out.print("���ﳵ");
					%>
					<a href="U_Car.jsp">���ˢ��</a>
					<%
				}
				else{
					if(null==rsCar.get(0).get("UserBuyCar")||
							"".equals(rsCar.get(0).get("UserBuyCar").toString())){
								out.print("���ﳵ��û���κ���ƷŶ");
								%>
								<a href="Index.jsp">������ҳ</a>
								<%
					}
					else{
						String strCar=rsCar.get(0).get("UserBuyCar").toString();
						String[] CarArr=strCar.split(",");
						for(String str:CarArr){
							String selectCar="select * from BookInfo where BookISBN='"+str+"'";
							List<Map<String, Object>> rsGetList=helperClass.SelectSQL(selectCar);
							if(rsGetList.size()!=0){
								List<Book> bookList=helperClass.reBook(rsGetList);
								if(bookList.size()!=0){
									Book book=bookList.get(0);
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
										������<%=book.getBookName() %>
										���ߣ�<%=book.getBookWriter() %><br>
										�����磺<%=book.getBookPublisher() %><br>
										��飺<%=book.getBookIntro() %><br>
										ISBN��<%=book.getBookISBN() %><br>
										�ۼۣ�<%=book.getBookSell() %>
										</td>
										
										<td align="center">
											<input type="hidden" value='<%=book.getBookISBN() %>' name="BuyISBN">
											�����빺��������<input type="text" name="number" value="1" size="5px">
											
										</td>
										
										<td align="center">
										<a href="U_Car.jsp?DeleID=<%=book.getBookISBN() %>">�Ƴ���Ʒ</a>
										</td>
									
									</tr>
									<tr>
										<td colspan="4"><hr width="100%" color="black"></td>
									</tr>
									<%
								}
								else{
									out.print("���ﳵ�б�ת��ʧ��");
									%>
									<a href="Index.jsp">������ҳ</a>
									<%
								}
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