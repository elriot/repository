<%@page import="com.project.domain.SurveyCount"%>
<%@page import="com.project.repository.SurveyWhoDao"%>
<%@page import="com.project.domain.SurveyWho"%>
<%@page import="com.project.repository.SurveyCountDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Survey"%>
<%@page import="com.project.repository.SurveyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="survey_main.jsp">투표중</a></li>
<li><a href="survey_finished.jsp">투표완료</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<!-- 게시판 -->
<%
	// int num  String pageNum 파라미터 가져오기
	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");
	
	// DB객체 준비
	SurveyDao surveyDao = SurveyDao.getInstance();
	// 조회수 1증가 메소드 호출
	surveyDao.updateReadCount(num);
	// 글 가져오기
	Survey survey = surveyDao.getSurvey(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");	
	
	
	SurveyCountDao countDao = SurveyCountDao.getInstance();
	
	SurveyCount result = countDao.getSurveyResult(num);


	int count1 = result.getCount1();
	int count2 = result.getCount2();
	int count3 = result.getCount3();
	int count4 = result.getCount4();
	int count5 = result.getCount5(); 
	
	int check100 = 0;
	int totalCount = countDao.getSurveyTotalCount(num);
	int rateCount1 = (100 / totalCount)*count1;
	check100 += rateCount1;
	int rateCount2 = (100 / totalCount)*count2;
	check100 += rateCount2;
	int rateCount3 = (100 / totalCount)*count3;
	check100 += rateCount3;
	int rateCount4 = (100 / totalCount)*count4;
	check100 += rateCount4;
	int rateCount5 = (100 / totalCount)*count5;
	check100 += rateCount5;
	
	if (check100!=100){
	    int rest = 100-check100;
	    	rateCount1 += rest;	    
	}      	
	
%>

<article>
<h1>Finished Survey Content</h1>
<table id="notice">
<form action="survey_countPro.jsp?num=<%=num%>&pageNum=<%=pageNum%>" method="post" name="frm">
<tr><th>글번호</th><td><%=survey.getNum() %></td>
	<th>조회수</th><td><%=survey.getReadcount() %></td></tr>
<tr><th>작성자</th><td><%=survey.getId() %></td>
	<th>작성일</th><td><%=sdf.format(survey.getReg_date()) %></td></tr>
<tr><th>질문</th>
	<td colspan="3"><%=survey.getQuestion() %><b> [총 투표수 : <%=totalCount %>표 (100%)]</b></td></tr>
<tr><th>문항1</th>
	<td colspan="3"><%=survey.getAnswer1() %><b> [<%=count1 %>표 (<%=rateCount1 %>%)]</b></td></tr>
<tr><th>문항2</th>
	<td colspan="3"><%=survey.getAnswer2() %><b> [<%=count2 %>표 (<%=rateCount2 %>%)]</td></tr>
	<%
	if (survey.getAnswer3()!=null){
	    %>
	    <tr><th>문항3</th>
		<td colspan="3"><%=survey.getAnswer3() %><b> [<%=count3 %>표(<%=rateCount3 %>%)]</td></tr>
	    <%
	}
	
	if (survey.getAnswer4()!=null){
	    %>
	    <tr><th>문항4</th>
		<td colspan="3"><%=survey.getAnswer4() %><b> [<%=count4 %>표]</td></tr>
	    <%
	    
	}
	
	if (survey.getAnswer5()!=null){
	    %>
	    <tr><th>문항5</th>
		<td colspan="3"><%=survey.getAnswer5() %><b> [<%=count5 %>표]</td></tr>
	    <%
	    
	}	
	%>
</form>
</table>

<div id="table_search">
<%
if (id != null){
    if (id.equals(survey.getId()) || id.equals("admin")){
    %>
    <input type="button" value="글삭제" class="btn" onclick="location.href='survey_delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">   
    <%
    }
}
%>
<input type="button" value="목록보기" class="btn" onclick="location.href='survey_finished.jsp?pageNum=<%=pageNum%>'">
</div>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.jsp" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>