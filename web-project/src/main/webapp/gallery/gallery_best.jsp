<%@page import="com.project.repository.GalleryLikeDao"%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
<%@page import="com.project.repository.Gallery_ReplyDao"%>
<%@page import="com.project.domain.Gallery_Reply"%>
<%@page import="com.project.domain.Gallery"%>
<%@page import="com.project.repository.GalleryDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@include file="../inc/loginCheck.jsp" %>
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

<!-- 왼쪽메뉴-->
<nav id="sub_menu">
<ul>
<li><a href="../gallery/gallery_main.jsp">갤러리 게시판</a></li>
<li><a href="../gallery/gallery_best.jsp">인기 갤러리</a></li>
</ul>
</nav>

<%

	GalleryDao galleryDao = GalleryDao.getInstance();
	int bestreplyNum = galleryDao.getManyReplies();
	int bestLikeNum = galleryDao.getManyLikes();

	
	// 날짜 포맷 준비
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	Gallery manyReplies = null;
	manyReplies = galleryDao.getGallery(bestreplyNum);
	Gallery manyLikes = null;
	manyLikes = galleryDao.getGallery(bestLikeNum);
	

    int replyCount = 0;
    int likecount = 0;

 	String getManyRepliesContent = "";
	if (manyReplies != null && manyReplies.getContent() != null) {
	    String content1 = manyReplies.getContent().replace("\r\n", "<br>");
	    replyCount = galleryDao.getGalleryReplyCount(manyReplies.getNum());
	}

	
	String getManyLikesContent = "";
	if (manyLikes != null && manyLikes.getContent() != null) {
	    String content2 = manyLikes.getContent().replace("\r\n", "<br>");
	    GalleryLikeDao likeDao = GalleryLikeDao.getInstance();
	    if (likeDao!=null){
	        likecount = likeDao.getLikeCount(manyLikes.getNum());
	    }
	}
	 
%>
<article>
<h1>인기 갤러리</h1>
<h4>답글 많이 받은 게시글과 좋아요를 많이 받은 게시글 </h4>

<table border="1">
<%
if (manyReplies!=null){
    %>
    <tr><th class="tno">No.</th>
            <th class="twrite"><b>♥ ♥ ♥ 리플 개수 : <%=replyCount %> ♥ ♥ ♥ </b></th>
    		<th class="twrite">Writer</th>
  		 	<th class="tread">Date</th>
			</tr>
        <tr>
        	<td><%=manyReplies.getNum() %></td>
        	<td class="left"><%=manyReplies.getSubject() %>
        	</td>
        	<td><%=manyReplies.getName() %></td>
        	<td><%=sdf.format(manyReplies.getReg_date())%></td>       	
        </tr>
        <tr>
        	<td colspan="4">
         	<%
         	if (manyReplies.getFilename()!=null){
         	    
         	    
         		String file = manyReplies.getFilename();
            	int type = file.lastIndexOf(".");
            	String ext = file.substring(type + 1);
            	if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
        			%>
        			<a href="../upload/<%=manyReplies.getFilename()%>"><img src="../upload/<%=manyReplies.getFilename()%>" width="650" height="450"></a><br>
        			<%
        		} else if (ext.equals("mp4") || ext.equals("avi")) {
        			%>
        			<a href="../upload/<%=manyReplies.getFilename()%>"><video src="../upload/<%=manyReplies.getFilename() %>" controls width="650" height="400"></a></video>
        			<%
        		} else {
        			%>표시할 수 없는 확장자 입니다<%
        		}
         	}
			%>         			    
		    </td>
        </tr>
    <%
} else {
    %>
    <tr>
    	<td colspan="4">인기 게시글이 없습니다.</td>
    </tr>    
    <%
}
%>
<%
if(manyReplies!=null){
    %>
    <tr>
        	<td colspan="4">
        	<%=manyReplies.getContent() %></td>
        </tr>
        <tr><th class="tno">No.</th>
            <th class="twrite">♥ ♥ ♥ 좋아요  개수  : <%=likecount %> ♥ ♥ ♥ </b></th>
    		<th class="twrite">Writer</th>
  		 	<th class="tread">Date</th>
			</tr>
        <tr>
        	<td><%=manyLikes.getNum() %></td>
        	<td class="left"><%=manyLikes.getSubject() %>
        	</td>
        	<td><%=manyLikes.getName() %></td>
        	<td><%=sdf.format(manyLikes.getReg_date())%></td>       	
        </tr>
        <tr>
        	<td colspan="4">
         	<%
         	if (manyLikes.getFilename()!=null){
         	    
         	    
         		String file = manyLikes.getFilename();
            	int type = file.lastIndexOf(".");
            	String ext = file.substring(type + 1);
            	if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
        			%>
        			<a href="../upload/<%=manyLikes.getFilename()%>"><img src="../upload/<%=manyLikes.getFilename()%>" width="650" height="450"></a><br>
        			<%
        		} else if (ext.equals("mp4") || ext.equals("avi")) {
        			%>
        			<a href="../upload/<%=manyLikes.getFilename()%>"><video src="../upload/<%=manyLikes.getFilename() %>" controls width="650" height="400"></a></video>
        			<%
        		} else {
        			%>표시할 수 없는 확장자 입니다<%
        		}
         	}
			%>         			    
		    </td>
        </tr>
        <tr>
        	<td colspan="4">
        	<%=manyLikes.getContent() %></td>
        </tr>
    
    
    <%

} else {
    %>
    <tr>
    	<td colspan="4">인기 게시글이 없습니다.</td>
    </tr>    
    <%
    
}

%>


        
                          

</table>

<div class="clear"></div>

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