<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage +" <--currentPage");
	
	request.setCharacterEncoding("utf-8"); // 생략가능
	int beginRow = 0;
	int rowPerPage = 10;

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	
	// 최대치 구하기
	int lastPage = 0;
	int totalCount = photoDao.selectPhotoTotalRow();
	lastPage = totalCount/rowPerPage;
	if(totalCount % rowPerPage != 0){
		lastPage++;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
	<!-- 메인 메뉴 시작-->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->	
	<div class = "container-fluid m-2">
		<div class="jumbotron text-center">
			<h1>이미지 목록</h1>	<!--  가운대 글씨 -->
		</div>
		<div class="row">
			<div class="col-sm-1"></div>
			<table class="table-bordered col-sm-10">
				<tr>
				<%
					// 한행에 사진이 5개의 이미지 (tr안에 td가 5개씩)가 나오게하자
					// 이미지가 3개 - tr 1개 - td 5개
					// 이미지가 5개 - tr 1개 - td 5개
					// 이미지가 10개 - tr 2개 - td 10개
					// 이미지가 9개 - tr 2개 - td 10개
					// td의 개수는 5의 배수가 되도록 
					// list.size()가 1~5면 - td는 5개
					// list.size()가 6~10면 - td는 10개
					
					int endIdx = (((list.size()-1)/5)+1)*5; // 무조건 5의 배수가 되어야한다.(한 줄에 5개니까)
					System.out.println(endIdx + "<-- photoList endIdx");
					// for(Photo p : list) {
					for(int i = 0 ; i<endIdx ; i++){
						// tr을 닫고 새로운 tr을 시작
						if(i!=0 && i%5==0){ // 5의 배수일 때(0을 제외한)
					%>
						<tr></tr>
					<%		
						}
						if(i<list.size()){
					%>
							<td>
								<a href="<%=request.getContextPath()%>/photo/photoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
									<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="200" height="200">
									<!--  상세보기에서는 원본이미지 크기로 -->
								</a>
							</td>			
				<%
						} else {
				%>
							<td>&nbsp;</td>
				<% 		}
					}
				%>
							
				</tr>
			</table>
		</div>
		<div  class = "container-fluid m-2 row">
			<div class = "col-sm-1 " ></div>
			<h3><a href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">작성</a></h3>
		</div>
	</div>
</body>
</html>