<%@page import="java.util.List"%>
<%@page import="com.project.repository.GalleryDao"%>
<%@page import="com.project.domain.Gallery"%>
<%@page import="com.project.domain.Gallery_Reply"%>
<%@page import="com.project.repository.Gallery_ReplyDao"%>
<%@page import="java.text.SimpleDateFormat"%>
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
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<!-- 게시판 -->
<%
	// int num  String pageNum 파라미터 가져오기
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// DB객체 준비
	GalleryDao galleryDao = GalleryDao.getInstance();	
	Gallery_ReplyDao replyDao = Gallery_ReplyDao.getInstance();
	
	// 원본 글 가져오기
	Gallery gallery = galleryDao.getGallery(num);

	
	// 글 리플 목록 가져오기
	List<Gallery_Reply> reply = replyDao.getGalleryReplyList(num);
	

	
	// 내용  줄바꿈(엔터)  \r\n → <br> 바꾸기
	String content = "";
	if (gallery.getContent() != null) {
	    content = gallery.getContent().replace("\r\n", "<br>");
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

%>

<article>
<h1>Notice Content</h1>
<table border="1">
<tr><th>글번호</th><td><%=gallery.getNum() %></td></tr>
<tr><th>조회수</th><td>조회수칼럼없음</td></tr>
<tr><th>작성자</th><td><%=gallery.getName() %></td></tr>
<tr><th>작성일</th><td><%=sdf.format(gallery.getReg_date()) %></td></tr>
<tr>
	<th>글제목</th>
	<td colspan="4"><%=gallery.getSubject() %></td></tr>
<tr><th>파일</th>
	<td colspan="3">
<%
	if (gallery.getFilename()!=null){
		String file = gallery.getFilename();
	  	int type = file.lastIndexOf(".");
	  	String ext = file.substring(type + 1);
		if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
		%>
 		<a href="../upload/<%=gallery.getFilename() %>"><%=gallery.getFilename() %></a>
		<%
		} else {
		%>
		<a href="../upload/<%=gallery.getFilename() %>"><%=gallery.getFilename() %></a>
		<%
		}

	} else {
	    out.println("첨부된 파일 없음");    
	}
	%>
	</td>
</tr>
<tr>
	<th>파일보기</th>
	
	<%
	String file = gallery.getFilename();
	int type = file.lastIndexOf(".");
	String ext = file.substring(type + 1);
	if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
        			%>
        			<td><a href="../upload/<%=gallery.getFilename()%>"><img src="../upload/<%=gallery.getFilename()%>" width="500" height="350" onclick=""></a></td>
        			<%
        		} else if (ext.equals("mp4") || ext.equals("avi")) {
        			%>
        			<td><a href="../upload/<%=gallery.getFilename()%>"><video src="../upload/<%=gallery.getFilename() %>" controls width="500" height="350"></a></video></td>
        			<%
        		} else {
        			%>표시할 수 없는 확장자 입니다<%
        		}
	 %>
<tr><th>글내용</th>
	<td colspan="3">
	<%=content %></td>
</tr>
<%if(reply!=null){
    for(int i=0; i<reply.size(); i++){
        Gallery_Reply reply2 = new Gallery_Reply();
        reply2 = reply.get(i);
        %>
        <tr><th>작성자<%=i+1 %> </th><td colspan="2"><%=reply2.getName() %></td></tr>
        <tr><th>내용<%=i+1 %> </th><td colspan="2"><%=reply2.getContent() %></td></tr>
        <tr><th>작성일<%=i+1 %> </th><td colspan="2"><%=reply2.getReg_date() %></td></tr>
        <%               
    }
%>
		<tr><th>아이디<%=id %></th>
		<td colspan="2">
        <form action="galleryReply.jsp?num=<%=gallery.getNum() %>&pageNum=<%=pageNum %>" method="post" enname="frm">
		<textarea name="reply_content" rows="5" cols="60"></textarea>	        				    
		<input type="submit" name="reply_content" value="전송" class="btn"></td>
		</tr>


<%
    
    
    

}

%>	
</table>

<div id="table_search">
<%
//세션값 가져오기
if (id != null){
    %>

    <%
    if (id.equals(gallery.getName())){
    %>
    <input type="button" value="글수정" class="btn" onclick="location.href='fupdate.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
    <%
    }
    if (id.equals(gallery.getName()) || id.equals("admin")){
    %>
    <input type="button" value="글삭제" class="btn" onclick="location.href='fdelete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">   
    <%
    }
    %>
	<%-- <input type="button" value="답글쓰기" class="btn" onclick="location.href='freWrite.jsp?re_ref=<%=board.getRe_ref()%>&re_lev=<%=board.getRe_lev()%>&re_seq=<%=board.getRe_seq()%>&pageNum=<%=pageNum%>'"> --%>   
    <%
}
%>
 
<input type="button" value="목록보기" class="btn" onclick="location.href='gallery_main.jsp?pageNum=<%=pageNum%>'">
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