<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//pageNum
String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="board" class="com.project.domain.Board"/>
<jsp:setProperty property="*" name="board"/>
<%
// DB객체 준비
BoardDao boardDao = BoardDao.getInstance();
// check == 1 수정성공 notice.jsp이동
// check == 0 패스워드 틀림. 뒤로 이동

int check = boardDao.updateBoard(board);

if (check == 1){
	response.sendRedirect("notice.jsp?pageNum="+pageNum);
} else { // check == 0
    %>
    <script>
    	alert('패스워드틀림');
    	history.back();
    </script>
    <%
    
}




%>