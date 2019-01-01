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
	
	surveyDao.insertIntoCountTable(num);
	
	SurveyWhoDao whoDao = SurveyWhoDao.getInstance();
	int surveyCheck = whoDao.getSurveyCheck(id, num);
	int userVote = whoDao.getUserVoteResult(num, id);        
	
	
%>

<article>
<h1>Survey Content</h1>
<table id="notice">
<form action="survey_countPro.jsp?num=<%=num%>&pageNum=<%=pageNum%>" method="post" name="frm">
<tr><th>글번호</th><td><%=survey.getNum() %></td>
	<th>조회수</th><td><%=survey.getReadcount() %></td></tr>
<tr><th>작성자</th><td><%=survey.getId() %></td>
	<th>작성일</th><td><%=sdf.format(survey.getReg_date()) %></td></tr>
<tr><th>질문</th>
	<td colspan="3"><%=survey.getQuestion() %></td></tr>
<tr><th>문항1</th>
	<td colspan="3"><%if (surveyCheck==0){%><input type="radio" name="count" value="count1"><%}%><%=survey.getAnswer1() %></td></tr>
<tr><th>문항2</th>
	<td colspan="3"><%if (surveyCheck==0){%><input type="radio" name="count" value="count2"><%}%><%=survey.getAnswer2() %></td></tr>
	<%
	if (survey.getAnswer3()!=null){
	    %>
	    <tr><th>문항3</th>
		<td colspan="3">
		<%
		if (surveyCheck==0){%><input type="radio" name="count" value="count3"><%}%><%=survey.getAnswer3() %></td></tr>
	    <%
	}
	
	if (survey.getAnswer4()!=null){
	    %>
	    <tr><th>문항4</th>
		<td colspan="3">
		<%if (surveyCheck==0){%><input type="radio" name="count" value="count4"><%}%><%=survey.getAnswer4() %></td></tr>
	    <%
	    
	}
	
	if (survey.getAnswer5()!=null){
	    %>
	    <tr><th>문항5</th>
		<td colspan="3">
		<%if (surveyCheck==0){%><input type="radio" name="count" value="count5"><%}%><%=survey.getAnswer5() %></td></tr>
	    <%
	    
	}
	
	%>
<%if (id!=null && surveyCheck==0 ) {
    %>
    <tr><td colspan="4"><input type="submit" name="submit" value="투표하기" class="btn"></td></tr>
    <%
} else {
    %>
    <tr><td colspan="4"><b>투표 완료[<%=userVote %>번 투표함]</b></td></tr>
    <%
}%>


</form>
</table>

<div id="table_search">
<%
if (id != null){
    %>

    <%
    if (id.equals(survey.getId())){
    %>
    <input type="button" value="설문마감" class="btn" onclick="location.href='survey_finishPro.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
    <%
    }
    if (id.equals(survey.getId()) || id.equals("admin")){
    %>
    <input type="button" value="글삭제" class="btn" onclick="location.href='survey_delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">   
    <%
    }
}
%>
<input type="button" value="목록보기" class="btn" onclick="location.href='survey_main.jsp?pageNum=<%=pageNum%>'">
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