<%@page import="com.project.domain.Board"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<%--include 지시자는 코드가 모두 복붙 되는것임 
서버 코드를 따로 수행할 때 액션태그 사용--%>
<%-- <%@include file="../inc/top.jsp" %> --%>
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul><!-- 상대경로 include고려시 좋음 , 이동경로를 숨기고 싶을때-->
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="../center/fnotice.jsp">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<article>
<h1>Notice Write</h1>
<form action="writePro.jsp" method="post" name="frm">
<table id="notice">
<tr><th>이름</th><td><%=id %></td></tr>
<tr><th>패스워드</th><td><input type="password" name="passwd"></td></tr>
<tr><th>제목</th><td><input type="text" name="subject"></td></tr>
<tr><th>내용</th>
	<td><textarea name="content" cols="40" rows="13"></textarea></td>
</table>
<div id="table_search">
<input type="submit" name="submit" value="전송" class="btn">
<input type="reset" value="초기화" class="btn">
<input type="button" value="목록으로" class="btn" onclick="location.href='notice.jsp'">
</div>
</form>
<div class="clear"></div>
<div id="page_control">
<a href="#">Prev</a>
<a href="#">1</a><a href="#">2</a><a href="#">3</a>
<a href="#">4</a><a href="#">5</a><a href="#">6</a>
<a href="#">7</a><a href="#">8</a><a href="#">9</a>
<a href="#">10</a>
<a href="#">Next</a>
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