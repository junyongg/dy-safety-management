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
	
	.contents_pop_body{
		height: 460px;
	}
	
	ul.calen_box_first .now_list {
	    width: 49%;
	    margin-left: 7px;
	}
	.info_line {
	    padding: 20px 0 0 0;
	    height: 83px;
	}
</style>

    <ul>
    	<c:forEach items="${resultList }" var="model">
    	<li style="margin-bottom:10px;border-bottom:3px solid #eee;padding-bottom:10px;">
    		<p class="title">제목 : ${model.AP_NAME }</p>
    		<p class="date">일시 : ${model.AP_DATE_COMMENT }</p>
    		<p class="price">가격 : ${model.AP_PRICE }</p>
    		<div>
    			<fmt:parseNumber value="${fn:substring(model.AP_KEYNO,4,20)}" integerOnly="true" var="key"/>
    			<button type="button" onclick="pf_regist('${key}')" class="btn btnSmall_write btn-default">신청하기</button>
    		</div>
    	</li>
    	</c:forEach>
    </ul>

<!-- 팝업 창 -->
<div id="tour_contents_pop_box" tabindex="0">
	<div id="tour_contents_bg_box"></div>
	<div class="pop-container"> 
		<div class="pop-conts">
		<div class="contents_pop_header"> 
			<div class="contents_pop_title">티켓예매</div>
			<a href="javascript:;" class="contents_pop_cbtn">
				<img src="/resources/img/calendar/close_btn.gif" alt="닫기">
			</a>
		</div>
		<div class="contents_pop_body">
			
			<div id="page-890">
				<div id="con-890" style="width:95% !important;">
					<div class="page-tit-area bor_0">
						<div class="tickets_title_box">
							<span class="ticket-title" tabindex="0" id="focusId">
								[ 2018 ACC브런치콘서트 3회&lt;클론 강원래의 이야기 노래선물&gt; ] 
							</span>
						</div>
		
						<div class="img_ticket_step_box img_tbox info_line">
							<ul class="t_m_menu">
								<li class="t_m_menu_li">
									<ul class="t_m_menu_info">
										<li class="now-pagee">
											<a>날짜와 회차선택</a>
										</li>
									</ul>
								</li>
								<li class="t_m_menu_li bb1">
									<ul class="t_m_menu_info">
										<li><a>좌석선택</a></li>
									</ul>
								</li>
								<li class="t_m_menu_li">
									<ul class="t_m_menu_info">
										<li><a>할인적용</a></li>
									</ul>
								</li>
								<li class="t_m_menu_li">
									<ul class="t_m_menu_info">
										<li><a>티켓 수령 선택</a></li>
		
									</ul>
								</li>
								<li class="t_m_menu_li">
									<ul class="t_m_menu_info">
										<li><a>결제선택</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
		
		
					<div class="section">
						<!-- 날짜 및 회차선택 -->
		                <div class="page-section pd375" style="border-top: 1px solid #e3e3e3;">
		                	<div style="clear:both;">
					 			
								<ul class="calen_box_first">
										<!-- 캘린더 -->
									<li class="now_list">
										<h2 class="dis-h5"><span class="line-h5"></span>날짜 선택</h2>
										<div id="calendar_div"></div> 
									</li>
									<!-- 회차(시간) 선택 -->
									<li class="now_list">
										<h2 class="dis-h5"><span class="line-h5"></span>회차(시간) 선택</h2>
										<div class="now_listed_inner">
											<table class="calendar_table3">
												<caption class="skip">회차(시간) 선택</caption>
												<colgroup>
													<col width="40%">
													<col width="30%">
													<col width="30%">
												</colgroup>
												
												<thead>
													<tr>
														<th scope="col">회차</th>
														<th scope="col" colspan="2" style="text-align:left;">등급/ 예매가능 매수</th>
													</tr>
												</thead>
												
												<tbody id="ListBox"><!-- 추가될 날짜 및 회차 목록 -->
												<tr>
													<td class="table3_bor_b_gray font_s_19">
															1회차(11:00)
													</td>
													<td class="table3_bor_b_gray edit_txt_align" style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
																사이드석 
																 / 7
																	매
																<br>
																일반석 
																 / 33
																	매
																<br>
													</td>
													<td class="table3_bor_b_gray">
														<a href="#" class="selC_on" onclick="seqSelect('20180425', '000001', '1100', '1회차', '001', '7');" alt="선택">
															선택
														</a>
													</td>
												</tr>
								
												<script type="text/javascript">
													//선택버튼 구현
													$(".selC_on").click(function(){
														
														$('.selC_on').removeClass('selC_off');
														
														$(this).each(function(index,element){
															$(this).toggleClass('selC_off');
														});
													});
												</script>
												</tbody>
											</table>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<!-- //날짜 및 회차선택 -->
						<div class="appl_btn" style="padding-bottom: 20px;">
							<a href="#" class="btnpoint apply_btn" onclick="next();">다음</a>
						</div>
					</div>
				</div>
			</div>
			
	</div>   
	<div class="contents_pop_footer"></div>   
	</div>
