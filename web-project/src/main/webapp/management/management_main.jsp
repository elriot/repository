<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">

<!-- 헤더들어가는 곳 -->
<%--include 지시자는 코드가 모두 복붙 되는것임 --%>
<%-- <%@include file="../inc/top.jsp" %> --%>
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="management_main.jsp">전체 회원 목록</a></li>
<li><a href="management_notApproved.jsp">승인 대기중 목록</a></li>
<li><a href="management_sendEmail.jsp">단체 메일 발송</a></li>
<li><a href="management_chart.jsp">통계 보기</a></li>
</ul>
</nav>
<article>
<%
OmemberDao omemberDao = OmemberDao.getInstance();
List<Omember> list = omemberDao.getApprovedMembers();
int count = list.size();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>
<h1>전체 클랜원 목록 [Total: <%=count %>]</h1>
<table id="notice">
<form action="management_membersWithdrawal.jsp" method="post" id="approve" name="frm" onsubmit="confirm('탈퇴 시키겠습니까?')">
<tr><th class="tno">No.</th>
	<th class="twrite">아이디</th>
    <th class="twrite">배틀태그</th>
    <th class="twrite">성별</th>
    <th class="twrite">이메일</th>
    <th class="twrite">주캐릭</th>
    <th class="twrite">생일</th>
    <th class="twrite">가입일</th>
    <th class="tread">탈퇴</th>
</tr>
<%
if(count>0){
    for (int i=0; i<list.size(); i++){
        Omember omember = list.get(i);
        %>
        <tr>
        	<td><%=i+1 %></td>
        	<td><%=omember.getId() %></td>
        	<td><%=omember.getBattletag() %></td>
        	<td><%=omember.getGender() %></td>
        	<td><%=omember.getEmail() %></td>
        	<td><%=omember.getPlaymain() %></td>
        	<td><%=omember.getBirthday() %></td>
        	<td><%=sdf.format(omember.getReg_date()) %></td>
        	<%if (!id.equals(omember.getId())) {
        	  %>
        	  <td><input type="checkbox" name="check" value="<%=omember.getId() %>"></td>
        	  <%  
        	} else {
        	  %>
        	  <td> </td>
        	  <%  
        	}%>
        	
        	
        </tr>
        <%
    }
    
    
}



%>
</table>
<div id="table_search">
<input type="submit" value="강제탈퇴" class="btn">
</div>
</form>
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