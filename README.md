# JSP_Lecture_Evaluation_Service

## 위 프로젝트는 동빈나님의 강의를 보고 만들었습니다
https://ndb796.tistory.com/35


# 프로젝트 개발 순서
<li>개발환경 구축하기</li>
<li>웹 디자인 개발하기</li>
<li>데이터베이스 구축하기</li>
<li>웹 서버 프로그램 개발하기</li>
<li>기능 테스트하기</li>
<li>배포 및 유지보수</li>


## 개발환경 구축하기

### 자바 설치
제어판 -> 시스템 -> 고급 시스템 설정 -> 환경 변수 -> Path 더블클릭 -> 새로 만들기 -> 자바 경로 설정 -> 시스템 변수 JAVA_HOME(개발자들의 약속) 만들기

cmd -> javac입력(뭐가 여러개 나오면 정상)

### 이클립스 설치
eclipse JAVA EE Developers로 설치

### 톰캣 설치
Tomcat Windows zip 설치
bin -> startup으로 서버 실행 -> localhost:8080 크롬에 입력 -> 톰캣 홈페이지 뜨면 정상

### 이클립스 jsp 파일 생성
eclipse -> Dynamic Web Project -> name입력 -> Target runtime 설치한 톰캣 버전 설정 -> 경로 설정 -> Finish

Hello World -> src -> main -> webapp -> index.jsp 파일 생성

### mysql JSP 연동

```sql
CREATE DATABASE TUTORIAL;
USE TUTORIAL;
CREATE TABLE USER (
userID VARCHAR(20),
userPassword VARCHAR(64)
);
SHOW TABLES;
INSERT INTO USER VALUES('1','123');
SELECT * FROM USER
SELECT userID FROM USER
```
속성 입력  VARCHAR(문자열이 들어가는 공간) <br>
INSERT(자신이 만든 테이블에 데이터를 넣어줄때 씀)

### DTO (Data Transfer Object)
 JSP 프로그램안에서 일시적으로 하나의 데이터 단위를 담기위한 용도로 정의된 객체
 
Java Resources -> src -> Package 생성(user)테이블에서 만든 이름과 일반적으로 동일하게 만듬 -> user안에 UserDTO클래스 생성


```java
  String userID;
	String userPassword;
  //우클릭 -> source -> Generate Getters and Setters 클릭후 전부 생성하면 아래같은 코드 생성
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
```

getter는 현재 기록하는 데이터를 가져오는 것
setter 어떠한 데이터를 기록하는 명령어


### DAO(Data Access Object)

실질적으로 데이터베이스와 연동되어 실제로 데이터 베이스에 내용을 기록하고 내용을 가져오는 역할

### 데이터 베이스 접근하는 방법

Java Resources -> Package(util)생성 -> DatabaseUtil 클래스 생성

```java
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	 //실제로 데이터베이스와 연동된 상태인 연결자체를 관리
	public Connection getConnection() {
		//try catch 오류가 발생했을때 오류를 쉽게 처리해주기 위해 사용
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL"; // mysql에 접속하기위한 명령어
			String dbID = "root";
			String dbPassword = "0000";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword); //mysql에 로그인해서 접속한 상태자체를 반환
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
```


UserDAO로 가서 사용 회원가입 함수
```java 
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

```


index.jsp에 회원가입 페이지 생성
```jsp
<body>
	Hello World!
	//회원가입 요청을 처리해주는 액션페이지라고 정의
	//post같은 경우 외부에 데이터가 노출되지않는 방식으로 전달되서 약간이라도 보안성이 뛰어난 방식
	<form action = "./userJoinAction.jsp" method= "post">
		<input type="text" name="userID">
		<input type="password" name="userPassword">
    <input type="submit" value="회원가입"> 
	</form>
</body>
```


# 본격적인 강의평가 사이트 만들기

### 부트스트랩
http://getbootstrap.com/docs/4.0/getting-started/download/ -> Compiled CSS and JS를 다운로드<br>
부트스트랩은 일종의 프레임워크이다 <br>
프레임 워크는 일반적으로 하나의 틀을 의미하기 때문에 틀을 바꾸기는 쉽지않다<br>
반면에 라이브러리는 일반적으로 프레임워크보다 규모가 더 작고 프레임워크 안에 포함되어있다.<br>
프레임워크를 쓰기 위해서는 여러 라이브러리가 필요한데 그 중 제이쿼리가 있다.<br>




webapp 안에 css 폴더 생성 -> js 폴더 생성 -> css안에 bootstrap.min.css 삽입 -> js안에 bootstrap.min.js


### 제이쿼리

https://jquery.com/download/	->      Download the compressed, production jQuery 3.7.0 다운

### 파퍼
https://unpkg.com/popper.js@1.12.9/dist/umd/popper.min.js -> 복사후 js폴더안에 파일을 만들어서 붙혀서 사용

부트스트랩 프레임워크의 내부 로직에 사용되는 파퍼 자바스크립트 라이브러리를 다운

### Custom.css

프레임워크에는 색상이라던지 전반적인게 정해져있는데 바꿔서 사용하고싶을때 따로 custom.css를 만들어서 덮어쓰기 형식으로 사용하는 것이 일반적이다.<br>
가장 많이 사용하는 것 중에 하나가 웹 폰트이다.<br>
https://fonts.google.com/earlyaccess 폰트 사이트

```css
/*부트스트랩같은경우는 네비게이션바 안에 있는 로고들을 정의를 navbar-brand로 한다.*/
@import url(https://fonts.googleapis.com/earlyaccess/jejugothic.css);
@import url(https://fonts.googleapis.com/earlyaccess/nanumgothic.css);
.navbar-brand, h1, h2, h3 ,h4{
	font-size: 'Jeju Gothic';
}
h5{
	font-family: 'Jeju Gothic';
	font-size: 18px;
}
body{
	font-family: 'Nanum Gothic';
}
```
