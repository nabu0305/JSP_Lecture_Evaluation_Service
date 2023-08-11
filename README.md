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

제어판 -> 시스템 -> 고급 시스템 설정 -> 환경 변수 -> Path 더블클릭 -> 새로 만들기 -> 자바 경로 설정 -> 시스템 변수 JAVA_HOME(개발자들의 약속) 만들기

cmd -> javac입력(뭐가 여러개 나오면 정상)


eclipse JAVA EE Developers로 설치

Tomcat Windows zip 설치
bin -> startup으로 서버 실행 -> localhost:8080 크롬에 입력 -> 톰캣 홈페이지 뜨면 정상


eclipse -> Dynamic Web Project -> name입력 -> Target runtime 설치한 톰캣 버전 설정 -> 경로 설정 -> Finish

Hello World -> src -> main -> webapp -> index.jsp 파일 생성
