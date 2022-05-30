<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script src="/resources/smartadmin/js/plugin/horizontal/jquery.horizBarChart.js"></script>
<style>
textarea {
	resize: none;
}
 .visitor_bar{
	position: relative;
	height: 20px;
	margin:0;
}
.visitor_bar span {
    position: absolute;
  	top:6px;
    left: 0;
    height: 15px;
    background: #ddd;
}
.footTr{ 
    background: #878787;
	color: #fff;
}
 .footTd{text-align: center;}
    
</style>
 <%
Cookie[] cookies = request.getCookies(); //쿠키 목록 받아오기
String cookiename = "";
String cookie_check = "0";

for(Cookie cookie: cookies) {
	if("main".equals(cookie.getName())) {
		cookiename = cookie.getValue();
	}
}

if(cookiename == ""){
	cookiename = "1%2C2%2C3%2C4%2C5";
}

String[] Cookielist = cookiename.split("%2C");
%> 

<select id="ch_cookie"  class="form-control search-control"  onchange="create_cookie()" style="width: 20%;margin-left:14px;">
	<option value= "">띄울 리스트를 선택하세요</option>
	<option value= "1">키워드 관리</option>
	<option value= "2">최근 게시물</option>
	<option value= "3">페이지 평가 내역</option>
	<option value= "4">메뉴별 통계 그래프</option>
	<option value= "5">신규가입</option>
</select>

