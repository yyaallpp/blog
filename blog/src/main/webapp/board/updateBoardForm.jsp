<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import ="vo.Board" %>
<%@ page import="dao.*" %>
<%
	// 값 받아오기 -> BoardOne으로 부터 boardNo가져오기
	System.out.println("---------------updateBoardForm---------------");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + " <-- 받아온 boardNo"); // 디버깅
	
	// boardOne의 정보가져오기
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	board = boardDao.selectBoardOne(boardNo); // 메서드 사용
	
	// 카테고리 리스트 가져오기 --> category_title에 쓸거임	
	ArrayList<String> categoryList = new ArrayList<String>(); // ArrayList 만들기
	categoryList = boardDao.bringBoardCategory(); // 메서드 사용

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateBoardForm</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> <!--  부트스트랩4 링크 -->
	</head>
	
	<body>
		<jsp:include page="/inc/upMenu.jsp"></jsp:include><!--  상단 바  -->
		
		<div class="container mt-4">	
			<h1>수정</h1>
																	<!--  수정 내용 -->
			<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
				<table class = "table table-bordered">
					<tr>
						<td>boardNo</td>
						<td>
							<input type="text" name="boardNo" value = "<%=board.getBoardNo()%>" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>categoryName</td>
						<td>
							<select name="categoryName" class= "form-select">
								<%
									for(String s : categoryList) {
										if(s.equals(board.getCategoryName())) {
								%>
												<!--  selected로 안하면 실행은 되지만 이상한 오류가 생김 -->
											<option selected="selected" value="<%=s%>"><%=s%></option>
								<%
										} else {
								%>				<!--  선택이 안됬을 때 -->
											<option value="<%=s%>"><%=s%></option>
								<%		
										}
									}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>boardTitle</td>
						<td>
							<input type="text" name="boardTitle" class = "form-control" value = "<%=board.getBoardTitle()%>">
						</td>
					</tr>
					<tr>
						<td>boardContent</td>
						<td>
							<textarea rows="6" cols="80"  name="boardContent" value = "<%=board.getBoardContent()%>"> </textarea> 
						</td>
					</tr>
					<tr>
						<td>boardPw</td>
						<td>
							<input type="password" name="boardPw" value ="">
						</td>
					</tr>
				</table>
				<button type = "submit" class="btn btn-danger">수정</button>
			</form>
			
		</div> 
	</body>
</html>