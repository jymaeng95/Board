package board;
import java.sql.*;


public class DB {
	Connection con = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
	ResultSet rs = null;
	Boolean connect = false;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	//	DB ���� 
	public Connection loadConnect(){
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"jymaeng95","onlyroot");
			connect = true;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			connect = false;
			System.out.println("���� ���� ");
		}
		
		return con;
	}
	
	// DB���� ���� 
	public void close(Connection con) throws SQLException {
		try {
			if(con != null) {
				con.close();
			}
		}catch(Exception e) {
			System.out.println("close ���� ");
		}
	}
	
	//	�Խ��� �̸� �ҷ����� 
	public ResultSet getCategory() {
		String sql = "select *from board";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("���� ����");
		} 
		return rs;
		
	}
	
	//�Խñ� �����ϱ� 
	public boolean setPost(String category, String name, String pPw, String show, String notice, String title, String contents) {
		boolean check = false;
		String sql = "insert into post values(no_seq.nextval,?,?,?,?,0,?,0,?,SYSDATE,?)";
		
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
			try {
				pstmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return check;
	}
	
	
	//�������� �ҷ����� 
	public ResultSet loadNotice() {
		String sql = "select pNum, title,name, hit, recommend, pdate from post where notice_YN = 'Y' order by pnum desc";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		return rs;
	}
	
	//����Ʈ �ҷ����� 
	public ResultSet loadPost() {
		String sql = "select show_YN, pNum, title, name, hit, recommend, pdate from post order by pnum desc";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				stmt.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return rs;
	}
}
	