<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>����鼮������</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>

	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
		
		<div id="AddBook">
			<%
				//��ȡ����
				
				String number1=request.getParameter("number");
				String BookName=request.getParameter("BookName");
// 				out.println(helperClass.zhuanma(BookName));
				String BookISBN=request.getParameter("BookISBN");
// 				out.println(BookISBN);
				String BookWriter=request.getParameter("BookWriter");
// 				out.println(helperClass.zhuanma(BookWriter));
				String BookPublisher=request.getParameter("BookPublisher");
// 				out.println(helperClass.zhuanma(BookPublisher));
				String BookIntro=request.getParameter("BookIntro");
// 				out.println(helperClass.zhuanma(BookIntro));

				String Cost=request.getParameter("BookCost");
// 				out.println(BookCost);
				String Sell=request.getParameter("BookSell");
// 				out.println(BookSell);
				String BookInDay=request.getParameter("BookInDay");
// 				out.println(BookInDay);
				//��ȡ�����б�򣬴������룬����Ҫ��ת��
				String BookType=request.getParameter("BookType");
				
				String PicPath="picture/"+request.getParameter("file");
// 				String PicPath=request.getServletPath("file");//����ǻ�ȡ��jsp�ļ������·��
// 				out.println(helperClass.zhuanma(PicPath));
// 				out.println(helperClass.zhuanma(BookType));
				//��֤ȡֵ
				//�жϼ�Ǯ�Ƿ�������
				double BookCost=0;
				double BookSell=0;
				int number=0;
				try{
					BookCost=Double.parseDouble(Cost);
					BookSell=Double.parseDouble(Sell);
					number=Integer.parseInt(number1);
				}
				catch(Exception e){
					out.println("��ȷ����Ʒ�۸���鼮��Ŀ��д��ȷ��");
					%>
					<a href="javascript:history.back(-1)">��������</a>
					<% 
					return;
				}
				if(!helperClass.isDate(BookInDay)){
					out.println("��ȷ�Ͻ���������д��ȷ��");
					%>
					<a href="javascript:history.back(-1)">��������</a>
					
					<% 
					return;
				}
				if(null==BookName||"".equals(BookName)||null==BookISBN||"".equals(BookISBN)||
						null==BookWriter||"".equals(BookWriter)||
						null==BookPublisher||"".equals(BookPublisher)||
						null==BookIntro||"".equals(BookIntro)){
// 					if()
					out.println("��ȷ����Ϣ��д��ȷ��");
					%>
					<a href="javascript:history.back(-1)">��������</a>
					<% 
					return;
				}
				
				//��ѯ��û��һ����ISBN���ٴ���   �߼����ԣ����Բ��룬���Լ�һ��һ�����ٱ�ѭ������
				
				//��������
				
				String Addsql="insert into BookInfo (BookName,BookISBN,BookWriter,BookPublisher,BookIntro,BookCost,BookSell,BookInDay,BookType,BookPic) "+
					"values('"+BookName+"','"+BookISBN+"','"+BookWriter+"','"+BookPublisher+"','"+BookIntro+"',"+BookCost+","+BookSell+",'"+BookInDay+"','"+BookType+"','"+PicPath+"')";
// 				ResultSet rInser=stmt.executeQuery(Addsql);
				int count=0;//��¼����
				boolean flag=true;
				for(int i=0;i<number;i++){
					flag=helperClass.SQL_ZSG(Addsql);
					count++;
					if(!flag){
						break;
					}
				}
				if(flag&&count==number){
					out.println("�鼮��ӳɹ���");
					%>
					<a href="AddBook.jsp">�������</a>
					<% 
				}
				else{
					out.println("�鼮���ʧ�ܣ������"+count+"��");
					%>
					<a href="javascript:history.back(-1)">�������</a>
					<% 
				}
			%>
		
		</div>
	</div>
</body>
</html>