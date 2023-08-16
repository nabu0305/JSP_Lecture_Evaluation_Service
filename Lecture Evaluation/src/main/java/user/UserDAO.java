package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import util.DatabaseUtil;

public class UserDAO {

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else {
					return 0; //비번 틀림
				}
			}
			return -1;
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close(); } catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close(); } catch(Exception e) {e.printStackTrace();}
		}
		return -2; //데이터베이스 
	}
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, false)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(1, user.getUserEmail());
			pstmt.setString(1, user.getUserEmailHash());
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close(); } catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close(); } catch(Exception e) {e.printStackTrace();}
		}
		return -1; //회원가입 실패
	}
}
