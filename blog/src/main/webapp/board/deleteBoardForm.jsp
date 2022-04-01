<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 	// BoardOne에서 boardNo 값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + "deleteBoardForm");
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>deleteBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> <!--  부트스트랩4 링크 -->
	</head>
	
	<body>
		<jsp:include page="/inc/upMenu.jsp"></jsp:include><!--  상단 바  -->
		
		<div class="container mt-4">		
			<h1>Board 삭제</h1>
			<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp?">
				<input type="text" name="boardNo" value ="<%=boardNo%>"readonly="readonly" class = "form-control w-50">
				<br> <!-- 답답해서 넣음 -->
				<div>
					<h4>비밀번호</h4>
					<input type="password" name="boardPw" class = "form-control w-50">
				</div>
				<br> <!-- 답답해서 넣음 -->
				<div>
					<button type="submit" class="btn btn-danger">삭제</button>
				</div>
			</form>
			
		</div>
	</body>
</html>