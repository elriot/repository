<%@page import="com.project.repository.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.project.domain.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	// 액션태그 자바빈 객체생성
	// 액션태그 setProperty폼 => 자바빈 저장
%>
<jsp:useBean id="board" class="com.project.domain.Board"/>
<jsp:setProperty property="*" name="board"/>
<%
	// ip reg_date set메소드 호출
	// 이름은 사용자가 입력하지않고 id 세션 값을 가져왔기때문에 입력값이 없음(null)
	// setName으로 아이디 값인 세션값을 입력함
	board.setName(id); 
	board.setIp(request.getRemoteAddr());
	board.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	BoardDao boardDao = BoardDao.getInstance();
	
	// 메소드 호출 reInsertBoard(board)
	boardDao.reInsertBoard(board);
	
	// 이동 notice.jsp?pageNum=
	response.sendRedirect("fnotice.jsp?pageNum="+pageNum);

%>

