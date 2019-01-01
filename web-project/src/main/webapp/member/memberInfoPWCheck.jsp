<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");

	
	OmemberDao omemberDao = OmemberDao.getInstance();
	
	int pwCheck = omemberDao.userCheck(id, passwd);

	
%>

<%=pwCheck %>