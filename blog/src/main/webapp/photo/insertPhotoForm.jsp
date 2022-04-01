<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoForm.jsp</title>
</head>
<body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"> <!-- 부트스트랩 4.0 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="container-fluid m-2">
		<h1>이미지 등록</h1>
		<!-- 
			1) form태그안에 값을 넘기는 기본값은 무조건 문자열 -> 파일 자체를 넘길수는 없다.  
			2) 그래서 기본값을 변경해야 한다. -> enctype사용 
			3) multipart/form-data 로 변경
			기본값이 문자열에서 바이너리(이진수)로 변경된다.
			4) 근대 같은 폼안에 모든 값이 바이너리로 넘어가게 된다. 그러면 request.getParameter()를 사용할수가 없음
			5) 복잡한 코드를 통해서만 바이너리 내용을 넘겨 받을 수 있다.
			6) 그래서 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현하자
		-->
		<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">  <!--  이미지는 무조건 post로 -->
			<table class="table">
				<tr>
					<td>이미지파일</td>
					<td><input class="form-control" type="file" name="photo"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input class="form-control" type="password" name="photoPw"></td>
				</tr>
				<tr>
					<td>글쓴이</td>
					<td><input class="form-control" type="text" name="writer"></td>
				</tr>
			</table>
			<button class="btn btn-danger" type="submit">이미지 등록</button>
		</form> 
	</div>
</body>
</html>