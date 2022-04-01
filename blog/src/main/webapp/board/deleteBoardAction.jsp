<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="vo.Board" %>
<%@page import="dao.*"%>
<%
	request.setCharacterEncoding("utf-8"); // 한글 인코딩
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp"); // 리스트로 가기
	
	// deleteBoardForm에서 값 받아오기
	// boardNo, boardPw
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	// 정보 가공하기 --> Board로 묶기
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardPw(boardPw);
	
	// 디버깅
	System.out.println(" ----------- deleteBoardAction ----------");
	System.out.println(board.getBoardNo() + " <-- deleteBoardAction boardNo");
	System.out.println(board.getBoardPw() + " <-- deleteBoardAction boardPw");
	
	BoardDao boardDao = new BoardDao();
	boardDao.deleteBoard(board.getBoardNo(), board.getBoardPw()); // board삭제 리스트
	
	// mariaDB 접속
	
%>
