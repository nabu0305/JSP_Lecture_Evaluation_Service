<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가 웹 사이트</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<!-- 밝은 하얀색 네이게이션 바 제공 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원 관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					</div>
				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class ="container">
		<form method="get" action"./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력해주세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<!-- 부트스트랩에서는 Modal이라는걸 제공하는데  웹페이지 윗쪽에 등장하는 하나의 등록양식과 같은 특이한 양식-->
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">컴퓨터개론&nbsp;<small>이민준</small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					정말 좋은 강의에요.&nbsp;<small>(2017년 가을학기)</small>
				</h5>
				<p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운건 없지만 학점이 잘나와요
				<div class="row">
					<div class="col-9 text-left">
						성적<span style="color: red;"> A </span>
						널널<span style="color: red;"> B </span>
						강의<span style="color: red;"> B </span>
						<span style="color: green;">(추천: 15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evalutionID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evalutionID=">삭제</a>
						
					</div>
				</div>
			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">알고리즘&nbsp;<small>홍길동</small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					안녕하세요 홍길동입니다 호형호제라 유명하죠&nbsp;<small>(2018년 1학기)</small>
				</h5>
				<p class="card-text">알고리즘이라 어려워요
				<div class="row">
					<div class="col-9 text-left">
						성적<span style="color: red;"> C </span>
						널널<span style="color: red;"> B </span>
						강의<span style="color: red;"> B </span>
						<span style="color: green;">(추천: 10)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evalutionID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evalutionID=">삭제</a>
						
					</div>
				</div>
			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">하드웨어&nbsp;<small>조광현</small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;">B</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					제 수업은 많이 먹습니다&nbsp;<small>(2023년 1학기)</small>
				</h5>
				<p class="card-text">교수님이 많이 먹어요
				<div class="row">
					<div class="col-9 text-left">
						성적<span style="color: red;"> A </span>
						널널<span style="color: red;"> A </span>
						강의<span style="color: red;"> C </span>
						<span style="color: green;">(추천: 20)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evalutionID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evalutionID=">삭제</a>
						
					</div>
				</div>
			</div>
		</div>
	</section>
		<!-- 모달 양식 -->
		<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<!-- modal dialog로 전반적으로 하나의 모달창임을 알려줌 -->
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">평가 등록</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="./evaluationRegisterAction.jsp" method="post">
							<!--row같은 경우 하나의 행을 여러개 열로 나눌때 사용 그리고 보통 12열사용 col-sm-으로 구분-->
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>강의명</label>
									<input type ="text" name="lectureName" class="form-control" maxlength="20">
								</div>
								<div class="form-group col-sm-6">
									<label>교수명</label>
									<input type ="text" name="professorName" class="form-control" maxlength="20"> 
								</div> 
							</div>
							<div class="form-row">
								<div class="form-group col-sm-4">
									<label>수강연도</label>
									<select name="lectureYear" class="form-control">
										<option value="2020">2020</option>
										<option value="2021">2021</option>
										<option value="2022">2022</option>
										<option value="2023" selected>2023</option>
										<option value="2024">2024</option>
										<option value="2025">2025</option>
										<option value="2026">2026</option>
										<option value="2027">2027</option>
										<option value="2028">2028</option>
									</select>
								</div>
								<div class="form-group col-sm-4">
									<label>수강 학기</label>
									<select name="semesterDivide" class="form-control">
										<option value="1학기" selected>1학기</option>
										<option value="여름학기">여름학기</option>
										<option value="2학기">2학기</option>
										<option value="겨울학기">겨울학기</option>
									</select>
								</div> 
								<div class="form-group col-sm-4">
									<label>강의 구분</label>
									<select name="lectureDivide" class="form-control">
										<option value="전공" selected>전공</option>
										<option value="교양">교양</option>
										<option value="기타">기타</option>
									</select>
								</div> 
							</div>
							<div class="form-group">
								<label>제목</label>
								<input type="text" name="evalutionTime" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="evalutionContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-3">
									<label>종합</label>
									<select name="totalScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B" >B</option>
										<option value="C" >C</option>
										<option value="D" >D</option>
										<option value="F" >F</option>
									</select>
								</div>
								<div class="form-group col-sm-3">
									<label>성적</label>
									<select name="creditScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B" >B</option>
										<option value="C" >C</option>
										<option value="D" >D</option>
										<option value="F" >F</option>
									</select>
								</div>
								<div class="form-group col-sm-3">
									<label>널널</label>
									<select name="comfortableScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B" >B</option>
										<option value="C" >C</option>
										<option value="D" >D</option>
										<option value="F" >F</option>
									</select>
								</div>
								<div class="form-group col-sm-3">
									<label>강의</label>
									<select name="lectureScore" class="form-control">
										<option value="A" selected>A</option>
										<option value="B" >B</option>
										<option value="C" >C</option>
										<option value="D" >D</option>
										<option value="F" >F</option>
									</select>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary">등록하기</button>
							</div>	
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<!-- modal dialog로 전반적으로 하나의 모달창임을 알려줌 -->
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">신고하기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="./reportAction.jsp" method="post">
							
							<div class="form-group">
								<label>신고 제목</label>
								<input type="text" name="reptorTime" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>신고 내용</label>
								<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-danger">신고하기</button>
							</div>	
						</form>
					</div>
				</div>
			</div>
		</div>
		<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFF;">
			Copyright &copy; 2023 이민준 All Rights Reserved.
		</footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.min.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>