<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.GuestbookDao" %>
<%@ page import ="vo.Guestbook" %>
<%@ page import ="java.util.*" %>
<%
 	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 5; // 한페이지에 5개 나오게함
	int beginRow = (currentPage-1)*rowPerPage;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage); // 리스트 나오게 하는 메서드
	
	// 최대치 구하기
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
//	lastPage = (int)Math.ceil((double)totalCount / (double)rowPerPage); 같은거임
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0){
		lastPage++;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
	
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!--  상단 바  -->
		
	<div class="container-fluid m-2">
		<!--  include시 컨텍스명(프로젝트명)을 명시하지 않는다.  -->
		<div class="jumbotron text-center">
			<h1>방명록</h1>	<!--  가운대 글씨 -->
		</div>									
	<!--	  메인 메뉴 끝	 -->
	
		<div class="container-fluid">
		<%
			for(Guestbook g : list){
		%>
			<table class="table-bordered text-center">
				<tr>
					<td><a href="<%=request.getContextPath()%>/guestbook/guestbookOne.jsp?guestbookNo=<%=g.getGuestbookNo()%>"><%=g.getWriter() %></a></td>
					<td><%=g.getCreateDate() %></td>
				</tr>
				<tr>
					<td colspan="2"><%=g.getGuestbookContent() %></td>
				</tr>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">수정</a>
				<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">삭제</a>
			</div>
		<%
			}
		if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 		
			}
		if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		</div>
		
					<!--  방명록 입력 -->
		
		<h1 >방명록 입력</h1>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
			<table class="table-bordered table-warning">
				<tr>
					<td>글쓴이</td>
					<td><input type="text" class="form-control" name="writer"></td>
					<td>비밀번호</td>
					<td><input type="password" class="form-control" name="guestbookPw"></td>
				</tr>
				<tr>
					<td colspan="4"><textarea class="form-control"name="guestbookContent"rows="2" cols="70"></textarea></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-success">입력</button>
		</form>
	</div>
</body>
</html>