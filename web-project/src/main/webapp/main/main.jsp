<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="com.project.domain.Board"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div, ul, li {
/* 	border: 1px solid red; */	
	margin: 0px;
	padding: 0px;
}

ul {
	list-style: none;
}

</style>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../script/jquery.innerfade.js"></script>
<script>
$(document).ready(function () {
	$('#portfolio').innerfade({
		animationtype: 'slide',
		speed: 'slow',
		timeout: 4000,
		type: 'sequence',
		//containerheight: '250px'
	});
});
</script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<%@ include file="../inc/top.jsp"%>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img">
	<ul id="portfolio">
		<li><img src="../images/img_001.png" width="971" height="282"/></li>
		<li><img src="../images/img_002.png" width="971" height="282"/></li>
		<li><img src="../images/img_003.png" width="971" height="282"/></li>
		<li><img src="../images/img_004.png" width="971" height="282"/></li>
		<li><img src="../images/img_005.png" width="971" height="282"/></li>
		<li><img src="../images/img_006.png" width="971" height="282"/></li>
		<li><img src="../images/img_007.png" width="971" height="282"/></li>
		<li><img src="../images/img_008.jpg" width="971" height="282"/></li>
	</ul>
</div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>Have a Fun!</h3>
<p>게임은 즐겁게♪<br><br><br></p>
</div>
<div id="security">
<h3>Community</h3>
<p>활발한 커뮤니티!<br><br><br></p>
</div>
<div id="payment">
<h3>Well-mannered</h3>
<p>서로 간의 예의를 지켜주세요<br><br><br></p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">About</span>..</h3>
<dl>
<dt>Hot Contents</dt>
<dd>
<%
BoardDao boardDao = BoardDao.getInstance();
List<Integer> hotContents = null;
hotContents = boardDao.getHotContents();

if (hotContents==null){
    %>
	인기 게시글이 없습니다. <br>
	<%    
} else {
    for (int i=0; i<hotContents.size() ; i++){
        int hotContentNum = hotContents.get(i);
        %>
       <%=i+1 %>. <a href='../center/fcontent.jsp?num=<%=hotContentNum%>'><%=hotContentNum %>번 글로 이동하기</a><br>
        
       <%
    }    
}
%>
</dd>
</dl>
<dl>
<dt>Welcome</dt>
<dd>
<%
OmemberDao omemberDao = OmemberDao.getInstance();
List<String> welcomeList = null;
welcomeList = omemberDao.getWelcomeMembers();

if (welcomeList==null){
    %>
    	가입된 회원이 없습니다. <br>
    <%  
} else {
    for (int i=0; i< welcomeList.size() ; i++){
        String welcome = welcomeList.get(i);
        %>
        <%=i+1 %>. <%=welcome %><br>
        <%
    }  
}
%>
</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">New Boards</h3>
<table>
<% 
int count = boardDao.getBoardCount();

List<Board> list = null;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
if (count > 0) {
    list = boardDao.getBoards(1, 5);
    for (Board board : list){
        %>
        <tr>
        	<td class="contxt">
        	<%
    		int wid = 0;
    		if(board.getRe_lev() > 0){
    		    wid = board.getRe_lev() * 10;
    		    %>
    		    <img src="../images/center/level.gif" width="<%=wid %>px" height="7px">
    		    <img src="../images/center/re.gif">
    		    <%
    		}  
        	%>
        	<a href="../center/fcontent.jsp?num=<%=board.getNum()%>&pageNum=1"><%=board.getSubject() %></a></td>
    		<td><%=sdf.format(board.getReg_date())%></td>
    	</tr>
        <%
    }
// 0보다 작으면 게시판 글 없음
} else { // count == 0
    %>
    <tr><td colspan="2" class="contxt">게시판 글 없음</td></tr> 
    <%
}
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<%@include file="../inc/bottom.jsp" %>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>