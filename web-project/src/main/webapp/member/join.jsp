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

	
	
	$('.id').keyup(function(){		
		var check = $('.id').val();
		//alert(check);
		$('span').empty();
		$.ajax('join_IDCheck_Ajax.jsp', {

			data: {id: check},
			success: function(data){				
				
				if (data==1){
					$('#idCheck').append('사용 가능한 아이디입니다').css('color', 'green');
					isPassed = true;
				} else {
					$('#idCheck').append('이미 존재하는 아이디입니다').css('color', 'red');
					isPassed = false;
				}
				
				if(frm.id.value.length==0){
					$('#idCheck').empty();
				}

			}

		});
	});	
	
 	$('#passwd').keyup(function(){
		var passwd = $('#passwd').val();
		var passwd2 = $('#passwd2').val();


			if (passwd != passwd2){			
				$('#passwdCheck').empty();
				$('#passwdCheck').append('비밀번호 일치 하지 않음').css('color', 'red');
				isPassed = false;
			} else{
				$('#passwdCheck').empty();
				$('#passwdCheck').append('비밀번호 일치').css('color', 'green');
				isPassed = true;
			}
			
	 		if (frm.passwd.value.length==0 && frm.passwd2.value.length==0){
				$('#passwdCheck').empty();
			} 
	}); 
	
	$('#passwd2').keyup(function(){
		var passwd = $('#passwd').val();
		var passwd2 = $('#passwd2').val();


			if (passwd != passwd2){			
				$('#passwdCheck').empty();
				$('#passwdCheck').append('비밀번호 일치 하지 않음').css('color', 'red');
				isPassed = false;
			} else{
				$('#passwdCheck').empty();
				$('#passwdCheck').append('비밀번호 일치').css('color', 'green');
				isPassed = true;
			}
			
	 		if (frm.passwd.value.length==0 && frm.passwd2.value.length==0){
				$('#passwdCheck').empty();
			} 
	});

	$('#join').submit(function(event){
		if (isPassed == false){
			event.preventDefault();
			alert('이미 존재하는 아이디이거나 비밀번호가 일치하지 않습니다.');
		}		
	}); 	
	
});


</script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!-- <script>
function winopen() {
	// id 입력란이 공백이면 '아이디 입력하세요' 포커스주기
	// 공백이 아니면 id체크하는 팝업창 띄우기
	if (frm.id.value == '') {
		alert('아이디 입력하세요');
		frm.id.focus();
		return;
	}
	
	var fid = frm.id.value;
	// 팝업창 띄우기  join_IDCheck.jsp width=400,height=200
	window.open('join_IDCheck.jsp?userid=' + fid, '', 'width=400,height=200');
}

</script> -->
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
<li><a href="#">Join us</a></li>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" method="post" id="join" name="frm" onsubmit="confirm('가입하시겠습니까?')">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" required><span id="idCheck"> </span><br>
<!-- <input type="button" value="dup. check" class="dup" onclick="winopen()"><br> -->

<label>Password</label>
<input type="password" name="passwd" id="passwd" required><span id="passwdCheck"> </span><br>

<label>Retype Password</label>
<input type="password" name="passwd2" id="passwd2"required><br>

<label>Battle Tag</label>
<input type="text" name="battletag" required><br>

<label>Gender</label>
<input type="radio" name="gender" value="female" required>여자
<input type="radio" name="gender" value="male" >남자<br><br>

<label>Position</label>
	<select name="playmain" required>
		<option value="dealer">딜러</option>
		<option value="tanker">탱커</option>
		<option value="healer">힐러</option>
	</select><br><br>


<label>Birthday</label>
<input type="date" name="birthday" required><br>

<label>E-Mail</label>
<input type="email" name="email" required><br><br><br>


<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
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