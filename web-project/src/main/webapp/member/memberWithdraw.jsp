<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.project.domain.Omember"%>
<%@page import="com.project.repository.OmemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var isPassed = false;

 $(document).ready(function(){
	$('#passwd').keyup(function(){		
		var check = $('#passwd').val();
		//alert(check);
		$('span').empty();
		$.ajax('memberInfoPWCheck.jsp', {

			data: {passwd : check},
			success: function(data){
				//alert(data);
				if (data==1){
					// 패스워드 일치. 수정 가능
					$('#passwdCheck').append('비밀번호 일치함').css('color', 'green');
					isPassed = true;
				} else {
					$('#passwdCheck').append('비밀번호 일치하지 않음').css('color', 'red');	
					isPassed = false;

				}				
			}
		});
		

	});	
	
	$('#join').submit(function(event){
		if (isPassed == false){
			event.preventDefault();
			alert('비밀번호가 일치하지 않습니다.');
		}		
	}); 
			
});
	

</script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<%@include file="../inc/top.jsp" %>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="memberInfo.jsp">내 정보</a></li>
<li><a href="memberWithdraw.jsp">탈퇴하기</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Withdrawal</h1>
<form action="memberWithdrawPro.jsp" method="post" id="join" name="withDraw" onsubmit="confirm('정말 탈퇴하시겠습니까?')">
<fieldset>
<legend>홈페이지 탈퇴 하기</legend>
</fieldset>

<label>Password</label>
<input type="password" name="passwd" id="passwd" required><span id="passwdCheck"></span><br><br><br><br>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="탈퇴하기" class="submit" >
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.jsp" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>