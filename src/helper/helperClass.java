package helper;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class helperClass {
	//ת�뺯��
	public static String zhuanma(String str) {
		String result="�������";
		try {
			result = new String(str.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
		
	
	//����Ƿ�����
	public static boolean isContainChinese(String str) {
		Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
		Matcher m = p.matcher(str);
		if (m.find()) {
			return true;
		}
		return false;
	}
	
	//����ת��Ĳ�ѯ
	public static List<Map<String, Object>> Not_Select(String sql){
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//�������ݿ�URL
		//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
		String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs=null;
		try {
			conn = DriverManager.getConnection( URL,"sa", "1064534251");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt = (Statement) conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//������߽����
		ResultSetMetaData rsm = null;
		try {
			rsm = rs.getMetaData();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		 
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>(); 
		try {
			while (rs.next()) { 
			Map<String, Object> map = new TreeMap<String, Object>(); 
			for (int index = 1; index <= rsm.getColumnCount(); index++) { 
				map.put(rsm.getColumnName(index), rs.getObject(index)); 
			} 
			result.add(map); 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
//		CachedRowSetImpl crs = new CachedRowSetImpl();
//        crs.populate(rs);
		finally {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return result;
	}
	
	//�������ݿ� ��ѯ���� ����鼮��
	public static List<Map<String, Object>> SelectSQL(String Bsql) {
		// ����JDBC-ODBC��������������
		//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
		String sql="";
		try {
			sql = new String(Bsql.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//�������ݿ�URL
		//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
		String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs=null;
		try {
			conn = DriverManager.getConnection( URL,"sa", "1064534251");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt = (Statement) conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//������߽����
		ResultSetMetaData rsm = null;
		try {
			rsm = rs.getMetaData();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		 
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>(); 
		try {
			while (rs.next()) { 
			Map<String, Object> map = new TreeMap<String, Object>(); 
			for (int index = 1; index <= rsm.getColumnCount(); index++) { 
				map.put(rsm.getColumnName(index), rs.getObject(index)); 
			} 
			result.add(map); 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
//		CachedRowSetImpl crs = new CachedRowSetImpl();
//        crs.populate(rs);
		finally {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return result;
	}
	
	//����ת�����ɾ��
	public static boolean Not_ZSG(String sql) {
		boolean flag=false;//�ɹ��޸���Ϊtrue
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//�������ݿ�URL
		//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
		String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
//		Connection conn;
		try {
			conn = DriverManager.getConnection( URL,"sa", "1064534251");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt.executeUpdate(sql);
			flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	//���ݿ� ����ɾ����
	public static boolean SQL_ZSG(String Bsql) {
		String sql="";
		try {
			sql = new String(Bsql.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		boolean flag=false;//�ɹ��޸���Ϊtrue
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//�������ݿ�URL
		//String URL ="jdbc:odbc:Driver=Microsoft Access Driver (*.mdb);DBQ=d:\\LJQ\\SHOP.mdb";
		String URL="jdbc:sqlserver://localhost:1434; DatabaseName=BookStore";
//		Connection conn;
		try {
			conn = DriverManager.getConnection( URL,"sa", "1064534251");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt.executeUpdate(sql);
			flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			stmt.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	//�ж��Ƿ�Ϊ���ڸ�ʽ
	public static boolean isDate(String strDate) {
        Pattern pattern = Pattern
                .compile("^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$");
        Matcher m = pattern.matcher(strDate);
        if (m.matches()) {
            return true;
        } else {
            return false;
        }
    }

	//�����ת��Ϊbook����
	public static List<Book> reBook(List<Map<String, Object>> rs){
		List<Book> BookList=new ArrayList<>();
		if(null==rs){//�����ѯ��������
			System.out.println("���ݴ���");
		}
		else {
			for(Map<String, Object> item:rs){
				Book book=new Book();
				book.setBookID(Integer.parseInt(""+item.get("BookID")));
				book.setBookName(""+item.get("BookName"));
				book.setBookISBN(""+item.get("BookISBN"));
				book.setBookWriter(""+item.get("BookWriter"));
				book.setBookIntro(""+item.get("BookIntro"));
				book.setBookPublisher(""+item.get("BookPublisher"));
				book.setBookType(""+item.get("BookType"));
				book.setBookPic(""+item.get("BookPic"));
				book.setBookCost(Float.parseFloat(""+item.get("BookCost")));
				book.setBookSell(Float.parseFloat(""+item.get("BookSell")));
				book.setOrderID(""+item.get("OrderID"));
				book.setBookInDay(""+item.get("BookInDay"));
				book.setBookOutDay(""+item.get("BookOutDay"));
				book.setBookCount(Integer.parseInt(""+item.get("BookCount")));
				book.setIsSell(Integer.parseInt(""+item.get("IsSell")));
				BookList.add(book);
			}
		}
		return BookList;
	}

	
	//�����ת��ΪOrder��
	public static List<Order> reOrder(List<Map<String, Object>> rs){
		List<Order> OrderList=new ArrayList<>();
		if(null==rs){//�����ѯ��������
			System.out.println("���ݴ���");
		}
		else {
			for(Map<String, Object> item:rs){
				Order order=new Order();
				order.setOrderID(Integer.parseInt(""+item.get("OrderID")));
				order.setBookList(""+item.get("BookList"));
				order.setUserName(""+item.get("UserName"));
				order.setTotalPrice(Float.parseFloat(""+item.get("TotalPrice")));
				order.setOrderDay(""+item.get("OrderDay"));
				order.setAddress(""+item.get("Address"));
				order.setPhone(""+item.get("Phone"));
				order.setOrderstate(Integer.parseInt(""+item.get("Orderstate")));
				order.setCancelOrder(Integer.parseInt(""+item.get("CancelOrder")));
				OrderList.add(order);
			}
		}
		return OrderList;
	}
	
//	ת��ΪUser��
	public static List<User> reUser(List<Map<String, Object>> rs){
		List<User> UserList=new ArrayList<>();
		if(null==rs){//�����ѯ��������
			System.out.println("���ݴ���");
		}
		else {
			for(Map<String, Object> item:rs){
				User user=new User();
				user.setUserID(Integer.parseInt(""+item.get("UserID")));
				user.setUserName(""+item.get("UserName"));
				user.setUserPwd(""+item.get("UserPwd"));
				user.setUserStar(""+item.get("UserStar"));
				user.setUserBuyCar(""+item.get("UserBuyCar"));
				user.setUserGrant(Integer.parseInt(""+item.get("UserGrant")));
				user.setUserAddress(""+item.get("UserAddress"));
				user.setUserPhone(""+item.get("UserPhone"));
				UserList.add(user);
			}
		}
		
		return UserList;
	}
	
	//��ȡ�û��������ͼ���б�
	public static List<String> OrderBook(String BookList) {
		List<String> result=new ArrayList<>();
		
		String[] BookArr=BookList.split(";");
		
		for(String str:BookArr){
			String inResult="";
			String[] inBook=str.split(",");
//			inlist.add(inBook);//[ISBN,����]
			String sql="select * from BookInfo where BookISBN='"+inBook[0]+"'";
			List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
			if(rs.size()==0){//�����ѯ��������
				System.out.println("���ݴ���");
			}
			else{
				List<Book> bookList=helperClass.reBook(rs);
				if(bookList.size()==0){//�����ѯ��������
					System.out.println("���ݴ���");
				}
				else{
					Book book=bookList.get(0);
					inResult="�鼮���ƣ�"+book.getBookName()+"<BR>�鼮ISBN:"+book.getBookISBN()+"<BR>����������"+inBook[1];
					result.add(inResult);
				}
			}
		}
		return result;
	}
	
	
	//�û��޸Ķ�����Ϣ�õ�������
	public static List<Book_Number> updateOrder(String BookList){
		List<Book_Number> result=new ArrayList<>();
//		Map<Book,Integer> map=new TreeMap<>();
		
		String[] BookArr=BookList.split(";");
		
		for(String str:BookArr){
//			String inResult="";
			Book_Number inList=new Book_Number();
			String[] inBook=str.split(",");
			
//			inlist.add(inBook);//[ISBN,����]
			String sql="select * from BookInfo where BookISBN='"+inBook[0]+"'";
			List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
			if(rs.size()==0){//�����ѯ��������
				System.out.println("���ݴ���");
			}
			else{
				List<Book> bookList=helperClass.reBook(rs);
				if(bookList.size()==0){//�����ѯ��������
					System.out.println("���ݴ���");
				}
				else{
					Book book=bookList.get(0);
//					inResult="�鼮���ƣ�"+book.getBookName()+"<BR>�鼮ISBN:"+book.getBookISBN()+"<BR>����������"+inBook[1];
					inList.setBook(book);
					inList.setNumber(Integer.parseInt(inBook[1]));
					result.add(inList);
				}
			}
		}
		
		return result;
	}
	
//	��ȡ���������
	public static String getDate() {
		Date date = new Date(System.currentTimeMillis()); 

		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");  
		String result=formatter.format(date);
		return result;
	}
	
	
	//��ӻ��޸��鼮���ʱ����Ƿ�����
	public static boolean IsReName(String sql) {
		List<Map<String, Object>> StarList=helperClass.SelectSQL(sql);
		if(StarList.size()==0) {
			return false;
		}
		else {
			return true;
		}
	}
}
