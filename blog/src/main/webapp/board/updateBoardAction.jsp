<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import ="vo.Board" %>
<%@ page import = "dao.*"%> 
<%
	request.setCharacterEncoding("utf-8"); // 한글 인코딩

	// updateBoardForm에서 값 받아오기
	// boardNo, categoryName, boardTitle, boardContent, boardPw, updateDate
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	String updateDate = request.getParameter("updateDate");
	
	// board로 값 하나로 모으기
	// boardNo, categoryName, boardTitle, boardContent, boardPw, updateDate
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	board.setUpdateDate(updateDate);
	
	// 디버깅
	System.out.println("-------------updateBoardAction.jsp---------");
	System.out.println(boardNo + " <-- updateBoardForm에서 받아온 boardNo");
	System.out.println(categoryName + " <-- updateBoardForm에서 받아온 categoryName"); 
	System.out.println(boardTitle + " <-- updateBoardForm에서 받아온 boardTitle"); 
	System.out.println(boardContent + " <-- updateBoardForm에서 받아온 boardContent"); 
	System.out.println(boardPw + " <-- updateBoardForm에서 받아온 boardPw"); 
	System.out.println(updateDate + " <-- updateBoardForm에서 받아온 updateDate"); 
	
	BoardDao boardDao = new BoardDao();
	boardDao.updateBoard(board);
	
	response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo="+board.getBoardNo()); // 실행 후 boardOne으로 


	
	
	
	
%>