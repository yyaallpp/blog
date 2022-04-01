<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
					<!--  다른 페이지의 부분으로 사용되는 페이지 -->	
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>
      </li>    
    </ul>
  </div>  
  
</nav>