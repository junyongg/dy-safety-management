<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script src="/resources/js/calendar/TronixCalendar.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/calendar/TronixCalendar.css">

<!-- <link href="/resources/css/calendar/TronixCalendar.css" rel="stylesheet" type="text/css" /> -->
<link href="/resources/css/calendar/TronixCalendar2.css" rel="stylesheet" type="text/css" />

<script src="/resources/smartadmin/js/plugin/moment/moment.min.js"></script>
<!-- <script src="/resources/api/fullcalendar/js/fullcalendar.js"></script> -->
<!-- <script src="/resources/api/fullcalendar/js/ko.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" media="screen" href="/resources/api/fullcalendar/css/fullcalendar.css"> -->

<link rel="stylesheet" type="text/css" href="/resources/api/FrontMArte/css/import.css">
<link rel="stylesheet" type="text/css" href="/resources/api/FrontMArte/css/mypage.css">
<link rel="stylesheet" type="text/css" href="/resources/api/FrontMArte/css/ticket.css">
<link rel="stylesheet" type="text/css" href="/resources/api/FrontMArte/css/calendar.css">
<link rel="stylesheet" type="text/css" href="/resources/api/FrontMArte/css/ticket_2.css">
<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet">
<script type="text/javascript" src="/resources/api/FrontMArte/js/json2.js"></script>
<script type="text/javascript" src="/resources/api/FrontMArte/js/comm.js"></script>
<script type="text/javascript" src="/resources/api/FrontMArte/js/security.js"></script> 
<script type="text/javascript" src="/resources/api/FrontMArte/js/fn_booking_date_seq.js"></script>

