<%@page import="com.project.repository.MemberDao"%>
<%@page import="com.project.domain.Member"%>
<%@page import="java.io.File"%>
<%@page import="com.project.domain.Board"%>
<%@page import="com.project.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp" %>
<%
// int num  String passwd   String pageNum
int num = Integer.parseInt(request.getParameter("num"));
String passwd = request.getParameter("passwd");
String pageNum = request.getParameter("pageNum");
String filename = request.getParameter("filename");
String realPath = application.getRealPath("/upload");


if (filename!=null){
    // 새롭게 수정할 파일 있음

    File file = new File(realPath, filename);
    // 해당 경로에 파일이 있으면 삭제
    if (file.exists()){ 
        file.delete();
    }      
} 

// DB객체 준비
BoardDao boardDao = BoardDao.getInstance();
	
// int check = deleteBoard(board)
int check;

if (id!=null & id.equals("admin")){
	check = boardDao.deleteBoardByAdmin(num);
} else {
	check = boardDao.deleteBoard(num, passwd);
	// check == 1 이면 삭제성공  notice.jsp?pageNum=
	// check == 0 이면 '패스워드틀림' 뒤로이동
}


if (check == 1) {
	%>
	<script>
		alert('삭제 되었습니다');
		location.href='fnotice.jsp?pageNum=<%=pageNum%>';
	</script>
	<%
} else {
    %>
    <script>
    	alert('패스워드틀림');
    	history.back();
    </script>
    <%
}
%>









