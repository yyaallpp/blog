<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.catalina.core.AprLifecycleListener"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="java.io.File"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%
	/* 
	form 태그의 enctype="multipart/form-data로 넘겨져서 request.getParameter() API를 사용할 수 없다.
	String writer = request.getParameter("writer");
	System.out.println(writer);
	request.getParameter() API 대신 다른 API를 사용해야 하는데 너무 복잡하다.
	--> 해결책 / request를 단순하게 사용하게 해주는 cos.jar 같은 API(외부라이브러리)를 사용하자
	*/
	request.setCharacterEncoding("utf-8"); // 생략가능
	// MultipartRequest multiReq = new MultipartRequest(request, "폴더",사이즈(byte));
	// 2^10 byte = 1kbyte 1024 byte = 1kbte
	// 2^10 kbyte = 1mbyte
	// 100 mbyte = 1024 * 1024 *100 byte = 104857600 byte
	// 곱셉을 계산해서 코딩하면 가독성이 떨어진다.
	String path= application.getRealPath("upload"); // application 변수는 톰켓자체를 가리킨다.
	System.out.println(path); 

	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); // 동일한 이름이 나오면 알아서 이름을 바꿔줌
	MultipartRequest multiReq = new MultipartRequest(request,path,1024 * 1024 *100,"utf-8",rp);
	
	String photoPw = multiReq.getParameter("photoPw");
	String writer = multiReq.getParameter("writer");
	
	// <input type="file" name="photo">
	String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
	String photoName = multiReq.getFilesystemName("photo"); //new MultipartRequest()객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo");
	
	System.out.println(photoPw + " <-- photoPw");
	System.out.println(writer + " <-- writer");
	System.out.println(photoOriginalName + " <-- photoOriginalName");
	System.out.println(photoName + " <-- photoName");
	System.out.println(photoType + " <-- photoType");
	
	// 파일업	로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")){
		PhotoDao photoDao = new PhotoDao();
		// 값 정리
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer);
		// 데이터 넣기
		photoDao.insertPhoto(photo); // 메서드실행
		
		System.out.println("db고고!");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	} else{
		// 업로드 취소
		System.out.println("이미지 파일만 업로드");
		// 잘못 들어온 파일이므로 업로드된 파일을 지우고 폼으로 이동해야함
		File file = new File(path+"\\"+ photoName); // 잘못된 파일을 불러온다.
		file.delete();
		response.sendRedirect(request.getContextPath()+"/photo/insertPhotoForm.jsp");
	}
	
	
%>