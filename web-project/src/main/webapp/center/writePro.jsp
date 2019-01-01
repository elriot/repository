<%@page import="com.project.repository.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.project.domain.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8");

	// 액션태그 자바빈 객체생성
	// 액션태그 폼 = > 자바빈 저장
%>
<jsp:useBean id="board" class="com.project.domain.Board"/>
<jsp:setProperty property="*" name="board"/>
<%
	// set 날짜 ip
	board.setName(id);
	board.setReg_date(new Timestamp(System.currentTimeMillis()));
	board.setIp(request.getRemoteAddr());
	
	// DB 객체 준비
	BoardDao boardDao = BoardDao.getInstance();
	
	// 게시판 글 1개 추가 메소드
	boardDao.insertBoard(board);
	
	// 이동 notice.jsp
	response.sendRedirect("notice.jsp");



%>
