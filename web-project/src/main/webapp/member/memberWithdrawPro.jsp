<%@include file="../inc/top.jsp" %>
<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	OmemberDao memberDao = OmemberDao.getInstance();
	
	Omember omember = memberDao.getOmember(id);
	memberDao.withdrawalMember(omember);
	
	session.invalidate();
		
%>
<script>
	alert('탈퇴 되었습니다.');
	location.href='../index.jsp';	
</script>	
