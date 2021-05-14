package helper;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import com.sun.rowset.CachedRowSetImpl;

//import javax.sql.rowset.CachedRowSet;

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
	
	//连接数据库 查询操作 添加书籍用
	public static List<Map<String, Object>> SelectSQL(String sql) {
		// 加载JDBC-ODBC桥驱动驱动程序
		//String Driver="sun.jdbc.odbc.JdbcOdbcDriver";
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
				BookList.add(book);
			}
		}
		return BookList;
	}

	//用户浏览商品的各种操作
//	public static void Star_or_Buy()
	
	
	//测试
	public static void test() {
		System.out.print("test");
	}
	
	//用不到的
	public static List<Object> handler(ResultSet rs, Class<?> clazz) {
        List<Object> list = new ArrayList<>();
        Object obj = null;
        try {
            while (rs.next()) {
                // 创建一个clazz对象实例并将其赋给要返回的那个返回值。
                obj = clazz.newInstance();
                // 获取结果集的数据源
                ResultSetMetaData rsmeta = rs.getMetaData();
 
                // 获取结果集中的字段数
                int count = rsmeta.getColumnCount();
 
                // 循环取出个字段的名字以及他们的值并将其作为值赋给对应的实体对象的属性
                for (int i = 0; i < count; i++) {
                    // 获取字段名
                    String name = rsmeta.getColumnName(i + 1);
                    // 利用反射将结果集中的字段名与实体对象中的属性名相对应，由于
                    // 对象的属性都是私有的所以要想访问必须加上getDeclaredField(name)和
                    Field f = obj.getClass().getDeclaredField(name);
                    f.setAccessible(true);
                    // 将结果集中的值赋给相应的对象实体的属性
                    f.set(obj, rs.getObject(name));
                }
                list.add(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
//	public static Book reBook(Map<String, Object> rs) {
//		Book book=null;
//		book.BookID=""+rs.get("BookID");
//		return book;
//	}
}
