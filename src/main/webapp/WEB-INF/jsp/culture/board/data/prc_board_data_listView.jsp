<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<%@ include file="/WEB-INF/jsp/cf/board/language/prc_board_language.jsp"%>


<jsp:useBean id="toDay" class="java.util.Date" scope="page"/>
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="nowDate" />


<article id="container" class="container_sub clearfix">
	<div class="inner">
		
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
			
				<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'T' }">
					<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
				</c:if>
			
			
				<form:form id="Form" name="Form" method="post">
						<input type="hidden" name="BT_KEYNO" id="BT_KEYNO" value="${BoardType.BT_KEYNO }">
						<input type="hidden" name="BD_BT_KEYNO" id="BD_BT_KEYNO" value="${BoardType.BT_KEYNO }">
						<input type="hidden" name="MN_KEYNO" id="MN_KEYNO" value="${Menu.MN_KEYNO }">
						<input type="hidden" name="BN_MN_KEYNO" id="BN_MN_KEYNO" value="${Menu.MN_KEYNO }">
						<input type="hidden" name="BN_KEYNO" id="BN_KEYNO" value="">
						<input type="hidden" name="bnkey" id="bnkey" value="">
						<input type="hidden" name="PageIndex" id="PageIndex" value="${paginationInfo.currentPageNo}" />
						<input type="hidden" name="BN_PWD" id="BN_PWD">
						<input type="hidden" name="orderCondition" id="orderCondition" value="${orderCondition }">
						<input type="hidden" name="Type_menu" id="Type_menu" value="${BOARD_TYPE}">
						<input type="hidden" name="selected_views" id="selected_views" value="${selected_views}">
						<input type="hidden" name="SearchKeywordss" id="SearchKeywordss" value="${SearchKeywordss }">

					<c:choose>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST}">
							<!-- 일반 리스트화면(서식자료 / 지표조사,시 발굴조사) -->
							<%@ include file="listType/prc_board_data_listView_list.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_CONTENT}">
							<!-- 일반 리스트화면 -->
							<%@ include file="listType/prc_board_data_listView_list.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_DETAIL}">
							<!-- 상세화면 X  -->
							<%@ include file="listType/prc_board_data_listView_list_noDetail.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_GALLERY }">
							<!-- 갤러리(동영상) -->
							<%@ include file="listType/prc_board_data_listView_gallery.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_CALENDAR }">
							<!-- 캘린더형 -->
							<%@ include file="listType/prc_board_data_listView_calendar.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_GALLERY_IMG }">
							<!--갤러리(이미지) -->
							<%@ include file="listType/prc_board_data_listView_gallery_IMG.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LETTER }">
							<!-- 학술보고서 -->
							<%@ include file="listType/prc_board_data_listView_list_PDF_Y.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_CULTURAL }">
							<!-- -->
							<%@ include file="listType/prc_board_data_listView_list_PDF.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_SIGN }">
							<!-- 조달계약(테이블형) -->
							<%@ include file="listType/prc_board_data_listView_table.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq 'SC_0000000414' }">
							<!-- 무형문화재 -->
							<%@ include file="listType/prc_board_data_listView_list.jsp"%>
						</c:when>
						<c:when test="${BoardType.BT_CODEKEY eq 'SC_0000000412' }">
							<!-- 연구소식 -->
							<%@ include file="listType/prc_board_data_listView_link.jsp"%>
						</c:when>
						<c:otherwise>
							<%@ include file="listType/prc_board_data_listView_list_card.jsp"%>
						</c:otherwise>
					</c:choose>
				</form:form>
			
				<div class="board_layerPop" id="board_pwd_confirm">
					<div class="board_layerPop_inner">
					<form:form id="pwdForm">
						<input type="hidden" name="BN_KEYNO" id="pwdBN_KEYNO">
						<button type="button" class="board_layerPop_close" onclick="pf_closePwd()">X</button>
						<p>비밀번호를 입력하여주세요.</p>
						<input type="password" name="BN_PWD" id="pwdBN_PWD" title="비밀번호 입력">
						<button type="button" class="btn" onclick="pf_checkPwd()">확인</button>	
					</form:form>
					</div>
				</div>
				
				<c:if test="${BoardHtml.BIH_DIV_LOCATION eq 'B' }">
					<div id="html_contents">${BoardHtml.BIH_CONTENTS }</div>
				</c:if>
			</div>
		</div>
	</div>
</article>


