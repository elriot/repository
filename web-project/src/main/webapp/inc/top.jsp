<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 쿠키 id값 확인
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
	    for (Cookie cookie : cookies) {
	        if (cookie.getName().equals("id")) {
	            session.setAttribute("id", cookie.getValue());
	        }
	    }
	}

	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
%>
<header>
<div id="login">
<%
if (id != null) { // 로그인 했을때
    %>
    <%=id %>님이 로그인했습니다. 
    <a href="../member/logout.jsp">logout</a> ｜
    <a href="../member/memberInfo.jsp">Info</a>  
    	
    <%
    
} else { // 로그인 안했을때
    %>
    <a href="../member/login.jsp">login</a> ｜
    <a href="../member/join.jsp">join</a>
    <%
}

%>
 
</div> 
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.png" alt="CK Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../index.jsp">HOME</a></li>
	<li><a href="../gallery/gallery_main.jsp">GALLERY</a></li>
	<li><a href="../survey/survey_main.jsp">SURVEY</a></li>
	<li><a href="../center/fnotice.jsp">BOARD</a></li>
<%
	if (id!=null && id.equals("admin")){
		%>
			<li><a href="../management/management_main.jsp">MANAGEMENT</a></li>
		<%
	}

%>

</ul>
</nav>
</header>