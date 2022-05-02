<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">
<style>
.searchKeyword{color: blue}
</style>
<!-- 본문 시작 -->
<div class="subContentInner">
	<form:form id="Form" method="post" action="/jcia/search.do">
	<input type="hidden" name="pageIndex" id="pageIndex" value="1">
	<input type="hidden" name="detail" id="detail" value="">
	
	
	<div class="detailSearch">
		<button type="button" class="btn" onclick="$('.detailSearchWrap').stop().slideToggle(300)">
			<span class="icon"><i class="far fa-search"></i></span>
	                        상세검색
		</button>
	</div>
	<div class="searchBox_01">
		<div class="inner clearfix">
			<span class="searchPerson_Span">검색어 </span> 
			<label for="searchKeyword" class="blind">검색어를 입력하세요</label>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${search.searchKeyword }" class="txtDefault txtSearch txtSearch_Size01" placeholder="검색어를 입력하세요" title="검색어를 입력하세요">
			<button type="submit" class="btnDefault btnSizeSearch btnBgBlue" onclick="return pf_totalSearch()">검색</button>
		</div>
	</div>
	<div class="detailSearchWrap" style="display:none;">
		<ul class="detailSearchUl">
			<li>
				<h1>정렬</h1>
				<div class="labelBox">
					<label><input type="radio" name="orderCondition" value="A">
						정확도순</label> <label><input type="radio" name="orderCondition" value="B">
						제목순</label> <label><input type="radio" name="orderCondition" value="C">
						등록일순</label>
				</div>
			</li>
			<li>
				<h1>기간</h1>
				<div class="labelBox">
					<label><input type="radio" name="searchCondition" value="all">전체</label> 
					<label><input type="radio" name="searchCondition" value="day">1일</label> 
					<label><input type="radio" name="searchCondition" value="week">1주</label> 
					<label><input type="radio" name="searchCondition" value="month">1달</label> 
					<label><input type="radio" name="searchCondition" value="year">1년</label> 
					<label><input type="radio" name="searchCondition" value="etc">직접입력</label> 
					<label for="searchBeginDate" class="blind">검색 시작일</label>
					<input type="text" name="searchBeginDate" id="searchBeginDate" class="txtDefault hasDatepicker" title="검색 시작일"> ~ 
					<label for="searchEndDate" class="blind">검색 종료일</label>
					<input type="text" name="searchEndDate" id="searchEndDate" class="txtDefault hasDatepicker" title="검색 종료일">
				</div>
			</li>
		</ul>
		<div class="btnBox">
			<button type="submit" class="btn btnSmall_03 bgColorRLine" onclick="pf_detailTotalSearch()">상세검색</button>
			<button type="reset" class="btn btnSmall_03 bgWhiteLine">초기화</button>
			<button type="button" class="btn btnSmall_03 bgWhiteLine" onclick="$('.detailSearchWrap').stop().slideUp(300)">닫힘</button>
		</div>
	</div>
	</form:form>
	
	
	<c:set var="total" value="${menuPaginationInfo.totalRecordCount + eventPaginationInfo.totalRecordCount + boardPaginationInfo.totalRecordCount + filePaginationInfo.totalRecordCount}"/>
	<div class="searchTabWrap clearfix">
		<h2>
			검색결과 <span class="colorB">'${search.searchKeyword }'</span>에 대하여 총 <span class="colorB">[${total }건]</span>이
			검색되었습니다.
		</h2>
		<ul class="selectCategoryUl clearfix">
			<li class="active"><a href="javascript:;" onclick="pf_searchTab('all',0)">전체(${total })</a></li>
			<li><a href="javascript:;" onclick="pf_searchTab('menuDirectSearchGo',1)">메뉴바로가기(${menuPaginationInfo.totalRecordCount })</a></li>
			<li><a href="javascript:;" onclick="pf_searchTab('boardSearchGo',2) ">게시판(${boardPaginationInfo.totalRecordCount })</a></li>
			<li><a href="javascript:;" onclick="pf_searchTab('fileSearchGo',3) ">자료(${filePaginationInfo.totalRecordCount })</a></li>
		</ul>
	</div>
	<c:if test="${menuPaginationInfo.totalRecordCount gt 0 }">
	<div class="searchRow">
		<div class="titleBox">
			<h2>메뉴바로가기 : ${menuPaginationInfo.totalRecordCount }건</h2>
			<h3>
				<c:if test="${menuPaginationInfo.totalRecordCount gt 3 }">
				<a href="javascript:;" onclick="pf_linkpage_menu(1)">더보기+</a>
				</c:if>
			</h3>
		</div>
		<div class="contentsBox menuDirectSearchGo" id="menuDirectSearchGo">
			<c:forEach items="${menuSearchList }" var="model" varStatus="menuStatus">
			<div class="row">
				<h2>
					<c:forEach items="${fn:split(model.MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
						<c:if test="${!nameStatus.last }">
						${name} &gt;
						</c:if>
						<c:if test="${nameStatus.last }">
						<font class="searchText">${name}</font> 
						</c:if>
					</c:forEach>
				</h2>
				<div class="searchContents">${model.MVD_DATA }</div>
				<h3>
					<a href="${model.MN_URL }" target="_blank">http://www.gjcf.or.kr${model.MN_URL }</a>
				</h3>
				<p class="word">검색된 단어 :: <b>${model.keyword }</b></p>
			</div>
			</c:forEach>
		</div>
	</div>
	</c:if>
	<c:if test="${boardPaginationInfo.totalRecordCount gt 0 }">
	<div class="searchRow">
		<div class="titleBox">
			<h2>게시판 : ${boardPaginationInfo.totalRecordCount }건</h2>
			<h3>
				<c:if test="${boardPaginationInfo.totalRecordCount gt 3 }">
				<a href="javascript:;" onclick="pf_linkpage_board(1)">더보기+</a>
				</c:if>
			</h3>
		</div>
			<div class="contentsBox boardSearchGo" id="boardSearchGo">
				<c:forEach items="${boardSearchList }" var="model">
				<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
				<div class="row">
					<h2>
						<c:if test="${not empty model.BN_MN_KEYNO }">
							<a href="/jcia/Board/${BN_KEYNO_NUMBERTYPE }/detailView.do" target="_blank" title="${model.BN_TITLE }">
						</c:if>
						<c:if test="${empty model.BN_MN_KEYNO }">
							<a href="/jcia/information/newsletter/${BN_KEYNO_NUMBERTYPE }/detail.do" target="_blank" title="${model.BN_TITLE }">
						</c:if>
						<font class="searchText">${model.BN_TITLE }</font> 
						</a>
						<span class="date">/ ${fn:substring(model.BN_REGDT,0,10) }</span>
					</h2>
					<div class="clear"></div>
					<div class="searchContents">${model.BN_CONTENTS }</div>
					<h4>
						<c:forEach items="${fn:split(model.MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
							<c:if test="${!nameStatus.last }">
							${name} <span class="colorG_666">&gt;</span>
							</c:if>
							<c:if test="${nameStatus.last }">
								<c:if test="${empty name}">
									<a href="/jcia/information/newsletter.do" target="_blank"><c:out value="전남정보문화산업진흥원 > 알림마당 > 뉴스레터"/></a> 
								</c:if>
								<c:if test="${not empty name}">
									<a href="${model.MN_URL }" target="_blank"><c:out value="${name}"/></a> 
								</c:if>
							</c:if>
						</c:forEach>
					</h4>
					<p class="word">검색된 단어 :: <b>${model.keyword }</b></p>
				</div>
				</c:forEach>
			</div>
	</div>
	</c:if>
	<c:if test="${filePaginationInfo.totalRecordCount gt 0 }">
	<div class="searchRow">
		<div class="titleBox">
			<h2>자료 : ${filePaginationInfo.totalRecordCount }건</h2>
			<h3>
				<c:if test="${filePaginationInfo.totalRecordCount gt 3 }">
				<a href="javascript:;" onclick="pf_linkpage_file(1)">더보기+</a>
				</c:if>
			</h3>
		</div>
		<div class="contentsBox boardSearchGo dataSearchGo" id="fileSearchGo">
			<div class="row">
				<c:forEach items="${fileSearchList }" var="model">
				<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
				<div class="row">
					<h2>
						<a href="/jcia/Board/${BN_KEYNO_NUMBERTYPE }/detailView.do" target="_blank" title="${model.BN_TITLE }">
						${model.BN_TITLE } 
						</a>
						<span class="date">/ ${fn:substring(model.BN_REGDT,0,10) }</span>
					</h2>
					<div class="clear"></div>
					<h3>
						<img src="/resources/img/icon/icon_attachment_01.png" alt="첨부파일 아이콘"> 
						첨부파일 : <a href="javascript:;" onclick="cf_download('${model.FS_KEYNO}')"><font class="searchText">${model.FS_ORINM}</font></a> (1.2M)
					</h3>
					<h4>
						<c:forEach items="${fn:split(model.MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
							<c:if test="${!nameStatus.last }">
							${name} <span class="colorG_666">&gt;</span>
							</c:if>
							<c:if test="${nameStatus.last }">
							<a href="${model.MN_URL }" target="_blank">${name}</a> 
							</c:if>
						</c:forEach>
					</h4>
					<p class="word">검색된 단어 :: <b>${model.keyword }</b></p>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</c:if>
