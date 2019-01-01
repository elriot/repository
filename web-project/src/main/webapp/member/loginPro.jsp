<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	OmemberDao memberDao = OmemberDao.getInstance();
	
	String approvedcheck = memberDao.approvedCheck(id);
	
	String keepLogin = request.getParameter("keepLogin");
	System.out.println("keepLogin : " + keepLogin);
		
	//check == 1 로그인 인증 세션값 생성 index.jsp 이동 
	// 0 패스워드 틀림 뒤로가기, -1 아이디틀림 뒤로가기
	if (approvedcheck.equals("no")) {
	    %>
	    <script>
	    	alert('승인 대기중인 아이디입니다.');
	    	history.back();
	    </script>
	    <%
	} else if (approvedcheck.equals("noSignedId")){
	    %>
	    <script>
	    	alert('가입되어있지 않는 아이디입니다.');
	    	history.back();
	    </script>
	    <%
	} else if (approvedcheck.equals("rejected")){
	    %>
	    <script>
	    	alert('가입 거절된 아이디입니다.');
	    	history.back();
	    </script>
	    <%
	} else {
	    session.setAttribute("id", id);	    
	    response.sendRedirect("../index.jsp?keepLogin="+keepLogin+"&id="+id);;
	    
	}
	  	    
	
	    
	
%>