<div id="content">
	<section id="widget-grid">
	<div class="row">
	<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
			<% if(Cookielist[0].equals("1")) {%>
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"><i class="fa fa-table"></i>
						</span>
						<h2>키워드 리스트</h2>
					</header>
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>키워드 검색 5순위</legend>
							<c:set var="memberTotal" value="0" />

							<fmt:formatNumber type="currency" value="${keywordListcnt }"
								pattern="###,###" var="KeywordTotalNumber" />


							<p>총 게시물 ${KeywordTotalNumber }건</p>
							<div class="table-responsive">
								<table id="dt_basic"
									class="table table-striped table-bordered table-hover"
									width="100%">
									<thead>
										<tr>
											<th>번호</th>
											<th>키워드</th>
											<th>검색수</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${keywordList }" var="model"
											varStatus="status">
											<tr>
												<td>${model.COUNT }</td>
												<td class="keywordData">${model.SK_KEYWORD }</td>
												<td>${model.SK_SIZE }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<sec:authorize url="/txap/func/keyword.do">
								<fieldset class="padding-10 text-right">
									<a href="/txap/func/keyword.do" class="btn btn-sm btn-primary">
										<i class="fa fa-floppy-o"></i> 더보기
									</a>
								</fieldset>
							</sec:authorize>
						</div>
					</div>
				</div>
				<%} if(Cookielist[1].equals("2")) { %>
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-1"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<h2>최근 게시물</h2>
					</header>
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>최근 게시물 5건</legend>
						<c:set var="boardTotal" value="0" />
						<c:if test="${not empty boardlist }">
							<c:set var="boardTotal" value="${boardlist[0].BN_TOTAL }" />
						</c:if>
						<fmt:formatNumber type="currency" value="${boardTotal }"
							pattern="###,###" var="boardTotalNumber" />
						<p>총 게시물 ${boardTotalNumber }건</p>

							
							<div class="table-responsive">
								<table id="dt_basic_1"
								class="table table-striped table-bordered table-hover"
								width="100%">
								<thead>
									<tr>
										<th data-hide="phone">번호</th>
										<th>게시판</th>
										<th data-class="expand"><i
											class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i>
											제목</th>
										<th>작성자</th>
										<th>작성일</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${boardlist}" var="model" varStatus="status">
										<sec:authorize url="/txap/Board/dataView.do" var="boardAuth" />
										<c:choose>
											<c:when test="${boardAuth}">
												<tr class="pointer"
													onclick="location.href='/txap/Board/dataView.do?MN_KEYNO=${model.BN_MN_KEYNO}'">
											</c:when>
											<c:otherwise>
												<tr>
											</c:otherwise>
										</c:choose>

										<fmt:parseNumber value="${fn:substring(model.BN_KEYNO,5,20) }"
											var="bnNumber" />
										<td>${bnNumber}</td>
										<td>${model.MN_NAME }</td>
										<td><c:out value="${model.BN_TITLE}" escapeXml="true" /></td>
										<td>${model.BN_UI_NAME }</td>
										<td>${fn:substring(model.BN_REGDT,0,20) }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</div>
							<c:if test="${boardAuth}">
							<fieldset class="padding-10 text-right">
								<a href="/txap/Board/dataView.do" class="btn btn-sm btn-primary">
									<i class="fa fa-floppy-o"></i> 더보기
								</a>
							</fieldset>
						</c:if>
						</div>
					</div>
				</div>
			<%} if(Cookielist[2].equals("3")) { %>
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"><i class="fa fa-table"></i>
						</span>
						<h2>페이지 평가 내역</h2>
					</header>
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>페이지 평가 상위 5건</legend>
							<c:set var="memberTotal" value="0" />
							<c:set var="leaveMemberTotal" value="0" />
							<fmt:formatNumber type="currency" value="${resultListcnt }"
								pattern="###,###" var="PageTotalNumber" />
							<p>총 게시물 ${PageTotalNumber }건</p>
							<div class="table-responsive">
								<table id="dt_basic_2"
									class="table table-striped table-bordered table-hover"
									width="100%">
									<thead>
										<tr>
											<th>번호</th>
											<th>홈페이지</th>
											<th>페이지</th>
											<th>총 인원수</th>
											<th>매우 만족</th>
											<th>만족</th>
											<th>보통</th>
											<th>불만족</th>
											<th>매우 불만족</th>
											<th >결과</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultList }" var="model"
											varStatus="status">
											<tr class="pointer">
												<td>${model.COUNT }</td>
												<td>${model.MN_HOMEDIV_NAME }</td>
												<td><c:out value="${model.MN_NAME }"/></td>
												<td>${model.TOTAL_CNT }</td>
												<td>${model.SCORE_DATA5 }</td>
												<td>${model.SCORE_DATA4 }</td>
												<td>${model. SCORE_DATA3}</td>
												<td>${model. SCORE_DATA2}</td>
												<td>${model.SCORE_DATA1}</td>
												<td>${model. RESULT_DATA}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<sec:authorize url="/txap/operation/pageResearch.do">
								<fieldset class="padding-10 text-right">
									<a href="/txap/operation/pageResearch.do" class="btn btn-sm btn-primary">
										<i class="fa fa-floppy-o"></i> 더보기
									</a>
								</fieldset>
							</sec:authorize>
						</div>
					</div>
				</div>
			<%} %>
				</article>
				
				<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<% if(Cookielist[3].equals("4")) { %>
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-3"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"><i class="fa fa-bar-chart-o"></i>
						</span>
						<h2>메뉴별 통계 그래프</h2>
					</header>
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>메뉴별 통계 5건 목록</legend>
						<div style="margin-bottom:15px;">
							<button class="btn btn-default" onclick="Today()" type="button">일일</button>
							<button class="btn btn-default" onclick="Weekend()" type="button">주간별</button>
							<button class="btn btn-default" onclick="Month()" type="button">월별</button>
						</div>
							<div class="table-responsive">
								<table class="table table-bordered table-hover" id="maintable" style="width:100%;">
									<thead>
										<tr>
											<th width="10%">순위</th>
											<th width="10%">홈페이지</th>
											<th width="10%">메뉴</th>
											<th class="text-center" width="50%">그래프</th>
											<th width="10%">카운트</th>
											<th width="10%">퍼센트</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							
							<sec:authorize url="/txap/statistics/menucount.do">
								<fieldset class="padding-10 text-right">
									<a href="/txap/statistics/menucount.do" class="btn btn-sm btn-primary">
										<i class="fa fa-floppy-o"></i> 더보기
									</a>
								</fieldset>
							</sec:authorize>
						</div>
					</div>
				</div>
			<%} if(Cookielist[4].equals("5")) { %>
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-4"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-table"></i>
						</span>
						<h2>신규 가입</h2>
					</header>
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>신규가입회원 5건 목록</legend>
							<c:set var="memberTotal" value="0" />
							<c:set var="leaveMemberTotal" value="0" />
							<c:if test="${not empty memberlist }">
								<c:set var="memberTotal" value="${memberlist[0].UI_TOTAL }" />
								<c:set var="leaveMemberTotal"
									value="${memberlist[0].UI_TOTAL_LEAVE }" />
							</c:if>
							<fmt:formatNumber type="currency" value="${memberTotal }"
								pattern="###,###" var="memberTotalNumber" />
							<fmt:formatNumber type="currency" value="${leaveMemberTotal }"
								pattern="###,###" var="leaveMemberTotalNumber" />


							<p>총회원수 ${memberTotalNumber }명 중 탈퇴 : ${leaveMemberTotal }명</p>
							<div class="table-responsive">
								<table id="dt_basic_3"
									class="table table-striped table-bordered table-hover"
									width="100%">
									<thead>
										<tr>
											<th data-class="expand"><i
												class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i>
												ID</th>
											<th>이름</th>
											<th data-hide="phone,tablet"><i
												class="fa fa-fw fa-envelope text-muted hidden-md hidden-sm hidden-xs"></i>이메일</th>
											<th data-hide="phone,tablet"><i
												class="fa fa-fw fa-calendar txt-color-blue hidden-md hidden-sm hidden-xs"></i>
												가입날짜</th>
											<th>권한</th>
											<th data-hide="phone,tablet">인증여부</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach items="${memberlist}" var="model"
											varStatus="status">
											<tr class="pointer">
												<td>${model.UI_ID }</td>
												<td>${model.UI_NAME }</td>
												<td>${model.UI_EMAIL }</td>
												<td>${fn:substring(model.UI_REGDT,0,10) }</td>
												<td style="${model.UIA_NAME eq '탈퇴회원' ? 'color:red;':''}">${model.UIA_NAME }</td>
												<td><c:if test="${model.UI_AUTH_YN eq 'Y' }">O</c:if> <c:if
														test="${model.UI_AUTH_YN eq 'N' }">X</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>
							<sec:authorize url="/txap/person/view.do">
								<fieldset class="padding-10 text-right">
									<a href="/txap/person/view.do" class="btn btn-sm btn-primary">
										<i class="fa fa-floppy-o"></i> 더보기
									</a>
								</fieldset>
							</sec:authorize>
						</div>
					</div>
				</div>
			<%} %>
				</article>
				</div>
	</section>
