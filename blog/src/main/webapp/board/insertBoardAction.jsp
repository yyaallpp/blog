<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
 <% 
 	// 한글 인코딩 깨져 나왔음
	request.setCharacterEncoding("utf-8");
 	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
 
 	// insertBoardForm에서 정보 가져오기 --> categoryName, boardTitle, boardContent, boardPw 4개
 	String categoryName = request.getParameter("categoryName");
 	String boardTitle = request.getParameter("boardTitle");
 	String boardContent = request.getParameter("boardContent");
 	String boardPw = request.getParameter("boardPw");
 	
 	// 정보 가공 하나로 묶기
 	Board board = new Board();
 	board.setCategoryName(categoryName);
 	board.setBoardTitle(boardTitle);
 	board.setBoardContent(boardContent);
 	board.setBoardPw(boardPw);
 	
 	// 디버깅
 	System.out.println(" ------------- insertBoardAction ----------------------");
 	System.out.println(board.getCategoryName() + " <-- insertBoardAction categoryName");
 	System.out.println(board.getBoardTitle() + " <-- insertBoardAction boardTitle");
 	System.out.println(board.getBoardContent() + " <-- insertBoardAction boardContent");
 	System.out.println(board.getBoardPw() + " <-- insertBoardAction boardPw");
 	
 	// 입력 메서드
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
 %>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 