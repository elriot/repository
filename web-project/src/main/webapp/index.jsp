<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String keepLogin = request.getParameter("keepLogin");
String id = request.getParameter("id");
System.out.println("keepLogin: "+keepLogin+", id: "+id);

if (keepLogin != null && id != null) {
    // 쿠키처리
    if (keepLogin.equals("yes")) {
    	// 쿠키생성 - 최상위 루트인 index.jsp에서
    	Cookie cookie = new Cookie("id", id);
    	cookie.setMaxAge(60*60*24*14); // 2주일간 로그인 상태 유지
    	response.addCookie(cookie);
    	System.out.println("id 쿠키생성");
    } else if (keepLogin.equals("no")){
        // 쿠키 id 삭제
        Cookie[] cookies = request.getCookies();
        if (cookies != null){
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    // 삭제 : 시간 설정 0
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }
}
%>
    
<% response.sendRedirect("main/main.jsp"); %>