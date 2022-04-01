<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// ----------------------------- 페이징 ----------------------------------
	// boardList페이지 시작시 최근 10개의 목록을 보여준다.그것이 1페이지가 된다.
	int currentPage = 1; // 무조건 현재페이지의 기본값은 1이다. --> 1page라는 의미
	if(request.getParameter("currentPage") != null){
		// 값이 null이 아니다 -> 이전이나 다음을 눌렀다는 이야기
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage");
	
	// 이전, 다음링크에서 categoryName을 null값을 넘기기가 불가능하여 null을 공백으로 치환
	String categoryName = "";
	if(request.getParameter("categoryName") !=null){
		categoryName =request.getParameter("categoryName");
	}
	System.out.println(request.getParameter("categoryName") + "<--categoryName"); // 디버깅			
	
	// !!!!!!!!!!!!!!!!!!버그 이슈!!!!!!!!!!!!!!!!!!!!!!! --> 완료
	// 1) 카테고리 선택후 다음을 누르면 전체 카테고리로 나온다 ex) 맛집 누르고 다음누르면 전체 리스트 다음이 나옴
	// 2) 데이터가 마지막이 나오고 그 다음에 다음을 또 누르면 오류가나온다. 즉 마지막까지 가도 안끝난다.
	// !!!!!!!!!!!!!!!!!!버그 이슈!!!!!!!!!!!!!!!!!!!!!!!`	1
	// 페이지 번호만 바뀌는 것이 아닌 boardList의 내용이 바뀌어야한다.
	// boardSql의 쿼리문에서 DESC LIMIT <<<<<0,10>>>>>>; <>안의 내용이 바껴야한다.
	/*
		**오라클은 1부터 시작 mariaDb는 0부터 시작**
		select ..... LIMIT 0,10
	--> select ..... LIMIT ?,10로 바꾸기			
		알고리즘(패턴)
		page	beginRow
		1		0
		2		10
		3		20
		?		(current-1)*10
	*/
	
	int rowPerPage = 10; // 한 페이지에 얼마나 title이 나오는 지
	int beginRow = (currentPage-1)*rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터가 변경된다.
	
	
	// -----------------------------------------CATEGORY------------------------------------------
	// category List 나오게 하기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.showCategory();
	
	//----------------------------------------BOARDLIST-------------------------------------------
	// mariadb 접속
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn"); // 디버깅
	
	String boardSql = null; // board 쿼리문
	PreparedStatement boardStmt = null; // board stmt 2가지의 경우가 있으니 null로 초기화
	if(categoryName.equals("")){ // null일때
		boardSql = "SELECT board_no boardNo,category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?,?";
		boardStmt = conn.prepareStatement(boardSql);
		// ? 채우기 beginRow, rowPerPage
		boardStmt.setInt(1,beginRow);
		boardStmt.setInt(2,rowPerPage);
	} else{ // null이 아닐 때
		boardSql = "SELECT board_no boardNo,category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?,?";
		boardStmt = conn.prepareStatement(boardSql);
		// ?채우기 categoryName,beginRow,rowPerPage
		boardStmt.setString(1,categoryName);
		boardStmt.setInt(2,beginRow);
		boardStmt.setInt(3,rowPerPage);
	}
	
	ResultSet boardRs = boardStmt.executeQuery();
	System.out.println(boardSql);	// 디버깅
	
	ArrayList<Board> boardList = new ArrayList<Board>(); // ArrayList만들기
	while(boardRs.next()){
		Board b = new Board(); // Board 생성
		// 값 넣기 
		b.setBoardNo(boardRs.getInt("boardNo"));
		b.setCategoryName(boardRs.getString("categoryName"));
		b.setBoardTitle(boardRs.getString("boardTitle"));
		b.setCreateDate(boardRs.getString("createDate"));
		boardList.add(b); // 리스트 넣기
		
		// 디버깅
		System.out.println(b.getBoardNo() + " <--boardList b.boardNo");
		System.out.println(b.getCategoryName() + " <--boardList b.categoryName");
		System.out.println(b.getBoardTitle() + " <--boardList b.boardTitle");
		System.out.println(b.getCreateDate() + " <--boardList b.createDate");
	}
	
	// -------------------- 최대치 구하기 --------------------------
	
	/*  마지막 페이지면 나오면 안된다. 
		마지막 페이지 구하기 알고리즘
	전체행		마지막 페이지?
	~10				1
	11~20			2
	21~30			3
	31~40			4
	마지막 페이지 = 전체행/rowPerPage
	*/
	
	int totalRow = 0; // ==> select count(*) from board -> 총 개수를 구하는 것
	String totalRowSql = "select count(*) cnt from board";
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
	
	System.out.println(totalRowStmt + " <-- BoardList totalRowStmt");// 디버깅
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	
	if(totalRowRs.next()){
		totalRow = totalRowRs.getInt("cnt");
		System.out.println(totalRow + "<-- totalRowRS");
	}
	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0){ // 0으로 나누어떨어질 때
		lastPage = totalRow / rowPerPage;
	} else{ // 그외 나머지 ex) 21,22,31~39 .... 등등
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> <!--  부트스트랩4 링크 -->
	
</head>
<body>

	<!--  상단바 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	
	<div class="container-fluid m-2">
	
							<!-- -------------------------------category별 게시글 링크 메뉴 ------------------------------------>
		<div>
		<ul class="list-group list-group-horizontal"> <!--  리스트 그룹으로 함 -->
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
		  <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ">
		  	<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"> <%=m.get("categoryName")%> </a>
		  	<span class="badge badge-primary badge-pill"><%=m.get("cnt")%></span> <!--  게시물의 수 -->
		  </li>
			<%		
				}
			%>
		</ul>
		</div>
									<!---------------------------------  게시글 목록(리스트) ------------------------------------->
											<!--  게시글 목록 을 누르면 카테고리 전체가 다 포함된 List가 나오도록 함 -->	
														<!-- categoryName을 공백으로 처리함 -->
			
		<div class="jumbotron text-center">
			<h1 class ="mt-4">
			<a class ="text-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName="" ">게시글 목록(<%=totalRow%>개) (누르면 초기 List 나옴)</a>
			</h1>
		</div>
		
			<a class ="mt-2" href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글 입력</a>
		
		<div class= "container-fluid row">
			<table class = "table col-sm-12 text-center">
				<thead class="thead-dark">
					<tr>
						<th>categoryName</th>
						<th>boardTitle</th>
						<th>createDate</th>
					</tr>
				</thead>
				<tbody>
					<% 
						for(Board b : boardList) { 
					%>
						<tr>
							<td><%=b.getCategoryName()%></td>
							<td>
								<!--  누르면 상세보기 -->
								<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a>
							</td>
							<td><%=b.getCreateDate()%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>	
		</div>
									<!----------------------------------  다음 이전 버튼 ----------------------------------------->
		<div>
			<!-- 페이지가 만약 10페이지였다면 -> 이전을 누르면 9페이지가 되고 다음을 누르면 11페이지가 되어야한다.  -->
			<%
				if(currentPage >1){ // 현재 페이지가 1보다 작으면 나오면 안된다. 
			%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
			<%
				}
				if(currentPage <lastPage){
			%>
										<!-- 문자열은 null값을 넘길수 없다. -> 공백으로 처리한다. -->
			<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>
			<%
				}
			%>
		</div>
	
	</div>	<!--  container div닫기 -->	
</body>
</html>