<%@page import="java.util.Map"%>
<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">

<!-- 헤더들어가는 곳 -->
<%--include 지시자는 코드가 모두 복붙 되는것임 --%>
<%-- <%@include file="../inc/top.jsp" %> --%>
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="management_main.jsp">전체 회원 목록</a></li>
<li><a href="management_notApproved.jsp">승인 대기중 목록</a></li>
<li><a href="management_sendEmail.jsp">단체 메일 발송</a></li>
<li><a href="management_chart.jsp">통계 보기</a></li>
</ul>
</nav>
<article>
<h1>통계 보기</h1>
<div id="table_search">
<a href='management_chartPlaymain.jsp'><input type="button" id="btn1" value="포지션별 통계" class="btn"></a>
<a href='management_chartGender.jsp'><input type="button" id="btn2" value="성별 통계" class="btn"></a>
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