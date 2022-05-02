<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<style type="text/css">
/* 팝업 레이아웃 */
.popUpWrap_01 {position:fixed; top:calc(50% - 185px); left:calc(50% - 150px); background-color:#fff; z-index:30000; width:300px; border:1px solid #bbb;}
.popUpWrap_01 .btnCloseBox {position:absolute; bottom:-1px; right:-30px; width:30px; height:30px; background-color:#444444; text-align:center; cursor:pointer; padding-top:3px;}
.popUpWrap_01 .btnCloseBox button {vertical-align: middle}
.popUpWrap_01 .contentsBox {padding:20px; height:300px; overflow-y:auto; overflow-x:hidden;}
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

<c:forEach var="list" items="${popupList_W}">
	<fmt:parseNumber value="${fn:substring(list.PI_KEYNO,5,20)}" var="numberType" />
	<div class="popUpWrap_01"  id="pop${numberType}"   data-top="${list.PI_TOP_LOC}" data-left="${list.PI_LEFT_LOC}"  style="width:${list.PI_WIDTH}px;height:${list.PI_HEIGHT + 28}px">
        <div class="contentsBox"  style="width:${list.PI_WIDTH}px;height:${list.PI_HEIGHT}px; padding:0px;" >
        	<!-- 팝업창 메인 이미지 -->   
		     <c:if test="${empty list.FS_KEYNO}">
			     <a href="${list.PI_LINK }" target="_blank" title="<c:out value='${list.PI_TITLE }' escapeXml='true'/>">
				      <c:out value="${list.PI_CONTENTS}" escapeXml="false"/>
			    </a>
		     </c:if>
		     
		     <c:if test="${not empty list.FS_KEYNO}">
			<div style="width: 100%;height: 100%;">
			<c:if test="${empty list.PI_LINK}">
				<img style="max-width:100%;" src="/resources/img/upload/${list.FS_FOLDER}${list.FS_CHANGENM}.${list.FS_EXT}" class="img_css" alt="${list.PI_TITLE }">
			</c:if>
			<c:if test="${not empty list.PI_LINK}">
			     <a href="${list.PI_LINK }" target="_blank" title="<c:out value='${list.PI_TITLE }' escapeXml='true'/>">
				<img style="max-width:100%;" src="/resources/img/upload/${list.FS_FOLDER}${list.FS_CHANGENM}.${list.FS_EXT}" class="img_css" alt="${list.PI_TITLE }">
			    </a>
			</c:if>			     
			</div>
		     </c:if>
        </div>
        <div class="bottomBox">
        	<div class="logoBox">
            	<img src="/resources/img/icon/popup_jact.png" alt="전남문화재단">
            </div>
            <div class="checkBox">
            	<label>오늘 하루동안 보지 않기 <input type="checkbox" name="chkbox${numberType}" value="checkbox"></label>
            	<button id="mobileClose" type="button" onclick="pf_closePop_W('${numberType}');" style="margin-right:5px;">close</button>
            </div>
        </div>  
         <div class="btnCloseBox">
        	<button type="button" onclick="pf_closePop_W('${numberType}');"><img src="/resources/img/icon/icon_close_popUp_01.png" alt="닫기"></button>
        </div> 
    </div>
	

</c:forEach>


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

</script>

