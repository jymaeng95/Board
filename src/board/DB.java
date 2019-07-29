package board;
import java.sql.*;


public class DB {
	static Connection con = null;
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
	static ResultSet rs = null;
	static Boolean connect = false;
	
	//	DB 연결 
	public Connection loadConnect(){
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"jymaeng95","onlyroot");
			connect = true;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			connect = false;
			System.out.println("연결 에러 ");
		}
		
		return con;
	}
	
	// DB연결 해제 
	public void close(Connection con) throws SQLException {
		try {
			if(con != null) {
				con.close();
			}
		}catch(Exception e) {
			System.out.println("close 오류 ");
		}
	}
	
	//	게시판 이름 불러오기 
	public ResultSet getCategory() {
		String sql = "select *from board";
		try {
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("쿼리 에러");
		} 
		return rs;
		
	}

	public boolean setPost(String category, String name, String pPw, String show, String notice, String title, String contents) {
		boolean check = false;
		String sql = "insert into post values(no_seq.nextval,?,?,?,?,'',?,'',?,SYSDATE,?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, title);
			pstmt.setString(3, show);
			pstmt.setString(4, notice);
			pstmt.setString(5, name);
			pstmt.setString(6, pPw);
			pstmt.setString(7, contents);
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) {
				check = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return check;
	
	}
}
	