<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.project.domain.Gallery_Reply"%>
<%@page import="java.util.List"%>
<%@page import="com.project.repository.Gallery_ReplyDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int num = Integer.parseInt(request.getParameter("num"));
	
	// DB객체 준비
	Gallery_ReplyDao replyDao = Gallery_ReplyDao.getInstance();
	
// 	// 글 리플 목록 가져오기
// 	List<Gallery_Reply> reply = replyDao.getGalleryReplyList(num);
// 	System.out.println(reply);
	
	JSONArray jsonArray = replyDao.getReplyJSON(num);

%>
<%=jsonArray %>