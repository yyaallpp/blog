<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<% 
	// boardList에서 boardNo받아오기 
	// String으로 오니 int로 변환
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println("--------------BoardOne-------------------");
	System.out.println(boardNo + " <-- boardList에서 받아온 boardOne의 boardNo"); // 디버깅
	
	// ---------------------  카테고리 메뉴 ---------------------------------
	// category List 나오게 하기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.showCategory();

	// ---------------------------------- BoardOne의 정보 --------------------------------------------------
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.selectBoardOne(boardNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardOne</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> <!--  부트스트랩4 링크 -->
	</head>
	
	<body>
		<div class="container-fluid m-2">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
														<!-- category별 게시글 링크 메뉴 -->
			<div>
			<ul class="list-group list-group-horizontal mt-4"> <!--  리스트 그룹으로 함 -->
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
																<!--  board 내용 -->
			<h1 class= "mt-4"><%=board.getBoardNo() %>번 Board</h1>
			<!--  boardList 초기화면으로 가기 -->
			<div>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp">초기화면(BoardList)으로</a>
			</div>
			<table class="table table-striped table-bordered w-75">
							<!-- boardPw는 값은 있지만 표시는 안함 -->
				<tr>
					<td>boardNo</td>
					<td><%=board.getBoardNo() %></td>
				</tr>
				<tr>
					<td>categoryName</td>
					<td><%=board.getCategoryName() %></td>
				</tr>
				<tr>
					<td>boardTitle</td>
					<td><%=board.getBoardTitle() %></td>
				</tr>
				<tr>
					<td>boardContent</td>
					<td><%=board.getBoardContent() %></td>
				</tr>
				<tr>
					<td>createDate</td>
					<td><%=board.getCreateDate() %></td>
				</tr>
				<tr>
					<td>updateDate</td>
					<td><%=board.getUpdateDate() %></td>
				</tr>			
			</table>
																<!-- 수정 삭제 버튼 -->
			<div>
				<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">[수정]</a>
				<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">[삭제]</a>
			</div>
		
		</div> <!--  container div닫기 -->	
	</body>
</html>