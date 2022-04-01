<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.GuestbookDao"%>
<%@page import="vo.Guestbook"%>
<%
	request.setCharacterEncoding("utf-8");
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 리스트로 가기
	
	// deleteGuestbookForm에서 값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	//디버깅
	System.out.println(guestbookNo + "deleteGuestbookAction guestbookNo");
	System.out.println(guestbookPw + "deleteGuestbookAction guestbookPw");
	
	// 값 guestbook으로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	
	//디버깅
	System.out.println(guestbookNo + "deleteGuestbookAction guestbookNo");
	System.out.println(guestbookPw + "deleteGuestbookAction guestbookPw");
	
	// 삭제메서드 실행
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.deleteGuestbook(guestbook.getGuestbookNo(),guestbook.getGuestbookPw());
%>
