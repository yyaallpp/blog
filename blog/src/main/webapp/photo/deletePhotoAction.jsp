<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.Photo"%>
<%@ page import="dao.*"%>
<%@ page import="java.io.*"%>
<%
	// 1) 테이블 데이터 삭제 <- photoNo 필요
	// 2) upload 폴더에 이미지 삭제 <- photoName 필요
	
	// photoNo이 안넘오면 deleteForm으로 돌아가기
	if (request.getParameter("photoNo") == null) {
		response.sendRedirect(request.getContextPath() + "/photo/deletePhotoForm.jsp?msg=null");
		return;
	}
	
	PhotoDao photoDao = new PhotoDao();
	// deletePhotoForm에서 값 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	String photoName = photoDao.selectPhotoName(photoNo);
	//디버깅
	System.out.println(photoNo + "deletePhotoAction photoNo");
	System.out.println(photoPw + "deletePhotoAction photoPw");
	System.out.println(photoName + " <-- deletePhotoAction photoName");
	
	// 값 photo로 묶기
	Photo photo = new Photo();
	photo.getPhotoNo();
	photo.getPhotoPw();
	
	// 1) 데이터 테이블 데이터 삭제 
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	
	if (delRow == 1) {
		String path = application.getRealPath("upload"); // application(현재 프로젝트)안의 upload폴더의 실제 폴더 경로를 변경
		File file = new File(path + "\\" + photoName); // 이미지 파일을 불러온다. java.io.File
		file.delete(); // 이미지 파일을 삭제
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp"); // 리스트로 가기
	} else {
		System.out.println("삭제 실패!");
		response.sendRedirect(request.getContextPath() + "/photo/deletePhotoForm.jsp?photoNo="+photo.getPhotoNo()); // deletePhotoForm으로 가기
	}
	//디버깅
	System.out.println(photo.getPhotoNo() + " deletePhotoAction photoNo");
	System.out.println(photo.getPhotoPw() + " deletePhotoAction photoPw");
%>
