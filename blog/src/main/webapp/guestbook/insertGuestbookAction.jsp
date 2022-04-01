<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import ="vo.Guestbook" %>
<%
	request.setCharacterEncoding("utf-8");
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	
	// guestbookList에서 writer, guestbookPw, guestbookContent 받아오기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	// Guestbook으로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setWriter(writer);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	System.out.println(" ------------- insertGuestAction ----------------------");
 	System.out.println(guestbook.getWriter() + " <-- insertguestAction writer");
 	System.out.println(guestbook.getGuestbookPw() + " <-- insertguestAction guestbookPw");
 	System.out.println(guestbook.getGuestbookContent() + " <-- insertguestAction guestbookContent");
 	
 	// GuestbookDao에서 insertGuestbook(Guestbook guestbook) 호출하기
 	GuestbookDao guestbookDao = new GuestbookDao();
 	guestbookDao.insertGuestbook(guestbook);
 	
	
%>