<style type="text/css">
	.box_date_pick {width:100%; padding:0 0 15px 0; text-align:center;}
	.box_date_pick ul {display:inline-block;}
	.box_date_pick ul:after { visibility: hidden;display:block;font-size: 0;content:".";clear: both;height: 0;*zoom:1;}
	.box_date_pick ul li {float:left; padding:10px; border:1px solid #ddd; border-right:none; color:#65a132; font-size:1em; cursor:pointer;}
	.box_date_pick ul li:last-of-type {border-right:1px solid #ddd;}
	.box_date_pick ul li img {vertical-align:middle;}
	.box_date_pick ul li.date_box { cursor:auto;}	
	
	.ui-datepicker-title {font-weight:bold; color : #333333;}
	.pop_viewCon {display: none;width: 400px;}
	.pop_viewCon .inbox {padding: 10px;margin: 50px;text-align: left;background: #fff;border: 5px solid #3571B5;}
	.pop_viewCon h4 {background: #6eabd7;color: #fff;font-size: 14px;font-weight: bold;padding: 8px 15px 6px 15px;}
	.pop_viewCon .etc {padding-top: 10px;margin: 30px;text-align: center;background: #fff;}
	.tab_dl dt {color: #505050;font-size: 14px;margin-top: 10px;margin-bottom: 3px;font-weight: bold;}
	.tab_dl dd {color: graytext;margin: 0;}
	body {font-size: 13px}
	.fn_right {float: right;font-size: 30px;margin-top: -13px;cursor: pointer; margin-right:-8px;}
	.pop_viewCon { display:none; width:300px; }
	.pop_viewCon .inbox {padding:10px;  margin:50px; text-align:left; background:#fff; border :5px solid #3571B5; }
	.pop_viewCon h4 {background:#6eabd7; color:#fff; font-size:14px; font-weight:bold; padding:8px 15px 6px 15px;}
	.pop_viewCon .etc{padding-top:10px;  margin:30px; text-align:center; background:#fff;}
	
	.tab_dl dt{ color: #505050; font-size: 14px; margin-top: 5px;margin-bottom: 3px;font-weight: bold;}
	.tab_dl dd{ color: graytext; margin: 0;}
	.fn_right { float : right; font-size : 30px; margin-top:-10px;cursor:pointer}
	.section{
	    border-top: 1px solid #d1d1d1;
	} 
	.contents_pop_body{
		height: 690px;
	}
	
	ul.calen_box_first .now_list {
	    width: 49%;
	    margin-left: 7px;
	}
	.info_line {
	    height: 83px;
	}
	.tronixTr {
	    height: 56px;
	    background: #fafafa;
	}
	.tronixTable {
		border: none;
	    border-top: 1px solid #d1d1d1;
	}
	#tour_contents_pop_box{
		height: 751px;
	}
	
	.hasEvent {background:#C0DCF3 !important;}
	.onSelected {background:#2183f0 !important;}
	.onSelected span {color:#ffffff;}
	
	.table3_bor_b_gray a {text-decoration: none;}
	.cou_benefit_con3 > li{
		border-bottom: none;
	}
	.info_detail {
	    color: #464646;
	    font-size: 11px;
	    line-height: 27px;
	    font-weight: 700;
	    padding-top: 10px;
	    word-break: break-all;
	}
	.sale_info > li{
		width: 88%;
	}
	.cou_benefit_con4 > li {
	    float: left;
	    height: 45px;
	    padding: 0 1%;
	    line-height: 45px;
	    border-bottom: 1px solid #2183f0;
	    color: #323232;
	    font-size: 13px;
	    font-weight: 700;
	    word-break: break-all;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    white-space: nowrap;
	    margin-bottom: 5px;
	}
	.title{
	   float: left;
	   width: 100%;
	   font-size: 21px;
	   color: #393f45;
	   font-weight: bold;
	   margin-bottom: 9px;
	   cursor: pointer;
	}
	.summary{
	    font-size: 15px;
	    color: #717171;
	    min-height: 40px;
	    width: 45%;
	    overflow-y: hidden;
	}
	.list_etc {
	    float: left;
	    color: #717171;
	    width: 100%;
	    border-bottom: 1px solid #969696;
	    text-align: left;
	    padding-bottom: 5px;
	    margin-top: 15px;
	}
	.list_etc2 {
	    float: left;
	    color: #717171;
	    width: 100%;
	    text-align: left;
	    padding-bottom: 5px;
	    margin-top: 10px;
	}
	.date{
		font-size: 15px;
		display: inline-block;
	    font-weight: bolder;
        height: inherit;
        color: #717171;
        float: left;
	}
	.place{
		text-align: right;
	}
	.price{
		color: #717171;
	    font-size: 15px;
   		font-weight: bold;
	    text-overflow: ellipsis;
	    display: block;
	    -webkit-box-orient: vertical;
	    word-wrap: break-word;
	    -webkit-line-clamp: 2;
	    line-height: 16px;
        height: inherit;
	}
	.applyBtn{
	    display: inline-block;
	    margin-left: 10px;
	    float: right;
	}
	.selC_on2 {
	    display: inline-block;
	    width: 92px;
	    height: 34px;
	    line-height: 34px;
	    font-size: 15px;
	    text-align: center;
	    background: #bf1010;
	    color: #fff !important;
	    font-weight: bold;
	    border-radius: 20px;
	}
</style>


    <ul>
    	<c:forEach items="${resultList }" var="model">
    	<li>
    		<p class="title">${model.AP_NAME }</p>
    		<p class="summary">${model.AP_SUMMARY }</p>
    		<div class="list_etc">
	    		<div class="date">${model.AP_DATE_COMMENT }</div>
	    		<div class="place">${model.PM_NAME}<img class="placeMarker" src="/resources/img/calendar/detail_spot.png" alt="place_marker" style="margin-left: 5px;"></div>
    		</div>
    		
    		<div class="list_etc2">
    			<p class="price">
    				<c:choose>
    					<c:when test="${model.AP_PRICE == '0'}">
    						무료
    					</c:when>
    					<c:otherwise>
			    			<fmt:formatNumber value="${model.AP_PRICE }" type="number"/>원
    					</c:otherwise>
    				</c:choose>
    			</p>
    		</div>
    		
    		<div class="applyBtn">
    			<fmt:parseNumber value="${fn:substring(model.AP_KEYNO,4,20)}" integerOnly="true" var="key"/>
    			<button type="button" onclick="pf_regist('${key}')" class="btn btnSmall_write btn-default">신청하기</button>
    		</div>
    	</li>
    	</c:forEach>
    </ul>
    
<form name="frmSelSeq" id="Form" method="post">
	<input type="hidden" name="APP_AP_KEYNO" id="APP_AP_KEYNO"  value="">
	<input type="hidden" name="APP_ASM_KEYNO" id="APP_ASM_KEYNO"  value="">
	<input type="hidden" name="APP_ASS_KEYNO" id="APP_ASS_KEYNO"  value="">
	<input type="hidden" name="APP_APU_KEYNO" id="APP_APU_KEYNO"  value="${userInfo.UI_KEYNO }">
	<input type="hidden" name="APP_ST_DATE" id="APP_ST_DATE"  value="">
	<input type="hidden" name="APP_ST_TIME" id="APP_ST_TIME"  value="">
	<input type="hidden" name="APP_COUNT" id="APP_COUNT"  value="">
	<input type="hidden" name="APP_SEQUENCE" id="APP_SEQUENCE"  value="">
</form>

<!-- 팝업 창 -->
<div id="tour_contents_pop_box" tabindex="0" src="">
	<div id="tour_contents_bg_box"></div>
	<div class="pop-container"> 
		<div class="pop-conts">
			<div class="contents_pop_header"> 
				<div class="contents_pop_title">티켓예매</div>
				<a href="javascript:;" class="contents_pop_cbtn">
					<img src="/resources/img/calendar/close_btn.gif" alt="닫기">
				</a>
			</div>
			<iframe class="contents_pop_body" src="/cf/function/program/iframe.do" >
				
			</iframe>   
			<div class="contents_pop_footer"></div>   
		</div>
	</div>
</div> 
<div id="pop_bg_opacity"></div>
<script>
var ScheduleCnt = 1;
var scheduleList = [];
var ProgramSchdule = new Array();
var setMonth = new Date().getMonth() + 1;
var selectedKey;
var nowStD;
var lastday;
//주간태그에 날짜태그 추가
$.fn.addDateTag = function(text){
  if(text == null){
    text = '';
  }     
  this.td = $("<td onclick=\"pf_selected('"+getDate+'-'+cf_setTwoDigit(text)+"',this) \">").addClass('tronixTd').attr('id', 'tronix' + text).html("<span>"+text+"</span>");
  
  if(this.tr != null){
    $(this.tr).append(this.td);
    this.td = null;
  }
};

$(function(){
});

//신청하기 버튼
function pf_regist(key){

	if ("${userInfo.UI_ID}" == null || "${userInfo.UI_ID}" == '') {
		if (confirm("로그인이 필요합니다. 확인 버튼을 누르시면 로그인페이지로 이동합니다.")) {
			location.href = "/cf/member/login.do";
			return;
		}
		return false;
	}
	selectedKey = key;
	$("#calendar_div").showCalendar(setMonth);
	
	//투명막씌우기
	$(".contents_pop_footer").show();
	$("#pop_bg_opacity").show();
	$("#tour_contents_pop_box").show(); 
	$("html").css("overflow-y", "hidden");
	$("body").css("overflow-y", "hidden");
	var temp = $("#tour_contents_pop_box");
	
	// 화면의 중앙에 레이어를 띄운다.  
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');
	
	$(".step1").show();
	$(".step2, .step3, .step4, .step5").hide();	
	
	// 전당투어 달력 레이어팝업 닫기 처리
	temp.find('a.contents_pop_cbtn').click(function(e){ 
		$("html").css("overflow-y", "");
		$("body").css("overflow-y", ""); 
		$("#pop_bg_opacity").fadeOut(); 
		$("#tour_contents_pop_box").hide();   
		//기존에는 페이지로드시 달력을 세팅했지만 버튼별 캘린더 세팅이 달라 캘린더를 초기화함
		$("#calendar_div").html("");  
	}); 
	$("#tour_contents_pop_box").focus();
}
</script>