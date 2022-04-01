<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//guestbookList나 guestbookOne에서 값 받아오기 
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo + "updateGuestbookForm guestbookNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
		<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!--  상단 바 -->
		
	<div class= "container mt-4">	
		<br>	
		<h1>수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
			<table class="table-bordered">
				<tr>
					<td>guestbookNo</td>
					<td>
						<input class = "form-control" type="text" name="guestbookNo" value ="<%=guestbookNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>guestbookContent</td>
					<td>
						<input class = "form-control" type="text" name="guestbookContent">
					</td>
				</tr>		
				<tr>
					<td>guestbookPw</td>
					<td>
						<input class = "form-control" type="password" name="guestbookPw" >
					</td>
				</tr>
			</table>
			<button class="btn btn-danger" type = "submit">수정</button>
		</form>
	</div>
</body>
</html>