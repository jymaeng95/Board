package board;

public class PagingUtil {
	public static int lastPage(int lastPage) {
		while(true) {
			if(lastPage%10 == 1) {
				break;
			} else {
				lastPage--;
			}
		}
		return lastPage;
	}
	
	public static int paging(int postCount, int num) {
		int page;
		if(postCount%num!=0) {
			page = (postCount/num) +1;
		}else {
			page = postCount/num;
		}
		return page;
	}
}