</div>
<script>
var cookieee = [];
var day = new Date();
var Mon = (day.getMonth()+1);
if (Mon < 10) {
	Mon = "0"+Mon
}
var endday = day.getFullYear() + "-" +Mon+ "-" +day.getDate() 

$(document).ready(function(){
	
	cookieee = getCookie("main").split(",");
	getHtml();
	
});

function getHtml(){
	$.ajax({
		type : "post",
		url : "/txap/main/pr_pagingAjax.do", 
		async : false,
		success : function(data) {
			
			$("#maintable tbody").empty().html(data);
			$(document).find('.chart').horizBarChart({
		        selector: '.bar',
		        speed: 500
		    });
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

//쿠키 생성
function setCookie(name, value, expiredays) {
    var cookie = name + "=" + escape(value) + "; path=/;"
    if (typeof expiredays != 'undefined') {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        cookie += "expires=" + todayDate.toGMTString() + ";"
    }
    document.cookie = cookie;
}


function check_name(f){
	if(f == '키워드 리스트'){
		cookieee.splice(0,1,0);
	}
	if(f == '최근 게시물'){
		cookieee.splice(1,1,0);
	}
	if(f == '페이지 평가 내역'){
		cookieee.splice(2,1,0);
	}
	if(f == '메뉴별 통계 그래프'){
		cookieee.splice(3,1,0);
	}
	if(f == '신규 가입'){
		cookieee.splice(4,1,0);
	}
	setCookie("main",cookieee,100);
}

function create_cookie(){
	var number = document.getElementById("ch_cookie");
	var selectvalue = number.options[number.selectedIndex].value;
	var selecttext = number.options[number.selectedIndex].text;
	
	if(selecttext == '키워드 관리'){
		cookieee.splice(0,1,selectvalue);
	}
	if(selecttext == '최근 게시물'){
		cookieee.splice(1,1,selectvalue);
	}
	if(selecttext == '페이지 평가 내역'){
		cookieee.splice(2,1,selectvalue);
	}
	if(selecttext == '메뉴별 통계 그래프'){
		cookieee.splice(3,1,selectvalue);
	}
	if(selecttext == '신규가입'){
		cookieee.splice(4,1,selectvalue);
	}
	setCookie("main",cookieee,100);
	location.reload();
}

//쿠키 추출
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

//일일
function Today(){
	var startday = day.getFullYear() + "-" +Mon+ "-" +day.getDate()  
	Show_by_date(startday,endday);
}
//주간별
function Weekend(){
	var startday = day.getFullYear() + "-" +Mon+ "-" +(day.getDate()-7)  
	Show_by_date(startday,endday);
}

//월별
function Month(){
	var startday = day.getFullYear() + "-" +Mon+ "-01"   
	Show_by_date(startday,endday);
}

//날짜별로 리스트 띄우기
function Show_by_date(startday,endday){
	$.ajax({
		type : "post",
		url : "/txap/main/pr_pagingAjax.do", 
		async : false,
		data : {"STDT":startday,"ENDT":endday},
		success : function(data) {
			
			$("#maintable tbody").empty().html(data);
			$(document).find('.chart').horizBarChart({
		        selector: '.bar',
		        speed: 500
		    });
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}
</script>
