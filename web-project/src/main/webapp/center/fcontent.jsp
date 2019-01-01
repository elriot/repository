<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Board"%>
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

<!-- 게시판 -->
<!-- 게시판 -->
<%
	// int num  String pageNum 파라미터 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	if (pageNum==null){
	    pageNum = "1";
	}
	
	// DB객체 준비
	BoardDao boardDao = BoardDao.getInstance();
	// 조회수 1증가 메소드 호출
	boardDao.updateReadCount(num);
	// 글 가져오기
	Board board = boardDao.getBoard(num);
	
	// 공지글 가져오기
	Board board2 = boardDao.getBoardNotice();
	
	// 내용  줄바꿈(엔터)  \r\n → <br> 바꾸기
	String content = "";
	if (board.getContent() != null) {
	    content = board.getContent().replace("\r\n", "<br>");
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

%>

<article>
<h1>Board Content</h1>
<table id="notice">
<tr><th>글번호</th><td><%=board.getNum() %></td>
	<th>조회수</th><td><%=board.getReadcount() %></td></tr>
<tr><th>작성자</th><td><%=board.getName() %></td>
	<th>작성일</th><td><%=sdf.format(board.getReg_date()) %></td></tr>
<tr><th>글제목</th>
	<td colspan="3"><%=board.getSubject() %></td></tr>
<tr><th>파일</th>
	<td colspan="3">
<%
	if (board.getFilename()!=null){
		String file = board.getFilename();
	  	int type = file.lastIndexOf(".");
	  	String ext = file.substring(type + 1);
		if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
		%>
 		<a href="../upload/<%=board.getFilename() %>"><%=board.getFilename() %></a>
		<img src="../upload/<%=board.getFilename() %>" width="50" height="50">
		<%
		} else {
		%>
		<a href="../upload/<%=board.getFilename() %>"><%=board.getFilename() %></a>
		<%
		}

	} else {
	    out.println("첨부된 파일 없음");    
	}
	%>
	</td>
</tr>	
<tr><th>글내용</th>
	<td colspan="3"><%=content %></td></tr>
</table>

<div id="table_search">
<%
//세션값 가져오기
String id = (String) session.getAttribute("id");
if (id != null){
    %>

    <%
    if (id.equals(board.getName())){
    %>
    <input type="button" value="글수정" class="btn" onclick="location.href='fupdate.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
    <%
    }
    if (id.equals(board.getName()) || id.equals("admin")){
    %>
    <input type="button" value="글삭제" class="btn" onclick="location.href='fdelete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">   
    <%
    }
    %>
	<input type="button" value="답글쓰기" class="btn" onclick="location.href='freWrite.jsp?re_ref=<%=board.getRe_ref()%>&re_lev=<%=board.getRe_lev()%>&re_seq=<%=board.getRe_seq()%>&pageNum=<%=pageNum%>'">   
    <%
}
%>
 <%
	if (id != null && id.equals("admin")){		
		if (board.getNotice().equals("notice")){
		%>
		<input type="button" value="공지 취소" class="btn" onclick="location.href='noBoardNotice.jsp?num=<%=board2.getNum()%>&pageNum=<%=pageNum%>'">
		<%
		} else {
		%>
		<input type="button" value="공지글로 등록" class="btn" onclick="location.href='setBoardNotice.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>'">
		<%
		}	 
}
%> 
<input type="button" value="목록보기" class="btn" onclick="location.href='fnotice.jsp?pageNum=<%=pageNum%>'">
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