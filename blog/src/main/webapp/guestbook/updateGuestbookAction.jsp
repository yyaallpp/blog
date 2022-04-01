<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.GuestbookDao"%>
<%@page import="vo.Guestbook"%>
<%
	request.setCharacterEncoding("utf-8");
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); //리스트로 넘어가기
	
	// updateGuestbookForm에서 값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	//디버깅
	System.out.println(guestbookNo + "updateGuestbookAction guestbookNo");
	System.out.println(guestbookPw + "updateGuestbookAction guestbookContent");
	System.out.println(guestbookPw + "updateGuestbookAction guestbookPw");
	
	// 값 guestbook으로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookContent(guestbookContent);
	guestbook.setGuestbookPw(guestbookPw);
	
	//디버깅
	System.out.println(guestbookNo + "updateGuestbookAction guestbookNo");
	System.out.println(guestbookContent + "updateGuestbookAction guestbookContent");
	System.out.println(guestbookPw + "updateGuestbookAction guestbookPw");
	
	// 수정메서드 실행
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.updateGuestbook(guestbook);
%>
