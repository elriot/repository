<%@page import="com.project.repository.OmemberDao"%>
<%@page import="com.project.domain.Omember"%>
<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
    
<%
	OmemberDao omemberDao = OmemberDao.getInstance();
	Omember omember = null;
	String [] values = request.getParameterValues("check");
	for (String val : values){
		omember = omemberDao.getOmember(val);
		omemberDao.setApprovedOmember(omember);
	}
	
	%>
	<script>
		alert('승인 처리 되었습니다.');
		location.href='management_notApproved.jsp';	
	</script>
	
	<%




%>