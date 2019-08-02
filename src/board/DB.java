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
	boolean check= false;
	
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
	public ResultSet getPostHeader() {
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
	
	//showPost �Խñ� �ҷ����� 
	public ResultSet getPostInfo(int num) {
		String sql = "select title, name, pdate, hit, contents from post where pNum = "+num;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		}catch(SQLException e) {
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
	
	//��õ�� ������Ʈ 
	public boolean updateRecommend(int num) {
		String sql = "update post set recommend = recommend + 1 where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				check = true;
			}else {
				check =false;
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
	
	//��ȸ�� ���� 
	public void updateHit(int num) {
		String sql = "update post set hit = hit +1  where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
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
	}
	
	//��й�ȣ Ȯ�� 
	public int confirmPW(int num, String pPw) {
		String sql = "select pNum, pPw from post where pNum = ? and pPw = ?";
		int flag = 0;
		rs = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.setString(2, pPw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				flag = 1;
			}else {
				flag = 0;
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
		return flag;
	}
	
	public void deletePost(int num) {
		String sql = "delete post where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		
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
	}
	
	//showPost �Խñ� �ҷ����� 
	public ResultSet getModifyPostInfo(int num) {
		String sql = "select name,show_YN, notice_YN, pPw, title, contents from post where pNum = "+num;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		}catch(SQLException e) {
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
	
	public boolean setModifyPost(String category, String name, String pPw, String show, String notice, String title, String contents, int num) {
		String sql = "update post set category = ?, name = ?, pPw = ?, show_YN = ?, notice_YN = ?, title = ?, contents = ?, pDate = SYSDATE where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, name);
			pstmt.setString(3, pPw);
			pstmt.setString(4, show);
			pstmt.setString(5, notice);
			pstmt.setString(6, title);
			pstmt.setString(7, contents);
			pstmt.setInt(8, num);
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
}
	