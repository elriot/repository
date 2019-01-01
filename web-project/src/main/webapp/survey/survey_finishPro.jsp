<%@page import="com.project.repository.SurveyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SurveyDao surveyDao = SurveyDao.getInstance();
	
	surveyDao.finishSurvey(num);
	
	%>
	<script>
		alert('마감 완료');
		location.href='survey_main.jsp?pageNum=<%=pageNum%>';
	</script>
	<%
%>