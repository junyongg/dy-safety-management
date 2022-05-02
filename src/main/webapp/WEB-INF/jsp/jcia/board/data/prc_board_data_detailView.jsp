<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<%@ include file="/WEB-INF/jsp/jcia/board/language/prc_board_language.jsp"%>

<style>
.btnBig_01 {
    padding: 10px 40px;
    font-size: 18px;
    color: #fff;
    background-color: #58595b;
    min-width: 150px;
}
.bgColorR {
    background-color: #e02b31 !important;
    color: #fff !important;
}
.detailViewBtnBox .rightBtnBox {
    position: absolute;
    right: 10px;
    top: 30px;
}
.btn {
    /* -webkit-transition: all 0.1s ease-in-out; */
    -moz-transition: all 0.1s ease-in-out;
    -o-transition: all 0.1s ease-in-out;
    /* transition: all 0.1s ease-in-out; */
    padding: 5px 10px; 
    cursor: pointer;
    display: inline-block;
}
.Pcontent {padding-top:20px;}
.Pcontent span a{color: blue;}
</style>
<!-- 카카오톡 -->
<script src="/resources/js/sns/kakao.min.js"></script>
<!-- 구글플러스 -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<link type="text/css" rel="stylesheet" href="/resources/jcia/css/board.css">

<jsp:useBean id="toDay" class="java.util.Date" scope="page"/>
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="nowDate" />

<script type="text/javascript">


$(function(){
	cf_movePosition('${currentPosition}');
	
})

// 뒤로가기
function pf_back(){
	location.href="${mirrorPage }";
}



