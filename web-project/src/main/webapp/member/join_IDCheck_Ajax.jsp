<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	OmemberDao memberDao = OmemberDao.getInstance();
	String id = request.getParameter("id");
	//int check = 메소드 호출 idCheck(id)
	int check = memberDao.idCheck(id);	      

%>
<%=check %>
