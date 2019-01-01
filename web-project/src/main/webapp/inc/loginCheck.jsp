<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 없으면 login.jsp 로 이동

if (id == null){
    response.sendRedirect("../member/login.jsp");
    // return이 없으면 아래 코드를 다 수행하다가 null Pointer 만나서 오류 발생할 수 있음
    return;
}
%>