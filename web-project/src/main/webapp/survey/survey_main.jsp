<%@page import="com.project.domain.Survey"%>
<%@page import="com.project.repository.SurveyDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="survey_main.jsp">투표중</a></li>
<li><a href="survey_finished.jsp">투표완료</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
	// DB객체생성
	SurveyDao surveyDao = SurveyDao.getInstance();

	int count = surveyDao.getSurveyingCount();


	// 우리가 원하는 페이지 가져오기
	// 한페이지당 보여줄 글개수 설정
	int pageSize = 15;
	// 페이지 가져오기
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null) {
		strPageNum = "1";
	}
	int pageNum = Integer.parseInt(strPageNum);
	// 시작(첫)행번호 구하기
	int startRow = (pageNum-1)*pageSize+1;
	// 마지막(끝)행번호 구하기
	int endRow = pageNum * pageSize;

	List<Survey> list = null;

    list = surveyDao.getSurveysWithLimit(startRow, pageSize);

	
	// 날짜 포맷 준비
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
%>
<article>
<h1>설문 진행중  [전체글개수: <%=count %>]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
if (count > 0) {
    // 공지사항으로 설정된 글이 있으면 테이블 위에 행 추가
                     
    
    for (int i=0; i<list.size(); i++) {
        Survey survey = list.get(i);
        %>
        <tr onclick="location.href='survey_content.jsp?num=<%=survey.getNum() %>&pageNum=<%=pageNum%>'">        

        	<td><%=survey.getNum() %></td>
        	<td class="left"><%=survey.getQuestion() %></td>
        	<td><%=survey.getId() %>
        	<td><%=sdf.format(survey.getReg_date()) %></td>
        	<td><%=survey.getReadcount() %></td>
        </tr>
        <%
    }
} else { // count == 0
    %>
    <tr><td colspan="5">게시판 글 없음</td></tr>
    <%
}
%>
</table>

<%
// 세션 가져오기
String id = (String) session.getAttribute("id");
// 세션값이 있으면 글쓰기 버튼이 보이게 설정
if (id != null) {
    %>
    <div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='survey_write.jsp'">
	</div>
    <%
}
%>


<div class="clear"></div>

<div id="page_control">
<%
	if (count > 0) {
		// 전체 페이지 개수 구하기
		// 글50개  한화면당 보여줄글 10개 => 50/10 = 몫5 + 나머지X(0페이지) => 5페이지
		// 글55개  한화면당 보여줄글 10개 => 55/10 = 몫5 + 나머지O(1페이지) => 6페이지
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
		
		// 화면에 보여줄 페이지블록 개수 설정
		int pageBlock = 10;
		
		// 화면에 보여줄 시작페이지블록 구하기
		// 1~10  11~20  21~30
		// 1~10 => 1    11~20 => 11
		//int startPage = (pageNum-1) * pageBlock + 1;
		// 페이지블록   [1][2][3]  페이블록개수 3설정
		int startPage = ((pageNum/pageBlock) - (pageNum%pageBlock==0 ? 1: 0)) * pageBlock + 1;
		
		//  끝페이지블록 번호 구하기
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		%>
		<div id="PageBlock">
		<%
		// [이전]
		if (startPage > pageBlock) {
			%><a href="survey_content.jsp?pageNum=<%=startPage-1 %><%--&search=<%=search%>--%>">[이전]</a><%
		}
		
		// 1~10
		for (int i=startPage; i<=endPage; i++) {
		    %><a href="survey_content.jsp?pageNum=<%=i %><%--&search=<%=search%>--%>"><%
		    if (i == pageNum) {
		        %><b>[<%=i %>]</b><%
		    } else {
		        %>[<%=i %>]<%
		    }
		    %></a><%
		}
		
		// [다음]
		if (endPage < pageCount) {
			%><a href="survey_content.jsp?pageNum=<%=startPage+pageBlock %><%--&search=<%=search%>--%>">[다음]</a><%
		}
		%>
		</div>
		<%
	}
%>
</div>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.jsp" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>