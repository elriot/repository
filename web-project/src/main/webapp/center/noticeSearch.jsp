<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<li><a href="../center/fnotice.jsp">자유게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%

	request.setCharacterEncoding("utf-8");

	// 검색어 가져오기
	String search = request.getParameter("search");
	

	BoardDao boardDao = BoardDao.getInstance();
	

	int count = boardDao.getBoardCount(search);
	

	int pageSize = 15;

	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null) {
		strPageNum = "1";
	}
	
	int pageNum = Integer.parseInt(strPageNum);
	
	int startRow = (pageNum - 1) * pageSize + 1;
	
	int endRow = pageNum * pageSize;


	List<Board> list = boardDao.getBoards(startRow, endRow, search);
		
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>Board [Total: <%=count %>]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<% 
if (count > 0){
   	for(int i=0; i < list.size(); i++){
   	    Board board = list.get(i);
        %>
        <tr onclick="location.href='content.jsp?num=<%=board.getNum() %>&pageNum=<%=pageNum%>'">
        	<td><%=board.getNum() %></td>
        	<td class="left">
        		<%
        		int wid = 0;
        		if(board.getRe_lev() > 0){
        		    wid = board.getRe_lev() * 10;
        		    %>
        		    <img src="../images/center/level.gif" width="<%=wid %>px" height="16px">
        		    <img src="../images/center/re.gif">
        		    <%
        		}        	        		
        		%>        	
        	
        	<%=board.getSubject() %></td>
        	<td><%=board.getName() %></td>
        	<td><%=sdf.format(board.getReg_date()) %></td>
        	<td><%=board.getReadcount() %></td>
        </tr>
        <%
   	}
} else { // count == 0
    %>
    <tr><td colspan="5">게시판 글 없음</td></tr>
    <%   
}

%>
</table>

<%

String id = (String)session.getAttribute("id");

if (id != null){
    %>
    <div id="table_search">
    <input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'">
    </div>
    <%
}
%>

<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
if (count > 0) {

	int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
	

	int pageBlock = 10;
	
	int startPage = ((pageNum/pageBlock) - (pageNum%pageBlock==0 ? 1: 0)) * pageBlock + 1;
	
	int endPage = startPage + pageBlock - 1;
	if (endPage > pageCount) {
		endPage = pageCount;
	}
		
		// [이전]
		%>
		<div id="pageBlock">
		<%
		if (startPage > pageBlock) {
			%><a href="noticeSearch.jsp?pageNum=<%=endPage-pageBlock %>&search=<%=search%>"> &lt; Prev </a><%
					/* 네이버 페이지 방식 startPage-1 */
		}
		
		// 1~10
		for (int i=startPage; i<=endPage; i++) {
		    %>
		    <a href="noticeSearch.jsp?pageNum=<%=i %>&search=<%=search%>">
		    <%		   
		    if(i == pageNum){
		        %><b><%=i %></b><%
		    } else {
		        %>
		         <%=i %> 
		        <%
		    }	
		    %></a><%
		}
		
		// [다음]
		if (endPage < pageCount) {
			%><a href="noticeSearch.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search%>"> Next &gt;</a><%
		}
		%>
		</div>
		<%
	}
%>
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