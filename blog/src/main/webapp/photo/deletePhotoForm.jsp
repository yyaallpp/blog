<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Photo" %>
<%@ page import="dao.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println(photoNo + " <--- photoOne photoNo"); // 디버깅 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePhotoForm</title>
</head>
<body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="container mt-4">
		<h1>삭제</h1>
		<form method ="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
			<input class="form-control w-50" type="number" name="photoNo" value=<%=photoNo%> readonly="readonly">
			<div>
				비밀번호 : 
				<input class="form-control w-50" type="password" name="photoPw">
				<div>
					<button class="btn btn-danger" type="submit">삭제하기</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>