<%@page import="java.sql.Timestamp"%>
<%@page import="com.project.repository.BoardDao"%>
<%@page import="com.project.domain.Board"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp"%>
<%
//request.setCharacterEncoding("utf-8");

//업로드
//1. request
//2. upload 폴더의 실제 경로 문자열
String realPath = application.getRealPath("/upload");

// 3. 파일 업로드 최대크기
int maxSize = 1024 * 1024 * 50; // 50MB
// 4. 한글처리 "utf-8"
// 5. 파일이름이 동일할 경우 => 파일이름 변경 정책
MultipartRequest multi 
	= new MultipartRequest(
	        request, 
	        realPath,
	        maxSize, 
	        "utf-8", 
	        new DefaultFileRenamePolicy());

// DB처리
Board board = new Board();

// 업로드 정보, 파라미터 폼 정보 => 자바빈 저장
board.setName(id);
board.setPasswd(multi.getParameter("passwd"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
board.setRe_ref(Integer.parseInt(multi.getParameter("re_ref")));
board.setRe_lev(Integer.parseInt(multi.getParameter("re_lev")));
board.setRe_seq(Integer.parseInt(multi.getParameter("re_seq")));

board.setFilename(multi.getFilesystemName("filename"));

// set 날짜 ip 값 저장
board.setReg_date(new Timestamp(System.currentTimeMillis()));
board.setIp(request.getRemoteAddr());

// DB객체 준비
BoardDao boardDao = BoardDao.getInstance();

// 메소드호출  reInsertBoard(board)
boardDao.reInsertBoard(board); // 답글 추가

// 이동 fnotice.jsp
String pageNum = multi.getParameter("pageNum");
response.sendRedirect("fnotice.jsp?pageNum=" + pageNum);
%>