// 답글 쓰기
function pf_replyWrite(){
	var reply = '${boardAuthList.reply}';
	if(reply == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('답글쓰기 권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	$("#Form").attr("action", "${tilesUrl }/BoardData/insertView.do");
	$("#Form").submit();
	
}
var menuPage = '${currentMenu.MN_KEYNO}';
var inquire = '${BOARD_INQUIRE}';
var write = '${boardAuthList.write}';

//게시글 수정 페이지로 이동
function pf_UpdateView(bnkey){
	if(write == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	actionUrl = '${tilesUrl}/Board/updateView.do';
	var pwd = '${BoardNotice.BN_PWD}';
	$("#Form").attr("action", actionUrl);
	if(menuPage == inquire){
		if(pwd){
			pf_openPWD(bnkey);
			return false;
		}
	}
	
	$("#Form").submit();
}

// 게시글 삭제
function pf_deleteMove(bnkey){
	if(write == 'false'){
		if(!cf_checkLogin()){
			return false;
		}
		alert('권한이 없습니다. 관리자한테 문의하세요.');
		return false;
	}
	if(confirm("삭제 하시겠습니까?")== true){
		actionUrl = '${tilesUrl }/Board/delete.do';
		var pwd = '${BoardNotice.BN_PWD}';
		$("#Form").attr("action", actionUrl);
		if(menuPage == inquire){
			if(pwd){
				pf_openPWD(bnkey);
				return false;
			}
		}

		$("#Form").submit();
	}
}

var actionUrl = '';

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

//게시물 이동
function pf_moveBoardData(key){
	$('#Form').attr('action','${tilesUrl}/Board/'+key+'/moveView.do');
	$('#Form').submit();
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
	    url    : "${tilesUrl}/Board/checkPwdAjax.do",
	    data   : $('#pwdForm').serializeArray(),
	    async  : false,
	    success:function(data){
	    	if(data){
	    		$('#Form').submit();		
	    	}else{
	    		alert('비밀번호를 확인하여주세요.')
	    		$('#pwdBN_PWD').focus();
	    		return false;
	    	}
	    },
	    error: function(jqXHR, textStatus, exception) {
	    	cf_loading_out();
	    	alert('error: '+textStatus+": "+exception);
	    }
	});
}


function pf_resizeFont(name,act){
	$('.'+name+" *").not('.no_resize_font, br, button, .subTabUl, .subTabUl > li' ).each(function(){
		if(!$(this).data("fs-initial")){
			$(this).data("fs-initial",$(this).css("font-size"));	
		}
		$(this).data("fs",$(this).css("font-size"));	
		set_font_size($(this),act)
	});
}

function set_font_size($el, act)
{
    var x = 0;
    var fs = $el.data("fs");
    var unit = fs.replace(/[0-9\.]/g, "");
    var fsize = parseFloat(fs.replace(/[^0-9\.]/g, ""));
    var nfsize;

    if(!fsize)
        return true;

    if(unit == "em")
        x = 1;

    if(act == "increase") {
        nfsize = (fsize * 1.2);
    }else if(act == "decrease"){
        nfsize = (fsize / 1.2);
    }else if(act == "initial"){
    	var fs2 = $el.data("fs-initial");
    	var fsize2 = parseFloat(fs2.replace(/[^0-9\.]/g, ""));
    	nfsize  = fsize2;
    }else{
    	return false;
    }

    nfsize = nfsize.toFixed(x);

    $el.css("font-size", nfsize+unit);
    $el.data("fs", nfsize+unit);
}

</script>
<article id="container" class="container_sub clearfix">
	<div class="inner">
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
				<form:form id="Form" name="Form" method="post">
					<input type="hidden" name="BN_KEYNO" id="BN_KEYNO" value="${BoardNotice.BN_KEYNO }">
					<input type="hidden" name="MN_KEYNO" id="MN_KEYNO" value="${BoardNotice.BN_MN_KEYNO }">
					<input type="hidden" name="BN_MN_KEYNO" id="BN_MN_KEYNO" value="${BoardNotice.BN_MN_KEYNO }">
					<input type="hidden" name="BC_REGNM" id="BC_REGNM" value="${userInfo.UI_ID}">
					<input type="hidden" name="BT_KEYNO" id="BT_KEYNO" value="${BoardType.BT_KEYNO }">
					<input type="hidden" id="snsdesc" value="<c:out value="${SNSInfo.DESC}" escapeXml="true" ></c:out>" />
				</form:form>
				
				<div class="boardDetailViewBox">
					<c:choose>
						<c:when test="${BoardType.BT_CODEKEY eq BOARD_TYPE_LIST_NO_CONTENT }">
							<!-- 필요할경우 타입 분기처리 -->
							<c:if test="${MenuType.MN_KEYNO ne COSTOMER_PRIVATE}">
							<%@ include file="detailView/prc_board_data_detailView_no_content.jsp"%>
							</c:if>
							<c:if test="${MenuType.MN_KEYNO eq COSTOMER_PRIVATE}">
							<%@ include file="detailView/prc_board_data_detailView_private_contract.jsp"%>
							</c:if>
						</c:when>
						<c:otherwise>
							<%@ include file="detailView/prc_board_data_detailView_normal.jsp"%>
						</c:otherwise>
					</c:choose>
					
					
				    <c:if test="${BoardType.BT_COMMENT_YN == 'Y' }">
					<%@ include file="detailView/prc_board_data_detailView_reply.jsp"%>
					</c:if>
				</div>

				<div class="board_layerPop" id="board_pwd_confirm">
					<div class="board_layerPop_inner">
					<form:form id="pwdForm">
						<input type="hidden" name="BN_KEYNO" id="pwdBN_KEYNO">
						<button type="button" class="board_layerPop_close" onclick="pf_closePwd()">X</button>
						<p>비밀번호를 입력해주세요.</p>
						<input type="password" name="BN_PWD" id="pwdBN_PWD" title="비밀번호 입력"  class="txtDefault" style="margin: 10px 0;" onkeydown="if(event.keyCode==13){pf_checkPwd();}">
						<button type="button" class="btn txtDefault" onclick="pf_checkPwd()">확인</button>	
					</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</article>