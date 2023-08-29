package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EvaluationDAO {
	private Connection conn;
	private ResultSet rs;
	public EvaluationDAO() {
		try {

			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";

			String dbID = "root";

			String dbPassword = "0000";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}
	//강의평가 정보를 기록할수있게 해주는 글쓰기함수
	public int write(EvaluationDTO evaluationDTO) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?,?,?,?,?,?,?,?,?,?,?,?,0)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(11, evaluationDTO.getComfortableScore().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			pstmt.setString(12, evaluationDTO.getLectureScore().replaceAll("<","&lt;").replaceAll(">","&gt;").replace("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();

		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getInt(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11),
					rs.getString(12),
					rs.getString(13),
					rs.getInt(14)
				);
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return evaluationList;
	}
	
	public int like(String evaluationID) {
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();

		}

		return -1; // 이메일 등록 설정 실패

	}
	public int delete(String evaluationID) {
		String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();

		}

		return -1; // 이메일 등록 설정 실패

	}
	public String getUserID(String evaluationID) {
		String SQL = "SELECT userID FROM USER WHERE evaluationID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);  // 이메일 등록 여부 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
}