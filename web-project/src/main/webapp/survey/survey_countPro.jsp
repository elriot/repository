<%@page import="com.project.repository.SurveyWhoDao"%>
<%@page import="com.project.repository.SurveyCountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%

String radioValue = request.getParameter("count");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
int count;
if (radioValue.equals("count1")){
    count = 1;
} else if (radioValue.equals("count2")){
    count = 2;
} else if (radioValue.equals("count3")){
    count = 3;
} else if (radioValue.equals("count4")){
    count = 4;
} else {
    count = 5;
}
 





//System.out.println(radioValue + num);

SurveyCountDao surveyCountDao = SurveyCountDao.getInstance();
surveyCountDao.addCountSurvey(num, radioValue);
SurveyWhoDao whoDao = SurveyWhoDao.getInstance();
whoDao.addVote(num, id, count);
%>
<script>
	alert('투표 완료');
	location.href='survey_content.jsp?num=<%=num%>&pageNum=<%=pageNum%>';


</script>