<%@page import="com.project.repository.GalleryLikeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%

	String pageNum = request.getParameter("pageNum");
    if(id==null){
        %>
        <script>
        alert('좋아요는 로그인 후 가능합니다');
        history.back();
        </script>
        <%
	} else {

		int num = Integer.parseInt(request.getParameter("num"));
		GalleryLikeDao likeDao = GalleryLikeDao.getInstance();
		int check = likeDao.getLikeCheck(id, num);
		String text="";
		int likeCount = likeDao.getLikeCount(num);
		
		
	  	if (check==1){
		    likeDao.deleteLike(num, id);
		} else {
		    likeDao.addLike(num, id);
		}   	
	}

response.sendRedirect("gallery_main.jsp?pageNum="+pageNum);
%>
