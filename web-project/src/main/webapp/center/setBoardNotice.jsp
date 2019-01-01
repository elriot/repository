<%@page import="com.project.domain.Board"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDao boardDao = BoardDao.getInstance();
	
	boardDao.setBoardNotice(num);

%>
	<script>
		alert('공지글로 등록 되었습니다.');
       	location.href='fnotice.jsp?pageNum=<%=pageNum%>';

	</script>	
 