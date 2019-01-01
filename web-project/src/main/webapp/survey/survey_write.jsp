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
<article>
<h1>Survey Write</h1>
<form action="survey_writePro.jsp" method="post" name="frm">
<table id="notice">
<tr><th>이름</th><td><%=id %></td></tr>
<tr><th>질문 (필수 입력)</th><td><textarea name="question" cols="40" rows="1" required></textarea></td></tr>
<tr><th>문항1.(필수 입력)</th>
	<td><textarea name="answer1" cols="40" rows="1" required></textarea></td>
</tr>
<tr><th>문항2.(필수 입력)</th>
	<td><textarea name="answer2" cols="40" rows="1" required></textarea></td>
</tr>
<tr><th>문항3.</th>
	<td><textarea name="answer3" cols="40" rows="1" ></textarea></td>
</tr>
<tr><th>문항4.</th>
	<td><textarea name="answer4" cols="40" rows="1" ></textarea></td>
</tr>
<tr><th>문항5.</th>
	<td><textarea name="answer5" cols="40" rows="1" ></textarea></td>
</tr>
</table>
<div id="table_search">
<input type="submit" name="submit" value="전송" class="btn">
<input type="reset" value="초기화" class="btn">
<input type="button" value="목록으로" class="btn" onclick="location.href='survey_main.jsp'">
</div>
</form>
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