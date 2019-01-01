<%@page import="java.util.Date"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="com.project.repository.MemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");


%>
<jsp:useBean id="omember" class="com.project.domain.Omember"/>
<jsp:setProperty property="*" name="omember"/> 
<% 
	
	omember.setReg_date(new Timestamp(System.currentTimeMillis()));

	OmemberDao omemberDao = OmemberDao.getInstance();
	omemberDao.insertMember(omember);
	
	if (id != null && id.equals("admin")){
	    %>
	    <script>
			alert('관리자 계정으로  가입이 완료 되었습니다.');	
			location.href='login.jsp';
	    </script>
	    
	    <%
	} else {
	    %>	    
		<script>
			alert('회원 가입이 완료 되었습니다. 가입 승인은 약 2~3일 소요됩니다.');	
			location.href='login.jsp';
		</script>
	    <%
	}
	
	
%>
