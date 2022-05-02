<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link type="text/css" rel="stylesheet" href="/resources/publish/jact/css/board.css">
<style>
.searchKeyword{color: #3a7ab8;}
</style>
<!-- 본문 시작 -->
<!-- 블랙박스 -->
<div id="black-box" onclick="mobileMenuHide()"></div>
	
	<!-- 서브내용 시작 -->
<form:form id="Form" method="post" action="/jact/use/search.do">
<input type="hidden" name="pageIndex" id="pageIndex" value="1">
<input type="hidden" name="OrderConditions" id="OrderConditions" value="${OrderCondition }">
	<section id="sub-content">
		<div class="inner1200">
			<!--inner 시작 -->
			<!-- 서브 타이틀부분 -->
			<div class="sub-title-box">
				<h2>통합검색</h2>
				<ul class="list_ul">
					<li class="home"><i class="xi-home"></i></li>
					<li>통합검색</li>
				</ul>
			</div>
			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">
				<!-- 통합컨텐츠 검색 -->
				<div class="searchAll-search-box">
	                <div class="top-box clearfix">
	                    <div class="select-b">
	                        <select class="select-searchAll" name="select_menu" id="select_menu" >
	                            <option value="all" selected>전체</option>
	                            <option value="menu">메뉴검색</option>
	                            <option value="page">웹페이지</option>
	                            <option value="board">게시물</option>
	                            <option value="file">첨부파일</option>
	                        </select>
	                    </div>
	                    <div class="text-b">
	                        <input type="text" class="text-searchAll" name="searchKeyword" id="searchKeyword" value="${search.searchKeyword }" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" >
	                    </div>
	                    <div class="btn-b">
	                        <button type="submit" class="btn-searchAll" onclick="return pf_totalSearch()" >
	                            <i class="xi-search"></i>
	                            <span>검색</span>
	                        </button>
	                    </div>
	                    
	                    <div class="research-b">
	                        <label><input type="checkbox" id="checking"> 결과 내 재검색</label>
	                    </div>
	                </div>

	                <div class="bottom-box clearfix">
	                    <div class="range-b" id="keysearch" style="display: none">
	                        <span class="sub-t">상세검색</span>
	                        <label><input type="text" name="keyword2" id="keyword2" value="${keyword2 }" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" ></label>
	                    </div>
	                    <div class="align-b" >
	                        <span class="sub-t">정렬방식</span>
	                        <div class="s-box">
	                            <select class="select-searchAll" name="orderCondition" id="orderCondition">
	                                <option value="A" id="a">정확도순</option>
	                                <option value="B" id="b">제목순</option>
	                                <option value="C" id="c">날짜순</option>
	                            </select>
	                        </div>
	                        <div class="s-box">
	                            <select class="select-searchAll" name="upanddown" id="upanddown"> 
	                                <option value="down">내림차순</option>
	                                <option value="up">오름차순</option>
	                            </select>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <!-- 통합검색 탭 부분 -->
	            <div class="searchAll-tab-wrap">
	                <ul class="searchAll-tab-ul">
	                    <li class="active" name="all_1">
	                        <a href="javascript:;" onclick="pf_searchTab('all',this)">
	                            <span class="txt">통합검색</span>
	                        </a>
	                    </li>
	                    <li name="menu_1">
	                        <a href="javascript:;" onclick="pf_searchTab('menu',this)">
	                            <span class="txt">메뉴검색</span>
	                            <span class="icon"><i class="xi-angle-down-min"></i></span>
	                        </a>
	                    </li>
	                    <li name="page_1">
	                        <a href="javascript:;" onclick="pf_searchTab('page',this)">
	                            <span class="txt">웹페이지</span>
	                            <span class="icon"><i class="xi-angle-down-min"></i></span>
	                        </a>
	                    </li>
	                    <li name="board_1">
	                        <a href="javascript:;" onclick="pf_searchTab('board',this)">
	                            <span class="txt">게시물</span>
	                            <span class="icon"><i class="xi-angle-down-min"></i></span>
	                        </a>
	                    </li>
	                    <li name="file_1">
	                        <a href="javascript:;" onclick="pf_searchTab('file',this)">
	                            <span class="txt">첨부파일</span>
	                            <span class="icon"><i class="xi-angle-down-min"></i></span>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <!-- 통합검색 결과 텍스트 -->
	            <c:set var="total" value="${menuPaginationInfo.totalRecordCount + eventPaginationInfo.totalRecordCount + boardPaginationInfo.totalRecordCount + filePaginationInfo.totalRecordCount}"/>
	            
	            <div class="searchAll-show-txt">
	                <span>'${search.searchKeyword }'</span>에 대한 <span>검색결과</span>입니다.
	            </div>
	            <!-- 통합검색 결과 내용 -->
	            <div class="searchAll-result-wrap" >
	                <!-- 메뉴검색 -->
	                <div class="result-one" id="menus" >
	                    <div class="top-title">
	                        <span class="icon"><i class="xi-angle-right-min"></i></span>
	                        <span class="text">메뉴검색</span>
	                        <span class="re-txt">총 ${menuPaginationInfo.totalRecordCount }건</span>
	                        <button type="button" class="more-btn" onclick="pf_linkpage_menu(1)">
	                            <span>더보기</span> <i class="xi-plus-min"></i>
	                        </button>
	                    </div>
	                    
	                    <div class="re-content re-c-menu" id="menuDirectSearchGo">
	                        <ul class="re-c-menu-ul">
	                            <c:forEach items="${menuSearchList }" var="model" varStatus="menuStatus">
	                           		<li>
	                           		<a href="${model.MN_URL }"  target="_blank">
	                            [	<c:forEach items="${fn:split(model.MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
			                                
			                                	<c:if test="${!nameStatus.last }" >
														${name}&gt;
			                                	</c:if>
			                                	<c:if test="${nameStatus.last}">
			                                		${name}
			                                	</c:if>
			                                	
	                            	</c:forEach> ]
	                        		</a>
	                            	</li>
	                            </c:forEach>
	                        </ul>
	                    </div>
	                </div>
	                <!-- 메뉴검색끗 -->
	                    
                    <!-- 웹페이지 검색 -->
                    <div class="result-one" id="pages">
                    	<div class="top-title">
	                        <span class="icon"><i class="xi-angle-right-min"></i></span>
	                        <span class="text">웹페이지</span>
	                        <span class="re-txt">총 ${PaginationInfo.totalRecordCount }건</span>
	                        <button type="button" class="more-btn" onclick="pf_linkpage_page(1)">
	                            <span>더보기</span> <i class="xi-plus-min"></i>
	                        </button>
	                    </div>
	                  <div class="re-content re-c-website" id="pageDirectSearchGo">
	                    <c:forEach items="${PageSearchList }" var="model">
	                        <div class="one">
	                            <div class="address">
	                              [ <c:forEach items="${fn:split(model.PG_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
			                               <c:if test="${!nameStatus.last }" >
			                             	 ${name}&gt;
			                               </c:if>
			                               <c:if test="${nameStatus.last }">
												${name}
										   </c:if> 
	                            	</c:forEach>]
	                            </div>
	                            <div class="info">
	                                <ul>
<%-- 	                              	<li>작성자 : ${model.UI_NAME }</li> --%>
	                                    <li>작성일 : ${fn:substring(model.MVD_REGDT,0,10) }</li>
	                                </ul>
	                            </div>
	                            <div class="title">
	                                <a href="${model.MN_URL }" target="_blank">${model.MN_NAME }</a>
	                            </div>
	                            <div class="content">
	                             	  ${model.MVD_DATA }  
	                            </div>
	                        </div>
	                      </c:forEach>
	                   </div>
                    </div>
	                <!-- 웹페이지 끗 -->   
	                <!-- 게시물 시작 -->
	                <div class="result-one" id="boards">
                    	<div class="top-title">
	                        <span class="icon"><i class="xi-angle-right-min"></i></span>
	                        <span class="text">게시물</span>
	                        <span class="re-txt">총 ${boardPaginationInfo.totalRecordCount }건</span>
	                        <button type="button" class="more-btn" onclick="pf_linkpage_board(1)">
	                            <span>더보기</span> <i class="xi-plus-min"></i>
	                        </button>
	                    </div>
	                  <div class="re-content re-c-website" id="boardSearchGo">
	                    <c:forEach items="${boardSearchList }" var="model">
	                        <div class="one">
	                            <div class="address">
	                              [  <c:forEach items="${fn:split(model.BD_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
			                              <c:if test="${!nameStatus.last }" >
			                                ${name}&gt;
			                               </c:if>
			                               <c:if test="${nameStatus.last }">
												${name} 
										   </c:if>
										   
	                            	</c:forEach>]
	                            </div>
	                            <div class="info">
	                                <ul>
	                                    <li>작성일 : ${fn:substring(model.BN_REGDT,0,10) }</li>
	                                </ul>
	                            </div>
	                            <div class="title">
	                            
	                                <a href="/jact/Board/${fn:substring(model.BN_KEYNO,8,15) }/detailView.do" target="_blank">${model.BN_TITLE }</a>
	                            </div>
	                            <div class="content">
	                             	  ${model.BN_CONTENTS }  
	                            </div>
	                        </div>
	                      </c:forEach>
	                   </div>
                    </div>
	                <!-- 게시물 끗 -->
	                <!-- 첨부파일 시작 -->
	                <div class="result-one" id="files">
                    	<div class="top-title">
	                        <span class="icon"><i class="xi-angle-right-min"></i></span>
	                        <span class="text">첨부파일</span>
	                        <span class="re-txt">총 ${filePaginationInfo.totalRecordCount }건</span>
	                        <button type="button" class="more-btn" onclick="pf_linkpage_file(1)">
	                            <span>더보기</span> <i class="xi-plus-min"></i>
	                        </button>
	                    </div>
	                  <div class="re-content re-c-website" id="fileSearchGo">
	                    <c:forEach items="${fileSearchList }" var="model">
	                        <div class="one">
	                            <div class="address">
	                             [  <c:forEach items="${fn:split(model.FS_MN_MAINNAMES,',') }" var="name" varStatus="nameStatus">
			                               
			                               <c:if test="${!nameStatus.last }" >
			                               	 ${name}&gt;
			                               </c:if>
			                               <c:if test="${nameStatus.last }">
												${name}
										   </c:if>
										   
	                            	</c:forEach>
	                            	]
	                            </div>
	                            <div class="info">
	                                <ul>
	                                    <li>작성일 : ${fn:substring(model.BN_REGDT,0,10) }</li>
	                                </ul>
	                            </div>
	                            <div class="title">
	                                <a href="/jact/Board/${fn:substring(model.BN_KEYNO,8,15) }/detailView.do">${model.BN_TITLE }</a>
	                                <button type="button" class="atta-btn" onclick="cf_download('${model.FS_KEYNO}')">
	                                    <i class="xi-cloud-download"></i>다운로드
	                                </button>
	                            </div>
	                            <div class="content">
	                             	  ${model.BN_CONTENTS }  
	                            </div>
	                        </div>
	                      </c:forEach>
	                   </div>
                    </div>
	                <!-- 첨부파일 끗 -->
	               <!--  통합검색 결과 내용 끗 -->
	               
	               </div>
	            </div>
			</div>
		</div>
	</section>
</form:form>
	

<!-- 본문 끝 -->
<script>
var searchKeyword = '${search.searchKeyword}'.split(' ');
$(function(){
		if("${keyword2}" != null && "${keyword2}" != "" ){
			$("#checking:checkbox").attr("checked","checked");
			$("#keysearch").show();
		}	
	
	$("#checking:checkbox").on('click',function(){
		if($("#keysearch").css("display") == "none"){
			$("#keysearch").show()
		}else{
			$("#keysearch").hide()
			$("#keyword2").val("");
		}
	});
	//순차...
	if('${OrderCondition}' == 'A'){
		$("#a").attr('selected','selected')
	}else if('${OrderCondition}' == 'B'){
		$("#b").attr('selected','selected')
	}else{
		$("#c").attr('selected','selected')
	}
	//올림 내림
	if('${Updown}' == 'up'){
		$('#upanddown').val('up');
	}else{
		$('#upanddown').val('down');
	}
	//메뉴
	$('#select_menu').val('${select_menu}');
	var name = '${select_menu}' + "_1";
	pf_searchTab('${select_menu}',this)
	$('li[name='+name+']').addClass('active');
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

//메뉴검색 - 페이징
function pf_linkpage_menu(num){
		pf_linkpage(num,'/jact/search/menu/dataAjax.do','#menuDirectSearchGo')	
}

//페이지 검색 - 페이징
function pf_linkpage_page(num){
	pf_linkpage(num,'/jact/search/page/dataAjax.do','#pageDirectSearchGo')
}

//게시판검색 - 페이징
function pf_linkpage_board(num){
	pf_linkpage(num,'/jact/search/board/dataAjax.do','#boardSearchGo')
}

//자료검색 - 페이징
function pf_linkpage_file(num){
	pf_linkpage(num,'/jact/search/file/dataAjax.do','#fileSearchGo')
}


// //페이징
function pf_linkpage(num,url, obj){
	cf_loading()
	$('#pageIndex').val(num);
	$(obj).load(url,$('#Form').serializeArray(),function(){
		cf_loading_out()
// 		pf_highlight_text(obj + ' .searchText')
	})
}

// //탭 이동 "searchRow" contentsBox selectCategoryUl
function pf_searchTab(id,obj,name){
	$('.searchAll-tab-ul li').removeClass('active');
	$(obj).closest('li').addClass('active');
	if(id == 'menu'){
		pf_linkpage_menu(1);
		$('#pages').hide();
		$('#boards').hide();
		$('#files').hide();
		$('#menus').show();
	}else if(id == 'page'){
		pf_linkpage_page(1);
		$('#pages').show();
		$('#boards').hide();
		$('#files').hide();
		$('#menus').hide();
		
	}else if(id == 'board'){
		pf_linkpage_board(1);
		$('#pages').hide();
		$('#boards').show();
		$('#files').hide();
		$('#menus').hide();
	}else if(id == 'file'){
		pf_linkpage_file(1);
		$('#pages').hide();
		$('#boards').hide();
		$('#files').show();
		$('#menus').hide();
	}else{
		$('#menus').show();
		$('#pages').show();
		$('#boards').show();
		$('#files').show();
	}
	
	
}
/**
 * 파일 다운로드 처리 
 * @param filekey
 */
function cf_download(filekey){
	location.href="/async/MultiFile/download.do?FS_KEYNO=" + filekey;
}

</script>
