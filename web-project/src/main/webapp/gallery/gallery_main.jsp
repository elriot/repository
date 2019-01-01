<%@page import="com.project.repository.GalleryLikeDao"%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
<%@page import="com.project.repository.Gallery_ReplyDao"%>
<%@page import="com.project.domain.Gallery_Reply"%>
<%@page import="com.project.domain.Gallery"%>
<%@page import="com.project.repository.GalleryDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	
	
	$('.showReply').bind('click', function () {
		var num = $(this).next().text();
		
		var str = '';
		
		$(this).parent().parent().next().find('td').empty();
		
		$.ajax({
			async: false,
			url: 'galleryReplyAjax.jsp',
			data: {num: num},
			success: function (result) {
				
				$.each(result, function (index, record) {
					str += record.name + '<br>';
					str += record.content + '<br>';
					str += record.reg_date + '<br>';
					str += '<a href="galleryReply.jsp?num='+num+'">'+'답글달기'+'</a><br><hr>';

				});				
			} // success
		});
		
		$(this).parent().parent().next().find('td').append(str).css('display', 'table-cell');	
			
		
	});
	
/*	좋아요 버튼 클릭하면 좋아요 +1, 좋아요 여부에 따라 버튼 텍스트 변경.  
	$('.like').bind('click', function () {
		var num = $(this).next().text();		
		
		var str = '';
		
		$.ajax({
			url: 'galleryLikeAjax.jsp',
			data: {num: num},
			success: function (result) {
				alert(result);
				$('.like').attr('value', result);
				$.each(result, function (index, record) {
					
				});				
			} // success
		});		
	}); */
	
/* 	$('.like').click(function(){
		var num = $(this).next().text();
		$.ajax({
			url: 'galleryLikeAjax.jsp',
			data: {num: num},
			success: function (result) {
				alert(result);
				//$('.like').attr('value', result);	
				//$('.like').val(result);
				$.each(result, function (index, record) {					

				}); 				
			} // success			
		})		
	}); */
	

	
});
</script>
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
	String id = (String) session.getAttribute("id");

	if (id == null){
	    %>
	    <script>
	    	alert('로그인 후 접근 가능한 페이지 입니다');
	    	location.href='../member/login.jsp';
	    
	    </script>
	    <%
	}

	
	GalleryDao galleryDao = GalleryDao.getInstance();

	int count = 0;

    count = galleryDao.getGalleryCount();

	int pageSize = 3;
	// 페이지 가져오기
	String strPageNum = request.getParameter("pageNum");

	if (strPageNum == null) {
		strPageNum = "1";
	} 

	int pageNum = Integer.parseInt(strPageNum);

	int startRow = (pageNum-1)*pageSize+1;

	int endRow = pageNum * pageSize;

	List<Gallery> list = null;

	list = galleryDao.getGalleryListWithLimit(startRow, pageSize);
	
	// 날짜 포맷 준비
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
%>
<article>
<h1>GALLERY [전체글개수: <%=count %>]</h1>
<%

// 세션값이 있으면 글쓰기 버튼이 보이게 설정
if (id != null) {
    %>
    <div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='galleryWrite.jsp'">
	</div>
    <%
}
%>


<table border="1"><!-- id="notice" -->
<%
if (count > 0) {
    for (int i=0; i<list.size(); i++) {
        Gallery gallery = list.get(i);
        int replyCount = galleryDao.getGalleryReplyCount(gallery.getNum());
        GalleryLikeDao likeDao = GalleryLikeDao.getInstance();
        int likecount = likeDao.getLikeCount(gallery.getNum());

        %>
        <tr><th class="tno">No.</th>
            <th class="ttitle">Title</th>
    		<th class="twrite">Writer</th>
  		 	<th class="tread">Date</th>
			</tr>
        <tr>
        	<td><%=gallery.getNum() %></td>
        	<td class="left"><%=gallery.getSubject() %>  (♥:<%=likecount %>)
        	</td>
        	<td><%=gallery.getName() %></td>
        	<td><%=sdf.format(gallery.getReg_date()) %></td>       	
        </tr>
        <tr>
        	<td colspan="4">
         	<%
         	if (gallery.getFilename()!=null){
         	    
         	    
         		String file = gallery.getFilename();
            	int type = file.lastIndexOf(".");
            	String ext = file.substring(type + 1);
            	if(ext.equals("jpg") || ext.equals("jpeg") || ext.equals("tif") || ext.equals("png")){
        			%>
        			<a href="gallery_content.jsp?num=<%=gallery.getNum()%>&pageNum=<%=pageNum%>"><img src="../upload/<%=gallery.getFilename()%>" width="650" height="450"></a><br>
        			<%
        		} else if (ext.equals("mp4") || ext.equals("avi")) {
        			%>
        			<a href="gallery_content.jsp?num=<%=gallery.getNum()%>&pageNum=<%=pageNum%>"><video src="../upload/<%=gallery.getFilename() %>" controls width="650" height="400"></a></video>
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
        	<%
        	String content = "";
        	if (gallery.getContent() != null) {
        	    content = gallery.getContent().replace("\r\n", "<br>");
        	}
        	%>
        	<%=content %></td>
        </tr>
          <tr>
        	<td><input type="button" value="<%
        	
			int check = likeDao.getLikeCheck(id, gallery.getNum());        	
        	
          	if (check==1){
        	    %>좋아요 ♥<%
        	} else if (check==0){
        	    %>좋아요 ♡<% 
        	} 
      	
        	%>" class="btn like" onclick="location.href='galleryLikeButton.jsp?num=<%=gallery.getNum() %>&pageNum=<%=strPageNum%>'"></td><span style="display: none;"><%=gallery.getNum() %></span></td>
        	<td><input type="button" value="답글보기 [답글 : <%=replyCount %>]" class="btn showReply"><span style="display: none;"><%=gallery.getNum() %></span></td>
        	<td><input type="button" value="수정" class="btn" onclick="location.href='galleryUpdate.jsp?num=<%=gallery.getNum() %>&pageNum=<%=strPageNum%>'"></td>
        	<td><input type="button" value="삭제" class="btn" onclick="location.href='galleryDelete.jsp?num=<%=gallery.getNum() %>&pageNum=<%=strPageNum%>''"></td>
        </tr>
        <tr><td colspan="4"></td></tr>
        <%
        if (id!=null){
            %>
            <tr><th><%=id %></th>
			<td colspan="3">
	        <form action="galleryReply.jsp?num=<%=gallery.getNum() %>&pageNum=<%=pageNum %>" method="post" name="frm">
			<textarea name="reply_content" rows="5" cols="60"></textarea>	        				    
			<input type="submit" name="reply_content" value="전송" class="btn"></td>
			</form>
			</tr>
            <%
        }
    }
} else { // count == 0
    %>
    <tr><td colspan="4">게시판 글 없음</td></tr>
    <%
	}
%>
</table>

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
			%><a href="gallery.jsp?pageNum=<%=startPage-1 %><%--&search=<%=search%>--%>">[이전]</a><%
		}
		
		// 1~10
		for (int i=startPage; i<=endPage; i++) {
		    %><a href="gallery_main.jsp?pageNum=<%=i %><%--&search=<%=search%>--%>"><%
		    if (i == pageNum) {
		        %><b>[<%=i %>]</b><%
		    } else {
		        %>[<%=i %>]<%
		    }
		    %></a><%
		}
		
		// [다음]
		if (endPage < pageCount) {
			%><a href="gallery_main.jsp?pageNum=<%=startPage+pageBlock %><%--&search=<%=search%>--%>">[다음]</a><%
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