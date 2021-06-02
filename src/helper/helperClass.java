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
	//转码函数
	public static String zhuanma(String str) {
		String result="解码错误";
		try {
			result = new String(str.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
		
	
	//检测是否含中文
	public static boolean isContainChinese(String str) {
		Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
		Matcher m = p.matcher(str);
		if (m.find()) {
			return true;
		}
		return false;
	}
	
	//不用转码的查询
	public static List<Map<String, Object>> Not_Select(String sql){
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//连接数据库URL
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
		
		//填充离线结果集
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
	
	//连接数据库 查询操作 添加书籍用
	public static List<Map<String, Object>> SelectSQL(String Bsql) {
		// 加载JDBC-ODBC桥驱动驱动程序
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
		//连接数据库URL
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
		
		//填充离线结果集
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
	
	//不用转码的增删改
	public static boolean Not_ZSG(String sql) {
		boolean flag=false;//成功修改置为true
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//连接数据库URL
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
	
	//数据库 增、删、改
	public static boolean SQL_ZSG(String Bsql) {
		String sql="";
		try {
			sql = new String(Bsql.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		boolean flag=false;//成功修改置为true
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//连接数据库URL
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
	
	//判断是否为日期格式
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

	//结果集转化为book类用
	public static List<Book> reBook(List<Map<String, Object>> rs){
		List<Book> BookList=new ArrayList<>();
		if(null==rs){//如果查询不到数据
			System.out.println("数据错误！");
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

	
	//结果集转化为Order类
	public static List<Order> reOrder(List<Map<String, Object>> rs){
		List<Order> OrderList=new ArrayList<>();
		if(null==rs){//如果查询不到数据
			System.out.println("数据错误！");
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
	
//	转化为User类
	public static List<User> reUser(List<Map<String, Object>> rs){
		List<User> UserList=new ArrayList<>();
		if(null==rs){//如果查询不到数据
			System.out.println("数据错误！");
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
	
	//获取用户订单里的图书列表
	public static List<String> OrderBook(String BookList) {
		List<String> result=new ArrayList<>();
		
		String[] BookArr=BookList.split(";");
		
		for(String str:BookArr){
			String inResult="";
			String[] inBook=str.split(",");
//			inlist.add(inBook);//[ISBN,数量]
			String sql="select * from BookInfo where BookISBN='"+inBook[0]+"'";
			List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
			if(rs.size()==0){//如果查询不到数据
				System.out.println("数据错误！");
			}
			else{
				List<Book> bookList=helperClass.reBook(rs);
				if(bookList.size()==0){//如果查询不到数据
					System.out.println("数据错误！");
				}
				else{
					Book book=bookList.get(0);
					inResult="书籍名称："+book.getBookName()+"<BR>书籍ISBN:"+book.getBookISBN()+"<BR>购买数量："+inBook[1];
					result.add(inResult);
				}
			}
		}
		return result;
	}
	
	
	//用户修改订单信息用到的数据
	public static List<Book_Number> updateOrder(String BookList){
		List<Book_Number> result=new ArrayList<>();
//		Map<Book,Integer> map=new TreeMap<>();
		
		String[] BookArr=BookList.split(";");
		
		for(String str:BookArr){
//			String inResult="";
			Book_Number inList=new Book_Number();
			String[] inBook=str.split(",");
			
//			inlist.add(inBook);//[ISBN,数量]
			String sql="select * from BookInfo where BookISBN='"+inBook[0]+"'";
			List<Map<String, Object>> rs=helperClass.SelectSQL(sql);
			if(rs.size()==0){//如果查询不到数据
				System.out.println("数据错误！");
			}
			else{
				List<Book> bookList=helperClass.reBook(rs);
				if(bookList.size()==0){//如果查询不到数据
					System.out.println("数据错误！");
				}
				else{
					Book book=bookList.get(0);
//					inResult="书籍名称："+book.getBookName()+"<BR>书籍ISBN:"+book.getBookISBN()+"<BR>购买数量："+inBook[1];
					inList.setBook(book);
					inList.setNumber(Integer.parseInt(inBook[1]));
					result.add(inList);
				}
			}
		}
		
		return result;
	}
	
//	获取今天的日期
	public static String getDate() {
		Date date = new Date(System.currentTimeMillis()); 

		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");  
		String result=formatter.format(date);
		return result;
	}
	
	
	//添加或修改书籍类别时检测是否重名
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
