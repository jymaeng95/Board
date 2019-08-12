package board;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class DB {
	public static final String dbDriver = "oracle.jdbc.driver.OracleDriver";
	public static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";

	//	DB 연결 
	public Connection loadConnect(){
		Connection con = null;

		try {
			Class.forName(dbDriver);
			con = DriverManager.getConnection(url,"jymaeng95","onlyroot");
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
	public ArrayList getCategory(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select category from board";
		
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBean bean = new UserBean();
				bean.setCategory(rs.getString("category"));
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return list;
	}

	//게시글 저장하기 
	public void setPost(Connection con, Map<String,String> data) {
		PreparedStatement pstmt = null;
		String sql = "insert into post values(no_seq.nextval,?,?,?,?,0,?,0,?,SYSDATE,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, CommonUtil.removeNVL(data.get("category")));
			pstmt.setString(2, CommonUtil.removeNVL(data.get("title")));
			pstmt.setString(3, CommonUtil.removeNVL(data.get("show")));
			pstmt.setString(4, CommonUtil.removeNVL(data.get("notice")));
			pstmt.setString(5, CommonUtil.removeNVL(data.get("name")));
			pstmt.setString(6, CommonUtil.removeNVL(data.get("pPw")));
			pstmt.setString(7, CommonUtil.removeNVL(data.get("contents")));
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closePstmt(pstmt);
		}
	}


	//공지사항 불러오기 (rowNum 추가 필요)
	public ArrayList loadNotice(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("select pNum, title,name, hit, recommend, pDate from post ");
		sql.append("where notice_YN = 'Y' and rownum<=3 order by pnum desc");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBean bean = new UserBean();
				bean.setPnum(rs.getInt("pNum"));
				bean.setTitle(rs.getString("title"));
				bean.setName(rs.getString("name"));
				bean.setHit(rs.getInt("hit"));
				bean.setRecommend(rs.getInt("recommend"));
				bean.setPdate(rs.getString("pDate"));
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return list;
	}

	//포스트 불러오기 
	public ArrayList getPostHeader(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		StringBuilder sql = new StringBuilder();
		sql.append("select show_YN, pNum, title, name, hit, recommend, pdate ");
		sql.append("from post order by pnum desc");
		
		try {	
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBean bean = new UserBean();
				bean.setShow(rs.getString("show_YN"));
				bean.setPnum(rs.getInt("pNum"));
				bean.setTitle(rs.getString("title"));
				bean.setName(rs.getString("name"));
				bean.setHit(rs.getInt("hit"));
				bean.setRecommend(rs.getInt("recommend"));
				bean.setPdate(rs.getString("pdate"));
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return list;
	}

	public int getNextPnum(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		String sql = "select pNum from post where rownum<=1 order by pNum desc";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt("pNum") + 1; 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return num;
	}
	
	//showPost 게시글 불러오기 
	public ArrayList getPostInfo(Connection con, int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		StringBuilder sql = new StringBuilder();
		sql.append("select name,show_YN, notice_YN, pPw, title, contents, pDate, hit ");
		sql.append("from post where pNum = ?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				UserBean bean = new UserBean();
				bean.setName(rs.getString("name"));
				bean.setShow(rs.getString("show_YN"));
				bean.setNotice(rs.getString("notice_YN"));
				bean.setPpw(rs.getString("pPw"));
				bean.setTitle(rs.getString("title"));
				bean.setContents(rs.getString("contents"));
				bean.setPdate(rs.getString("pDate"));
				bean.setHit(rs.getInt("hit"));
				list.add(bean);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return list;
	}

	//추천수 업데이트 
	public boolean updateRecommend(Connection con, int num) {
		PreparedStatement pstmt = null;
		boolean check = false;
		String sql = "update post set recommend = recommend + 1 where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			return pstmt.executeUpdate() > 0 ;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closePstmt(pstmt);
		}
		return check;
	}

	//조회수 증가 
	public void updateHit(Connection con, int num) {
		PreparedStatement pstmt = null;
		String sql = "update post set hit = hit +1  where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closePstmt(pstmt);
		}
	}

	//비밀번호 확인 
	public int confirmPW(Connection con, int num, String pPw) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select pNum, pPw from post where pNum = ? and pPw = ?";
		int flag = 0;
	
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.setString(2,pPw);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				flag = 1;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeRs(rs);
			closePstmt(pstmt);
		}
		return flag;
	}

	//포스트 삭제 
	public void deletePost(Connection con, int num) {
		PreparedStatement pstmt = null;
		String sql = "delete post where pNum = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closePstmt(pstmt);
		}
	}
	

	public boolean setModifyPost(Connection con, Map<String, String> data) {
		PreparedStatement pstmt = null;
		boolean check = false;
		
		StringBuilder sql = new StringBuilder();
		sql.append("update post set category = ?, name = ?, pPw = ?, show_YN = ?,");
		sql.append("notice_YN = ?, title = ?, contents = ?, pDate = SYSDATE where pNum = ?");
	
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, CommonUtil.removeNVL(data.get("category")));
			pstmt.setString(2, CommonUtil.removeNVL(data.get("name")));
			pstmt.setString(3, CommonUtil.removeNVL(data.get("pPw")));
			pstmt.setString(4, CommonUtil.removeNVL(data.get("show")));
			pstmt.setString(5, CommonUtil.removeNVL(data.get("notice")));
			pstmt.setString(6, CommonUtil.removeNVL(data.get("title")));
			pstmt.setString(7, CommonUtil.removeNVL(data.get("contents")));
			pstmt.setInt(8, Integer.parseInt(data.get("pNum")));
			
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closePstmt(pstmt);
		}
		
		return check;
	}
	
	//PreparedStatement, Statement 종료
	public void closePstmt(PreparedStatement pstmt) {
		try {
			if(pstmt!=null)
				pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void closeRs(ResultSet rs) {
		try {
			if(rs!=null)
				rs.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
