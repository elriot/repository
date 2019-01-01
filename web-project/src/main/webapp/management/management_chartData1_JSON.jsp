<%@page import="com.project.repository.OmemberDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	
	// DB객체 준비
	OmemberDao omemberDao = OmemberDao.getInstance();
	
	
	JSONArray jsonArray = omemberDao.getCountPlaymainJSON();
	//System.out.println(jsonArray);
%>
<%=jsonArray %>