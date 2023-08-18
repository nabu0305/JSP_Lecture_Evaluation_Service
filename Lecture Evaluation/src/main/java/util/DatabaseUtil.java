package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	 //실제로 데이터베이스와 연동된 상태인 연결자체를 관리
	public static Connection getConnection() { //함수를 다른 라이브러리에서 사용하기 쉽도록 static 사용
		//try catch 오류가 발생했을때 오류를 쉽게 처리해주기 위해 사용
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation"; // mysql에 접속하기위한 명령어
			String dbID = "root";
			String dbPassword = "0000";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword); 
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
