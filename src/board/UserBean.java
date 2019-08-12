package board;

public class UserBean {
	private String category;
	private String title;
	private String show;
	private String notice;
	private String name;
	private String pPw;
	private String contents;
	private String pDate;
	
	private int hit;
	private int recommend;
	private int pNum;
	
	//setter메소드
	public void setCategory(String category) {
		this.category = category;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setShow(String show) {
		this.show = show;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPpw(String pPw) {
		this.pPw = pPw;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public void setPdate(String pDate) {
		this.pDate = pDate;
	}
	
	public void setHit(int hit) {
		this.hit = hit;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public void setPnum(int pNum) {
		this.pNum = pNum;
	}
	
	//getter메소드 
	public String getCategory() {
		return this.category;
	}
	public String getTitle() {
		return this.title;
	}
	public String getShow() {
		return this.show;
	}
	public String getNotice() {
		return this.notice;
	}
	public String getName() {
		return this.name;
	}
	public String getPpw() {
		return this.pPw;
	}
	public String getContents() {
		return this.contents;
	}
	public String getPdate() {
		return this.pDate;
	}
	
	public int getHit() {
		return this.hit;
	}
	public int getRecommend() {
		return this.recommend;
	}
	public int getPnum() {
		return this.pNum;
	}
}