<script>
$(function(){
	
	//최신순, 오래된순
	var orderCondition = $('#orderCondition').val();
	if(orderCondition == 'C'){
		$('#old_ul1').addClass("active");
	}else{
		$('#new_li1').addClass("active");
	}
	//리스트
	if('${BOARD_TYPE}' == 'card'){
		$('#menu_card').attr('selected','selected')
	}else{
		$('#menu_list').attr('selected','selected')
	}
	//8개 12개
	if('${selected_views}' == 'twelve'){
		$('#twelve').attr('selected','selected')
	}else{
		$('#eight').attr('selected','selected')
	}
	
	var searchCondition ='${BoardNotice.searchCondition}'
	
	if(searchCondition){
		$('#searchCondition').val('${BoardNotice.searchCondition}');
		$('#searchKeyword').val('${BoardNotice.searchKeyword}');
		$('#orderCondition').val('${BoardNotice.orderCondition}');
	}
	
// 	if(keywordList){
// 		$('#searchKeyword').autocomplete({
// 			source: keywordList,
// 			focus: function( event, ui ) {
// 				return false; 
// 			}
// 		});
// 	}
	
})
//페이지 이동
function pf_LinkPage(num){
	$('#PageIndex').val(num);
	$('#Form').attr('action',location.pathname)
	$('#Form').submit();
}

//검색
function pf_boardSearch(){
	$('#PageIndex').val(1);
	$('#Form').attr('action',location.pathname)
	$('#Form').submit();
}

//상세보기
function pf_DetailMove(bn_keyno){
	var read = '${boardAuthList.read}';
	if(read == 'false'){
		alert('접근권한이 없습니다. 로그인을 하시거나 접근권한을 확인하세요.')
		return false;
	}
	
	$('#Form').attr('action','${tilesUrl}/Board/'+bn_keyno+'/detailView.do');
	$('#Form').submit();
}
function pf_NotMyContents(){
	alert('비밀글 입니다.')	
}

//게시글 삭제
function pf_deleteMove(bnkey){
	if(confirm("삭제 하시겠습니까?")== true){
		$('#bnkey').val(bnkey)
		$("#Form").attr("action", '${tilesUrl }/Board/delete.do');
		$("#Form").submit();
	}
}
//게시글 수정 페이지로 이동
function pf_UpdateMove(bnkey){
	
	$('#bnkey').val(bnkey)
	$("#Form").attr("action", '${tilesUrl }/Board/updateView.do');
	$("#Form").submit();
}

//글쓰기
function pf_RegistMove() {
	var write = '${boardAuthList.write}';
	if(write == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('글쓰기 권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	$("#Form").attr("action", "${tilesUrl }/BoardData/insertView.do");
	$("#Form").submit();
}

//비밀번호 창 open
function pf_openPWD(bnkey){
	$('#pwdBN_KEYNO').val(bnkey);
	$('#board_pwd_confirm').fadeIn();
	$('#pwdBN_PWD').focus();
}

//비밀번호 창 close
function pf_closePwd(){
	$('#board_pwd_confirm').fadeOut();
}

//비밀번호 확인
function pf_checkPwd(){
	if(!$('#pwdBN_PWD').val()){
		alert('비밀번호를 입력하여주세요.')
		$('#pwdBN_PWD').focus();
		return false;
	}
	
	$.ajax({
	    type   : "post",
	    url    : "${tilesUrl }/Board/checkPwdAjax.do",
	    data   : $('#pwdForm').serializeArray(),
	    success:function(data){
	    	if(data){
	    		$('#BN_PWD').val($('#pwdBN_PWD').val())
	    		$('#Form').attr('action','${tilesUrl}/Board/'+$('#pwdBN_KEYNO').val()+'/detailView.do');
	    		$('#Form').submit();
	    	}else{
	    		alert('비밀번호를 확인하여주세요.')
	    	}
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	cf_loading_out();
	    	alert('error: '+textStatus+": "+exception);
	    }
	});
}

//게시물 이동
function pf_moveBoardData(key){
	$('#Form').attr('action','${tilesUrl}/Board/'+key+'/moveView.do');
	$('#Form').submit();
}

//rss만들기
function rss_maker(){
	$('#Form').attr("target", "_blank");
	$('#Form').attr('action','/jact/RSSView.do');
	$('#Form').submit();
}


//최신순, 과거순
function pf_boardSearch(obj,value){
	$('#SearchKeywordss').val("nosearch");
	
	$('li[name=new_li]').removeClass("active");
	
	$(obj).closest('li').addClass("active");
	$('#orderCondition').val(value);
	
	$('#PageIndex').val(1);
	$('#Form').attr('action',location.pathname)
	$('#Form').submit();
}
//리스트형, 기사형
function pf_changePage(){
	$('#Type_menu').val($('#menu_show option:selected').val());
	pf_boardSearch();
}
//이미지, 동영상
function ch_views(){
	$("#selected_views").val($("#select_views option:selected").val());
	pf_boardSearch();
}
//pdf 다운
function cf_downloadPDF(filekey){
	location.href="/async/file/PDFdownload.do?FM_KEYNO=" + filekey; 
}
//e-book연결
function e_book(key){
	if(key == 'BN_0000024621'){
		window.open("/e-book1.jsp");
	}else if(key == 'BN_0000024622'){
		window.open("/e-book2.jsp");
	}else if(key == 'BN_0000024624'){
		window.open("/e-book3.jsp");
	}
}
</script>