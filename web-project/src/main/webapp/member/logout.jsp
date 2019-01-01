<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	//세션초기화
	session.invalidate();

	//이동 '로그아웃' index.jsp
	%>
	<script>
		alert('로그아웃');
		location.href='../index.jsp?keepLogin=no&id=<%=id%>';
	</script>
	<%
%>