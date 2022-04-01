<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// guestbookList나 guestbookOne에서 값 받아오기 
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo + "deleteGuestbookForm guestbookNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGusetbookForm</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
	
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!--  상단 바  -->
	<div class= "container mt-4">	
	<br>
		<h1>방명록 삭제</h1>
		<form method ="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
			<input class = "form-control w-50" type="number" name="guestbookNo" value=<%=guestbookNo%> readonly="readonly">
			<div>
				비밀번호 : 
				<input class="form-control w-50" type="password" name="guestbookPw">
				<div>
					<button class="btn btn-danger" type="submit">삭제하기</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>