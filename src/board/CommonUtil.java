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
	
	public static String defaultString(String str, String defaultStr) {
		if (str == null || "".equals(str)) {
			str = defaultStr;
		}
		
		return str;
	}
}
