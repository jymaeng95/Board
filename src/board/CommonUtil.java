package board;

public class CommonUtil {
	public static String removeNVL(String str) {
		if(str==null) {
			return "";
		}else if("null".equals(str.toLowerCase())) {
			return "";
		}
		return str;
	}
}
