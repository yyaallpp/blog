<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Photo" %>
<%@ page import="dao.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println(photoNo + " <--- photoOne photoNo"); // 디버깅 
	
	PhotoDao photoDao = new PhotoDao();
	Photo photo = new Photo();
	photo = photoDao.selectPhotoOne(photoNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="container-fluid m-2">
		<h1>Photo <%=photo.getPhotoNo() %></h1>
		<table class="table-bordered">
			<tr>
				<td>photoNo</td>
				<td><%=photo.getPhotoNo() %></td>
			</tr>
			<tr>
				<td>photoImg</td>
				<td><img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>" width="200" height="200"></td>
			</tr>
		</table>
															<!-- 삭제 버튼 -->
		<div>
			<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo()%>">삭제</a>
		</div>
	</div>
</body>
</html>