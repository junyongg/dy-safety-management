<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
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
<select>
	<option>메인</option>
	<option>최근 게시물</option>
	<option>페이지 평가 내역</option>
	<option>신규가입</option>
	<option>메뉴별 통계 그래프</option>
	<option>키워드 관리</option>
</select>


<div id="content">
	<section id="widget-grid">
		<div class="row">
			<article class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
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
							<div class="tab-content">
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
							<script src="/resources/smartadmin/js/plugin/horizontal/jquery.horizBarChart.js"></script>
							
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
			</article>
			<article class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
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

							
							<div class="tab-content">
								<table id="dt_basic"
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
			</article>
		</div>
			
		<div class="row">
			<article class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"><i class="fa fa-table"></i>
						</span>
						<h2>페이지 평가 내역</h2>
					</header>
					<!-- 			<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable"> -->
					<!-- 				<div class="jarviswidget" id="" data-widget-editbutton="false"> -->
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>페이지 평가 상위 5건</legend>
							<c:set var="memberTotal" value="0" />
							<c:set var="leaveMemberTotal" value="0" />
							<fmt:formatNumber type="currency" value="${resultListcnt }"
								pattern="###,###" var="PageTotalNumber" />
							<p>총 게시물 ${PageTotalNumber }건</p>
							<div class="tab-content">
								<table id="dt_basic"
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
			</article>
			<article class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
					data-widget-editbutton="false">
					<header>
						<span class="widget-icon"><i class="fa fa-bar-chart-o"></i>
						</span>
						<h2>메뉴별 통계 그래프</h2>
					</header>
					<!-- 			<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable"> -->
					<!-- 				<div class="jarviswidget" id="" data-widget-editbutton="false"> -->
					<div class="widget-body">
						<div class="form-horizontal bv-form">
							<legend>메뉴별 통계 5건 목록</legend>
							
							<div class="tab-content">
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
							<script src="/resources/smartadmin/js/plugin/horizontal/jquery.horizBarChart.js"></script>
							
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
			</article>
		</div>
			
			
		<div class="row">
			<article class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-2"
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
							<div class="tab-content">
								<table id="dt_basic"
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
			</article>
		</div>
	</section>
</div>
<script>
$(document).ready(function(){
	getHtml();
});

function getHtml(){
	$.ajax({
		type : "post",
		url : "/txap/statistics/menucount/pr_pagingAjax.do",
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

function delete_save(){
	
 
	
}

</script>
