package board;

public class PageCount {
	public int paging(int postCount, int num) {
		int page;
		if(postCount%num!=0) {
			page = (postCount/num) +1;
		}else {
			page = postCount/num;
		}
		return page;
	}
}
