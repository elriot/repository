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
<%
// int num  String pageNum 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//DB 객체 준비
BoardDao boardDao = BoardDao.getInstance();

//삭제할 글 가져오기
Board board = boardDao.getBoard(num);

%>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>

<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<%-- include 지시자는 소스코드가 복사 붙여넣기 형식으로 포함됨 --%>
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

<!-- 게시판 -->

<article>
<h1>Board Delete</h1>
<form action="fdeletePro.jsp?pageNum=<%=pageNum %>" method="post" name="frm">
<input type="hidden" name="filename" value="<%=board.getFilename() %>">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<%
if (id!=null && id.equals("admin")){
	%>
	<tr><th>관리자모드</th><td><%=num %>번 게시글을 삭제하시겠습니까?</td></tr>
	<%
} else {
%>
	<tr><th>패스워드</th><td><input type="password" name="passwd"></td></tr>
<%
}
%>
</table>
<div id="table_search">
<input type="submit" value="글삭제" class="btn">
<input type="reset" value="다시작성" class="btn">
<input type="button" value="목록보기" class="btn" onclick="location.href='fnotice.jsp?pageNum=<%=pageNum%>'">
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