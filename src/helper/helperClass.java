package helper;
import java.io.UnsupportedEncodingException;

public class helperClass {
	//×ªÂëº¯Êı
	public static String zhuanma(String str) {
		String result="½âÂë´íÎó";
		try {
			result = new String(str.getBytes("ISO-8859-1"), "gb2312");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