</div>
<!-- 본문 끝 -->
<script>
var searchKeyword = '${search.searchKeyword}'.split(' ');
$(function(){
	
	$('#searchKeyword').autocomplete({
		source: keywordList,
		focus: function( event, ui ) {
			return false; 
		}
	}); 
	
	
	var detail = '${detail}';
	if(detail){
		$('.detailSearchWrap').show();
		var orderCondition = '${search.orderCondition}'
		if(orderCondition){
			$('input[name=orderCondition][value='+orderCondition+']').attr('checked',true)
		}
		var searchCondition = '${search.searchCondition}';
		if(searchCondition){
			$('input[name=searchCondition][value='+searchCondition+']').attr('checked',true)
			if(searchCondition == 'etc'){
				$('#searchBeginDate').val('${search.searchBeginDate}')
				$('#searchEndDate').val('${search.searchEndDate}')
			}
		}
	}
	
	$('#searchBeginDate, #searchEndDate').datepicker(datepickerOption);
	$('#searchBeginDate, #searchEndDate').change(function(){
		$('input[name=searchCondition][value=etc]').trigger('click')
	})
	pf_highlight_text('.searchText')
})

//텍스트 하이라이트
function pf_highlight_text(obj){
	$(obj).each(function(i){
		for(var i=0;i<searchKeyword.length;i++){
			$(this).html($(this).html().replaceAll(searchKeyword[i],'<font class="searchKeyword">'+searchKeyword[i]+'</font>'))
		}
	})
}

