<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.project.repository.BoardDao"%>
<%@page import="com.project.domain.Board"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp"%>
<%
// 업로드 처리
// 1. request 
// 2. upload 폴더의 실제 경로 문자열
// 3. 파일 업로드 최대크기 (byte)
// 4. 한글처리
// 5. 파일 이름이 동일할 경우 => 파일 이름 변경 정책
String realPath = application.getRealPath("/upload");
int maxSize = 5*1024*1024; // 1024 * 1024 * 5 = 5MB

// 매개변수를 두개만 넣어도 업로드 동작함
MultipartRequest multi = new MultipartRequest
		(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

String pageNum = multi.getParameter("pageNum");

// DB처리
Board board = new Board();
// 업로드된 파라미터 폼 정보 => 자바빈 저장
board.setNum(Integer.parseInt(multi.getParameter("num")));
board.setName(multi.getParameter("name"));
board.setPasswd(multi.getParameter("passwd"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));

if (multi.getFilesystemName("filename")!=null){
    // 새롭게 수정할 파일 있음
    board.setFilename(multi.getFilesystemName("filename"));
    
    // 기존 파일은 삭제 처리
    // 기존 파일이름은 파라미터로 가져오기
    String oldFilename = multi.getParameter("filename2");
    
    // File 객체로 파일정보 준비
    File oldFile = new File(realPath, oldFilename);
    // 해당 경로에 파일이 있으면 삭제
    if (oldFile.exists()){ 
        oldFile.delete();
    }      
} else { // null 새롭게 수정할 파일 없음
    board.setFilename(multi.getParameter("filename2"));
}


// DB 객체
BoardDao boardDao = BoardDao.getInstance();

// 메소드 호출 updateBoard(board);
int check = boardDao.updateBoard(board);
if (check == 1){ // 수정성공
    response.sendRedirect("fnotice.jsp?pageNum=" + pageNum);
} else {
    %>
    <script>
    	alert('패스워드 틀림');
    	history.back();
    </script>
    <%
}
%>