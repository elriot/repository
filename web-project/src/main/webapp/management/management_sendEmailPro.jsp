<%@page import="java.util.List"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="org.apache.commons.mail.MultiPartEmail"%>
<%@page import="org.apache.commons.mail.EmailAttachment"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	OmemberDao omemberDao = OmemberDao.getInstance();
	List<String> list = omemberDao.getEmailList();
	System.out.println(list.toString());
%>

<%
String rootPath = application.getRealPath("/");
File uploadFolder = new File(rootPath, "upload"); 
if (!uploadFolder.exists()) {
    uploadFolder.mkdir();
}
String uploadPath = uploadFolder.getPath();
System.out.println("업로드 경로 : " + rootPath);

int maxSize = 1024 * 1024 * 50; 

MultipartRequest multi = new MultipartRequest(request, 
        uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String filename = multi.getFilesystemName("filename");

// 업로드가 끝나면 업로드 경로에 생성한 파일을 첨부파일로 사용함.
for (int i=0; i<list.size(); i++){
    
    
    String emailList = list.get(i);
    //System.out.println(emailList);
    
    long beginTime = System.currentTimeMillis();

    MultiPartEmail email = new MultiPartEmail();

    //SMTP 서버 연결 설정
    email.setHostName("smtp.gmail.com");
    email.setSmtpPort(465);
    email.setAuthentication("ckne2010", "znzl2010");
    //SMTP 보안 SSL, TLS 설정
    email.setSSLOnConnect(true); // SSL 사용 설정
    email.setStartTLSEnabled(true); // TLS 사용 설정


    String result = "fail";
    
    if (filename!=null){
    	File file = new File(uploadPath, filename);
    	
    	// 첨부파일 생성을 위한 EmailAttachment 객체 생성
    	EmailAttachment attach = new EmailAttachment();
    	attach.setPath(file.getPath());

    	
    	try {
    	    // 보내는 사람 설정
    	    email.setFrom("ckne2010@gmail.com", "관리자", "utf-8");
    	    // 받는 사람 설정
    	    email.addTo(emailList, "클랜원", "utf-8");
    	    // 제목 설정
    	    email.setSubject(subject);
    	    // 본문 설정
    	    email.setMsg(content);
    	    // 첨부파일 추가
    	    email.attach(attach);
    	    // 메일 전송
    	    result = email.send(); // 메일 전송이 완료되면
    	    
    /* 	     if (file.exists()) { 
    	        file.delete();
    	    	
    	    }  */
    	    
    	    
    	} catch (EmailException e) {
    	    e.printStackTrace();
    	} finally {
            long execTime = System.currentTimeMillis() - beginTime;
            // 웹 서버 콘솔에 출력
            System.out.println("execTime : " + execTime);
            System.out.println("result : " + result);
            
            // 브라우저에 출력
            out.println("execTime : " + execTime + "<br>");
            out.println("result : " + result + "<br>");
    	}
    // 첨부파일이 없으면
    } else {
        try {
            // 보내는 사람 설정
            email.setFrom("ckne2010@gmail.com", "관리자", "utf-8");
            // 받는 사람 설정
            email.addTo(emailList, "클랜원"+i , "utf-8");
            // 제목 설정
            email.setSubject(subject);
            // 본문 설정
            email.setMsg(content);

            // 메일 전송
            result = email.send(); // 메일 전송이 완료되고
            
        } catch (EmailException e) {
            e.printStackTrace();
        } finally {
            long execTime = System.currentTimeMillis() - beginTime;
            // 웹 서버 콘솔에 출력
            System.out.println("execTime : " + execTime);
            System.out.println("result : " + result);
            
            // 브라우저에 출력
            out.println("execTime : " + execTime + "<br>");
            out.println("result : " + result + "<br>");
        }
    }
    
     
}
%>
<script>
alert('메일 전송 완료');
location.href='management_sendEmail.jsp';
</script>