package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DatabaseUtil;

public class UserDAO {
	
	public int join(String userID, String userPassword) {
		String SQL = "INSERT INTO USER VALUES (?,?)";
		try {
			Connection conn = DatabaseUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL); //물음표에 데이터를 실제로 넣어주는 역할
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			return pstmt.executeUpdate();//INSERT 구문을 실행을 해서 나온 결과를 반환하도록 하는 것
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
