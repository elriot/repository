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
<ul>
<li><a href="../center/fnotice.jsp">자유게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
	// re_ref  re_lev  re_seq String pageNum 파라미터 가져오기
	// 자료타입은 숫자형이지만 연산에 사용하는 것이 아니므로 String으로 받아도 상관 없음
	String re_ref = request.getParameter("re_ref");
	String re_lev = request.getParameter("re_lev");
	String re_seq = request.getParameter("re_seq");
	String pageNum = request.getParameter("pageNum");
%>
<!-- 게시판 -->
<article>
<h1>File Rewrite Notice</h1>
<form action="freWritePro.jsp?pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data"name="frm">
<!-- hidden 속성은 사용자가 입력하는 값이 아니고, name과 value값이 같이 넘어간다-->
<input type="hidden" name="re_ref" value="<%=re_ref %>">
<input type="hidden" name="re_lev" value="<%=re_lev %>">
<input type="hidden" name="re_seq" value="<%=re_seq %>">
<table id="notice">
<tr><th>이름</th><td><%=id %></td></tr>
<tr><th>패스워드</th><td><input type="password" name="passwd"></td></tr>
<tr><th>제목</th><td><input type="text" name="subject"></td></tr>
<tr><th>파일</th><td><input type="file" name="filename"></td></tr>
<tr><th>내용</th>
	<td><textarea name="content" cols="40" rows="13"></textarea></td>
</table>
<div id="table_search">
<input type="submit" name="submit" value="전송" class="btn">
<input type="reset" value="초기화" class="btn">
<input type="button" value="목록으로" class="btn" onclick="location.href='fnotice.jsp?pageNum=<%=pageNum %>'">
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