<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	// board입력폼카테고리 나오게 하는것
	BoardDao boardDao = new BoardDao();
	ArrayList<String> list = boardDao.bringBoardCategory();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/inc/upMenu.jsp"></jsp:include><!--  상단 바  -->
	<div class="container mt-4 w-75">
		<h1>글 입력</h1>
		<form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
			<table class="table">
				<tr>
					<td>categoryName</td>
					<td>
						<select name="categoryName" class="form-select ">
							<% 
								for(String s : list){ 
							%>
								<option value="<%=s%>"><%=s%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>boardTitle</td>
					<td>
						<input class="form-control" name="boardTitle" type="text">
					</td>
				</tr>
				<tr>
					<td>boardContent</td>
					<td>
						<textarea name="boardContent" rows = "5" cols="130" type="text"> </textarea>
					</td>
				</tr>
				<tr>
					<td>boardPw</td>
					<td>
						<input name="boardPw" type="password">
					</td>
				</tr>
				<tr>
					<td colspan = "2">
						<button type="submit" class="btn btn-danger"> 글 입력</button>
					</td>
			</table>
		</form>
	</div>
</body>
</html>