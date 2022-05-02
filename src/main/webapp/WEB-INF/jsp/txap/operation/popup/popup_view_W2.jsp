<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<meta http-equiv="X-Frame-Options" content="SAMEORIGIN" />
<style type="text/css">
/* 팝업 레이아웃 */
.popUpWrap_01 {position:fixed; top:calc(50% - 185px); left:calc(50% - 150px); background-color:#fff; z-index:30000; width:300px; border:1px solid #bbb;}
.popUpWrap_01 .btnCloseBox {position:absolute; bottom:-1px; right:-30px; width:30px; height:30px; background-color:#444444; text-align:center; cursor:pointer; padding-top:3px;}
.popUpWrap_01 .btnCloseBox button {vertical-align: middle}
.popUpWrap_01 .contentsBox {padding:20px; height:300px;}
.popUpWrap_01 .contentsBox p {font-size:14px; line-height:1.4;}
.popUpWrap_01 .contentsBox > a {text-decoration: none;}
.popUpWrap_01 .bottomBox {padding:5px 15px 5px 20px; display:table; width:100%;position:absolute;bottom:0}
.popUpWrap_01 .bottomBox:after { visibility: hidden; display:block;font-size: 0;content:".";clear: both;height: 0;*zoom:1;}
.popUpWrap_01 .bottomBox .logoBox {display:table-cell; width:50%;}
.popUpWrap_01 .bottomBox .checkBox {display:table-cell; width:50%; vertical-align:middle; text-align:right;}
.popUpWrap_01 .bottomBox .checkBox label {font-size:11px; font-weight:500;}

.btnCloseBox button {font-size:0}
#mobileClose {display:none;}
@media all and (max-width:850px){	
	.popUpWrap_01 {width:100% !important;top:0 !important;left:0 !important;outline: 2000px solid rgba(0,0,0,0.5);}
	.popUpWrap_01 .btnCloseBox {display:none;}
	#mobileClose {display:inline-block;}
	.popUpWrap_01 .bottomBox {border:1px solid #eee}
	.popUpWrap_01 .bottomBox .logoBox {display:none;}
	.popUpWrap_01 .bottomBox .checkBox {width:100%;}
	.img_css {width:100%;}
}


 
</style>

	<div class="popUpWrap_01"  id="pop0"   data-top="100" data-left="400"  style="width:700px;height:800px">
    	<div class="btnCloseBox">
        	<button type="button" onclick="pf_closePop_W(0);"><img src="/resources/img/icon/icon_close_popUp_01.png" alt="closeBox"></button>
        </div>
        <div class="contentsBox"  style="height:800px">
        	<!-- 팝업창 메인 이미지 -->   
				      <iframe src="${domain }/common/popup.do" style="width:101%; height: 99%;">이벤트</iframe>
        </div>
        <div class="bottomBox">
        	<div class="logoBox">
            	<img src="/resources/img/icon/popup_jact.png" alt="logo">
            </div>
            <div class="checkBox">
            	<label>오늘 하루동안 보지 않기 <input type="checkbox" name="chkbox0" value="checkbox"></label>
            	<button id="mobileClose" type="button" onclick="pf_closePop_W(0);" style="margin-right:5px;">close</button>
            </div>
        </div>   
    </div>
	

<script>


var popupCookie = new Array();
var cookieKeys = '${CookieKeys}'

$(document).ready(function() {
	
	popupCookie.push(cookieKeys)
	
	 $('.popUpWrap_01').draggable().each(function(){
		 $(this).css({
			 top:$(this).data('top'),
			 left:$(this).data('left')
		 })
	 });
	 
});

//팝업창 닫을 때 체크박스 여부에 따른 처리
function pf_closePop_W(key) { 
	if($('input[name=chkbox'+key+']').is(':checked')){
		popupCookie.push(key)
		cf_setCookieAt00( "popup_w", popupCookie , 1 ); 
	}
	$('#pop'+key).hide();

} 


//팝업창 닫을 때 체크박스 여부에 따른 처리
function pf_closePop(key) { 
	if($('input[name=chkbox'+key+']').is(':checked')){
		popupCookie.push(key)
		cf_setCookieAt00( "popup", popupCookie , 1 ); 
	}
	$('#pop'+key).hide();
} 

</script>

