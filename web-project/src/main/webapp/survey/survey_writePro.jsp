<%@page import="com.project.repository.SurveyCountDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.project.repository.SurveyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>

<%

	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8");


%>

<jsp:useBean id="survey" class="com.project.domain.Survey"/>
<jsp:setProperty property="*" name="survey"/>

<%

	survey.setId(id);
	survey.setReg_date(new Timestamp(System.currentTimeMillis()));

	SurveyDao surveyDao = SurveyDao.getInstance();
	surveyDao.insertSurvey(survey);

	
	//System.out.println(question + ", " + answer1 + ", "+ answer2);
	
	
	response.sendRedirect("survey_main.jsp");



%>