function pf_totalSearch(){
	$('#detail').val('');
	if(!$('#searchKeyword').val()){
		alert('검색어를 입력하여주세요.');
		$('#searchKeyword').focus();
		return false;
	}
	return true;		
}

function pf_detailTotalSearch(){
	$('#detail').val('detail');
	if(!$('#searchKeyword').val()){
		alert('검색어를 입력하여주세요.');
		$('#searchKeyword').focus();
		return false;
	}
	return true;
}


//메뉴검색 - 페이징
function pf_linkpage_menu(num){
	pf_linkpage(num,'/jcia/search/menu/dataAjax.do','#menuDirectSearchGo')
}

//게시판검색 - 페이징
function pf_linkpage_board(num){
	pf_linkpage(num,'/jcia/search/board/dataAjax.do','#boardSearchGo')
}
//자료검색 - 페이징
function pf_linkpage_file(num){
	pf_linkpage(num,'/jcia/search/file/dataAjax.do','#fileSearchGo')
}


//페이징
function pf_linkpage(num,url, obj){
	cf_loading()
	$('#pageIndex').val(num);
	$(obj).load(url,$('#Form').serializeArray(),function(){
		cf_loading_out()
		pf_highlight_text(obj + ' .searchText')
	})
}

//탭 이동 "searchRow" contentsBox selectCategoryUl
function pf_searchTab(id,index){
	
	$('.selectCategoryUl li').removeClass('active').eq(index).addClass('active');
	
	if(id == 'all'){
		$('.searchRow').show();
	}else{
		$('.searchRow').hide();
		$('#'+id).parents('.searchRow').show();
	}
	
}


</script>
