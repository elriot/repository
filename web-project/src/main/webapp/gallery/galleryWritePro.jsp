<%@page import="com.project.repository.GalleryDao"%>
<%@page import="com.project.domain.Gallery"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/loginCheck.jsp"%>
<%
// 업로드 처리
// 1. request 
// 2. upload 폴더의 실제 경로 문자열
String parentPath = application.getRealPath("/");

// upload라는 폴더가 없으면 생성함
File uploadFolder = new File(parentPath, "upload"); //폴더 경로
if (!uploadFolder.exists()){
    uploadFolder.mkdir();
}
String realPath = uploadFolder.getPath();
System.out.println("업로드 경로: " + realPath);

//3. 파일 업로드 최대크기 (byte)
int maxSize = 500*1024*1024; // 1024 * 1024 * 5 = 5MB

// 매개변수를 두개만 넣어도 업로드 동작함
// 4. 한글처리
// 5. 파일 이름이 동일할 경우 => 파일 이름 변경 정책
MultipartRequest multi = new MultipartRequest
		(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

// DB처리
Gallery gallery = new Gallery();
// 업로드된 파라미터 폼 정보 => 자바빈 저장

gallery.setName(id);
gallery.setSubject(multi.getParameter("subject"));
gallery.setContent(multi.getParameter("content"));
gallery.setFilename(multi.getFilesystemName("filename"));

// set 날짜 ip값 저장
gallery.setReg_date(new Timestamp(System.currentTimeMillis()));
gallery.setIp(request.getRemoteAddr());

// DB 객체
GalleryDao galleryDao = GalleryDao.getInstance();
galleryDao.insertGallery(gallery);

// 이동 
response.sendRedirect("gallery_main.jsp");
%>