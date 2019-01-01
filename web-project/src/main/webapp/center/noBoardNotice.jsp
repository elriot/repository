<%@page import="com.project.domain.Board"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
	BoardDao boardDao = BoardDao.getInstance();
	
	Board board = boardDao.getBoardNotice();

	boardDao.noBoardNotice(board);

	%>
	<script>
		alert('공지글에서 내렸습니다.');
       	location.href='fnotice.jsp?pageNum=<%=pageNum%>';

	</script>	
 
