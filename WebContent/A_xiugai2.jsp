<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030" import="helper.*,java.net.*,java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="GB18030">
<title>�޸��鼮�������</title>
	<link type="text/css" rel="stylesheet" href="mainStyle.css"/> 
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div id="main">
<!-- 	��� -->
		<%@ include file="Left.jsp"%>
<!-- 	�м��ͼ���б� -->
		<div id="bookTable">
<!-- 		�����޸����� -->
		<%		
				String BeISBN=request.getParameter("BeISBN");
				String number1=request.getParameter("BookCount");
				String BookName=request.getParameter("BookName");
				String BookISBN=request.getParameter("BookISBN");
				String BookWriter=request.getParameter("BookWriter");
				String BookPublisher=request.getParameter("BookPublisher");
				String BookIntro=request.getParameter("BookIntro");
				String Sell=request.getParameter("BookSell");
				//��ȡ�����б�򣬴������룬����Ҫ��ת��
				String BookType=request.getParameter("BookType");
				
// 				�ж���û�и���ͼƬBePic
				String PicPath="";
				if(null==request.getParameter("file")||"".equals(""+request.getParameter("file"))){//û��
					PicPath=request.getParameter("BePic");
				}
				else{
					PicPath="picture/"+request.getParameter("file");
				}
				//�жϼ�Ǯ�Ƿ�������
				double BookSell=0;
				int BookCount=0;
				try{
					BookSell=Double.parseDouble(Sell);
					BookCount=Integer.parseInt(number1);
				}
				catch(Exception e){
					out.println("��ȷ����Ʒ�۸���鼮��Ŀ��д��ȷ��");
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
				
				String UpdateSql="update BookInfo set BookName='"+BookName+"',BookISBN='"+BookISBN+"',BookWriter='"+BookWriter+"',BookPublisher='"+BookPublisher+"',BookIntro='"+BookIntro+"',BookType='"+BookType+"',BookSell="+BookSell+",BookCount="+BookCount+",BookPic='"+PicPath+"' where BookISBN='"+BeISBN+"'";
				boolean flagUpdate=helperClass.SQL_ZSG(UpdateSql);
				if(flagUpdate){
					out.println("�鼮��Ϣ�޸ĳɹ���");
					%>
					<a href="Index.jsp">������ҳ</a>
					<% 
				}
				else{
					out.println("�鼮��Ϣ�޸�ʧ�ܣ�");
					%>
					<a href="javascript:history.back(-1)">���³���</a>
					<% 
				}
		
		%>
		
		</div>
	</div>

</body>
</html>