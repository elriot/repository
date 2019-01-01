<%@page import="com.project.repository.GalleryDao"%>
<%@page import="com.project.domain.Gallery"%>
<%@page import="com.project.repository.Gallery_ReplyDao"%>
<%@page import="com.project.domain.Gallery_Reply"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	int origin_num_int = Integer.parseInt(num);
	String pageNum = request.getParameter("pageNum");
	String content = request.getParameter("reply_content");
	System.out.println(content);

%>
<jsp:useBean id="gallery_reply" class="com.project.domain.Gallery_Reply"/>
<jsp:setProperty property="*" name="gallery_reply"/>
<%
	// ip reg_date set메소드 호출
	// 이름은 사용자가 입력하지않고 id 세션 값을 가져왔기때문에 입력값이 없음(null)
	// setName으로 아이디 값인 세션값을 입력함
	
	gallery_reply.setName(id); 
	gallery_reply.setContent(content);
	gallery_reply.setIp(request.getRemoteAddr());
	gallery_reply.setReg_date(new Timestamp(System.currentTimeMillis()));

	
	Gallery_ReplyDao replyDao = Gallery_ReplyDao.getInstance();
	
	// 메소드 호출 reInsertBoard(board)
	replyDao.insertGalleryReply(gallery_reply, origin_num_int);

	
	// 이동 notice.jsp?pageNum=
	response.sendRedirect("gallery_main.jsp?pageNum="+pageNum);
%>