</div>
</div> 
<div id="pop_bg_opacity"></div>
<script>
$(function(){
    $('#prevMonth').click(function(){
    	if(m == 0){
    		m = 11;
    		y -= 1;
    	}else{
	    	m -= 1;
    	}
    	setDateTitle();
    })
    $('#nextMonth').click(function(){
    	
//	    	var newDate = new Date(y+"-"+m+"-"+d)
	    	
//	    	pf_checkDate();
    	if(m == 11){
    		m = 0;
    		y += 1;
    	}else{
	    	m += 1;
    	}
    	setDateTitle();
    })
});

//시간세팅
var date = new Date();
var d = date.getDate();
var m = date.getMonth();
var y = date.getFullYear();

//신청하기
function pf_regist(){
	d = date.getDate();
	m = date.getMonth();
	y = date.getFullYear();
	
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
	//캘린더 나타내기
	setDateTitle('default');
	$('#calendar').fullCalendar('destroy');
	$('#calendar').fullCalendar({
			
	        header: {
				left: '',			        	
	        	center: '',
		        right: ''
		    },
		    height: "auto",
		    lang:"ko",
	        events: function(start, end, timezone, callback){
	        	var key = $("#programKey").val();
	        	var options = "&start="+start.unix()+"&end="+end.unix()+"&GM_KEYNO="+key;
	        	//데이터 표시하기
             	 callback(getEvents(options));
	        	
	        } ,
	        eventRender: function(event, element) {
	            if(event.className[0] == 'holiday'){
	            	$day = $('.fc-day-top[data-date='+event.start._i+']');
	            	$day.addClass('fc-holiday');
	            	$day.find('.fc-day-number').after('<span class="fc-day-title">'+event.title+'</span>')
	            	return false;
	            }
	            
	        },
	        eventClick: function(calEvent, jsEvent, view) {
	        	pf_DetailMove()
	        },
	        eventMouseover: function(event, jsEvent, view){
	        	$(jsEvent.currentTarget).find('.fc-content').css("background", "#66666c");
	        	$(jsEvent.currentTarget).find('.fc-content').css("color", "#ffffff");
	        	
	        },
	      	eventMouseout: function(event, jsEvent, view){
	      		$(jsEvent.currentTarget).find('.fc-content').css("background", "#ffffff");
	      		$(jsEvent.currentTarget).find('.fc-content').css("color", "#66666c");
	      	}
	    });
	  
	    $("#tour_contents_pop_box").draggable(); 
}

function setDateTitle(type){
	
	if(type == undefined){
		$('#calendar').fullCalendar('gotoDate',new Date(y,m));
	}
	var mString = (m+1)+ '';
	$('.date_box').text(y+"."+ ( mString.length == 1 ? '0'+mString:mString ) );
}

function getEvents(options){
	var events = [];
	
	$.ajax({
		type: "POST",
		url: "/cf/function/groupViewAjax.do",
		data: options,
		async:false,
		success : function(result){
			//현재날짜
			var now = new Date();
			var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			today = today.getFullYear()+"-"+cf_setTwoDigit(today.getMonth()+1)+"-"+cf_setTwoDigit(today.getDate());
			var eventList = result.eventList;
			$.each(eventList,function(j){
				var en_time = eventList[j].GSS_EN_TIME;
				var st_date = eventList[j].st_date;
				var mainKey = eventList[j].MAIN_KEYNO;
				var subKey = eventList[j].SUB_KEYNO;
				var title = eventList[j].GSS_SUBTITLE;
				var cnt = eventList[j].GSS_MAXIMUM;
				var temp =  "· "+ eventList[j].GSS_ST_TIME;
				var className = cf_setKeyno(mainKey) +" "+ cf_setKeyno(subKey);
				if(en_time){
// 					temp += ' ~ ' + en_time; 
				}
				if(st_date > today){	//날짜가 지났으면 신청버튼 안보이게
					if(cnt <= 10){
						className = 'deadline';
						temp += '신청마감'
					}else{
						temp += " " + title +" ("+ cnt +')';					
					}
					events.push({
	                    title: temp,
	                    start: eventList[j].st_date,
	                    allDay:false,
	                    className:className,
	                    backgroundColor: 'white' 
	                });
				}
			})
		},
		error: function(){
			alert('알수없는 에러 발생. 관리자한테 문의하세요.')
			return false;
		}
	});
	return events;
}

</script>