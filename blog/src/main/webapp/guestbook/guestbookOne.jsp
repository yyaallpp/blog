<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Guestbook"%>
<%@ page import="dao.GuestbookDao"%>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo + "GuestbookOne guestbookNo"); // 디버깅
	
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook g = new Guestbook();
	g = guestbookDao.selectGuestbookOne(guestbookNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid m-2">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
		<h1><%=g.getGuestbookNo() %>번 방명록</h1>
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">리스트로</a>
		<table class="table-bordered table-warning">
			<tr>
				<td>guestbookNo</td>
				<td><%=g.getGuestbookNo() %></td>
			</tr>
			<tr>
				<td>guestbookContent</td>
				<td><%=g.getGuestbookContent() %></td>
			</tr>
		</table>
															<!-- 수정 삭제 버튼 -->
		<div>
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%= g.getGuestbookNo() %>">[수정]</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%= g.getGuestbookNo() %>">[삭제]</a>
		</div>
	</div>
</body>
</html>