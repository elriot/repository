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

	BoardDao boardDao = BoardDao.getInstance();

	int count = 0;

    count = boardDao.getBoardCount();


	// 우리가 원하는 페이지 가져오기
	// 한페이지당 보여줄 글개수 설정
	int pageSize = 15;
	// 페이지 가져오기
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null) {
		strPageNum = "1";
	}
	int pageNum = Integer.parseInt(strPageNum);
	// 시작(첫)행번호 구하기
	int startRow = (pageNum-1)*pageSize+1;
	// 마지막(끝)행번호 구하기
	int endRow = pageNum * pageSize;

	List<Board> list = null;

    list = boardDao.getBoards(startRow, endRow);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
    Board boardNotice = boardDao.getBoardNotice();
%>
<article>
<h1>Board [전체글개수: <%=count %>]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
if (count > 0) {
    // 공지사항으로 설정된 글이 있으면 테이블 위에 행 추가
    if (boardNotice != null){
    	%>
    	<tr class="noticeBoard" onclick="location.href='fcontent.jsp?num=<%=boardNotice.getNum() %>&pageNum=<%=pageNum%>'"> 
        	<td><%=boardNotice.getNum() %></td>
        	<td class="left"><b>[공지] <%=boardNotice.getSubject() %></b></td>
        	<td><%=boardNotice.getName() %></td>
        	<td><%=sdf.format(boardNotice.getReg_date()) %></td>
        	<td><%=boardNotice.getReadcount() %></td>
    	</tr>     	
    	<%
    }                         
    
    for (int i=0; i<list.size(); i++) {
        Board board = list.get(i);
        %>
        <tr onclick="location.href='fcontent.jsp?num=<%=board.getNum() %>&pageNum=<%=pageNum%>'">        

        	<td><%=board.getNum() %></td>
        	<td class="left">
        		<%
        		int wid = 0;
        		if (board.getRe_lev() > 0) {
        		    wid = board.getRe_lev() * 10;
        		    %>
        		    <img src="../images/center/level.gif" width="<%=wid%>" height="16">
        		    <img src="../images/center/re.gif">
        		    <%
        		}
        		%>
        		<%=board.getSubject() %>
        	</td>
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
// 세션 가져오기
String id = (String) session.getAttribute("id");
// 세션값이 있으면 글쓰기 버튼이 보이게 설정
if (id != null) {
    %>
    <div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='fwrite.jsp'">
	</div>
    <%
}
%>

<div id="table_search">
<!-- <form action="notice.jsp" method="get"> -->
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
		%>
		<div id="PageBlock">
		<%
		// [이전]
		if (startPage > pageBlock) {
			%><a href="fnotice.jsp?pageNum=<%=startPage-1 %><%--&search=<%=search%>--%>">[이전]</a><%
		}
		
		// 1~10
		for (int i=startPage; i<=endPage; i++) {
		    %><a href="fnotice.jsp?pageNum=<%=i %><%--&search=<%=search%>--%>"><%
		    if (i == pageNum) {
		        %><b>[<%=i %>]</b><%
		    } else {
		        %>[<%=i %>]<%
		    }
		    %></a><%
		}
		
		// [다음]
		if (endPage < pageCount) {
			%><a href="fnotice.jsp?pageNum=<%=startPage+pageBlock %><%--&search=<%=search%>--%>">[다음]</a><%
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