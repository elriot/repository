<%@page import="com.project.repository.GalleryLikeDao"%>
<%@page import="com.project.domain.GalleryLike"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
    if(id!=null){
	}

	int num = Integer.parseInt(request.getParameter("num"));
	GalleryLikeDao likeDao = GalleryLikeDao.getInstance();
	int check = likeDao.getLikeCheck(id, num);
	String text="";
	int likeCount = likeDao.getLikeCount(num);

	
	
  	if (check==1){
	    likeDao.deleteLike(num, id);
	    text = "좋아요 ♡";
	} else {
	    likeDao.addLike(num, id);
	    text = "좋아요 ♥"; 
	} 


%>
<%=text %>