<%@page import="com.project.repository.SurveyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SurveyDao dao = SurveyDao.getInstance();
	
	dao.deleteSurvey(num);
%>
<script>
	alert('설문이 삭제 되었습니다.');
	location.href='survey_main.jsp';
</script>