<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page  import = "java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>

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
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lecturDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch (Exception e){
			
		}
	}
	String userID = null;
	if(session.getAttribute("userID")!= null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false){
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return; 
	}
%>
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
					
<%
	if(userID == null) {
%>
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>
<%
	} else {
%>
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}

%>
					</div>
				</li>
			</ul>
			<form action = "./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class ="container">
		<form method="get" action= "./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공"<%if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
				<option value="교양"<%if(lectureDivide.equals("교양")) out.println("selected"); %>>>교양</option>
				<option value="기타"<%if(lectureDivide.equals("기타")) out.println("selected"); %>>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순"<%if(searchType.equals("추천순")) out.println("selected"); %>>전공</option>
				</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력해주세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<!-- 부트스트랩에서는 Modal이라는걸 제공하는데  웹페이지 윗쪽에 등장하는 하나의 등록양식과 같은 특이한 양식-->
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
	for(int i = 0; i < evaluationList.size(); i++) {
		if(i == 5) break;
		EvaluationDTO evaluation = evaluationList.get(i);
%>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left"><%=evaluation.getLectureName()%>&nbsp;<small><%=evaluation.getProfessorName()%></small></div>
            <div class="col-4 text-right">
              종합 <span style="color: red;"><%=evaluation.getTotalScore()%></span>
            </div>
          </div>
        </div>
        <div class="card-body">
          <h5 class="card-title">
            <%=evaluation.getEvaluationTitle()%>&nbsp;<small>(<%=evaluation.getLectureYear()%>년 <%=evaluation.getSemesterDivide()%>)</small>
          </h5>
          <p class="card-text"><%=evaluation.getEvaluationContent()%></p>
          <div class="row">
            <div class="col-9 text-left">
              성적 <span style="color: red;"><%=evaluation.getCreditScore()%></span>
              널널 <span style="color: red;"><%=evaluation.getComfortableScore()%></span>
              강의 <span style="color: red;"><%=evaluation.getLectureScore()%></span>
              <span style="color: green;">(추천: <%=evaluation.getLikeCount()%>)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">삭제</a>
            </div>
          </div>
        </div>
      </div>
<%
	}
%>
	</section>
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
<%
	if(pageNumber <= 0) {
%>     
        <a class="page-link disabled">이전</a>
<%
	} else {
%>
		<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>&searchType=
<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=<%= pageNumber-1 %>">이전</a>>
<%
	}
%>
      </li>
      <li class="page-item">
<%
	if(evaluationList.size() < 6) {
%>     
        <a class="page-link disabled">다음</a>
<%
	} if(evaluationList.size() >= 6) {
%>

<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>&searchType=
<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=<%= pageNumber+1 %>">다음</a>
<%
	}
%>
		</li>
		</ul>
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
								<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
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
								<input type="text" name="reportTitle" class="form-control" maxlength="30">
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