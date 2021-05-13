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
// 				out.println(helperClass.zhuanma(BookType));
				//��֤ȡֵ
				//�жϼ�Ǯ�Ƿ�������
				double BookCost=0;
				double BookSell=0;
				try{
					BookCost=Double.parseDouble(Cost);
					BookSell=Double.parseDouble(Sell);
				}
				catch(Exception e){
					out.println("��ȷ����Ʒ�۸���д��ȷ��");
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
				
				//�������ݿ�
				// ����JDBC-ODBC��������������
				//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
// 				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				//�������ݿ�URL
				//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
// 				String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
// 				Connection conn=DriverManager.getConnection( URL,"sa", "1064534251");
// 				Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				
				
				//��ѯ��û��һ����ISBN���ٴ���   �߼����ԣ����Բ��룬���Լ�һ��һ�����ٱ�ѭ������
				String sql="select BookISBN from BookInfo";
				List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
				if(null==rs){//�����ѯ��������
					out.println("���ݴ���");
				}
				else{
					for(Map<String, Object> item:rs){
						String ISBN=""+item.get("BookISBN");
						if(BookISBN==ISBN){
							out.println("�鼮ISBN�Ѵ��ڣ�");
							%>
							<a href="javascript:history.back(-1)">��������</a>
							<% 
							return;
						}
					}
				}
				
				//��������
				
				String Addsql="insert into BookInfo (BookName,BookISBN,BookWriter,BookPublisher,BookIntro,BookCost,BookSell,BookInDay,BookType) "+
					"values('"+BookName+"','"+BookISBN+"','"+BookWriter+"','"+BookPublisher+"','"+BookIntro+"',"+BookCost+","+BookSell+",'"+BookInDay+"','"+BookType+"')";
// 				ResultSet rInser=stmt.executeQuery(Addsql);
				boolean flag=helperClass.SQL_ZSG(Addsql);
				if(flag){
					out.println("�鼮��ӳɹ���");
					%>
					<a href="AddBook.jsp">�������</a>
					<% 
				}
				else{
					out.println("�鼮���ʧ�ܣ�");
					%>
					<a href="javascript:history.back(-1)">�������</a>
					<% 
				}
			%>
		
		</div>
	</div>
</body>
</html>