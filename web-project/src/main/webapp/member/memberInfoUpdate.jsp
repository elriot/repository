<%@page import="java.util.Date"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@include file="../inc/loginCheck.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

%>
<jsp:useBean id="omember" class="com.project.domain.Omember"/>
<jsp:setProperty property="*" name="omember"/>

<% 
	// DB객체 준비
	OmemberDao omemberDao = OmemberDao.getInstance();

	omemberDao.updateOmember(omember);
	%>
	<!-- alert창 뜨지않음 코드 수정 필요 -->
	<script>
	alert('수정완료');
	</script>
	<%
	response.sendRedirect("memberInfo.jsp");	

%>

