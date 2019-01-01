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
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/fnotice.jsp">자유게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Notice Write</h1>
<form action="fwritePro.jsp" method="post" enctype="multipart/form-data" name="frm">
<table id="notice">
<tr><th>이름</th><td><%=id %></td></tr>
<tr><th>패스워드</th><td><input type="password" name="passwd"></td></tr>
<tr><th>제목</th><td><input type="text" name="subject"></td></tr>
<tr><th>파일</th><td><input type="file" name="filename"></td></tr>
<tr><th>내용</th>
	<td><textarea name="content" cols="40" rows="13"></textarea></td>
</tr>
</table>
<div id="table_search">
<input type="submit" value="글쓰기" class="btn">
<input type="reset" value="다시작성" class="btn">
<input type="button" value="목록보기" class="btn" onclick="location.href='fnotice.jsp'">
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