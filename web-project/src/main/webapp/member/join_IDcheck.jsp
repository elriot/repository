<%@page import="com.project.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function result(){
		// 검색한 id값을 창을 열게해 준 부모 페이지 join.jsp id 텍스트상자에 넣기
		opener.frm.id.value = wfrm.userid.value;
		window.close();
	}	
</script>
</head>
<body>
<%
	// "userid"파라미터 가져오기
	String id = request.getParameter("userid");
	// DB객체 준비
	MemberDao memberDao = MemberDao.getInstance();
	//int check = 메소드 호출 idCheck(id)
	int check = memberDao.idCheck(id);	      
	// check == 1 아이디없음 "사용가능한 아이디입니다."
	// check == 0 아이디있음 "아이디중복, 사용중인 ID입니다."
	if (check == 0){
	    out.println("아이디 중복, 사용중인 ID입니다.");
	} else {
	    out.println("사용가능한 아이디입니다.");
	    %>
	    <input type="button" value="사용" onclick="result()">
	    <%
	}
%>
<form action="join_IDcheck.jsp" method="post" name="wfrm">
	<input type="text" name="userid" value="<%=id %>">
	<input type="submit" value="중복체크">
</form>
</body>
</html>