<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<script src="/resources/api/linecalendar/js/linecalendar.js"></script>
<!-- <link rel="stylesheet" type="text/css" media="screen" href="/resources/api/linecalendar/css/linecalendar.css"> -->
<section id="sub-content" style="padding: 0px;">
		
		<!-- 메인 슬라이드 -->
		<div id="main-slide-box">
			<div class="btn-b prev"><button type="button"><i class="xi-angle-left-thin"></i></button></div>
			<div class="btn-b next"><button type="button"><i class="xi-angle-right-thin"></i></button></div>
			<div class="main-slide-page"></div>
			<ul class="main-slide-ul">
				<c:forEach items="${slide }" var="slide" >
					<li data-title="${slide.MM_TITLE }" data-comment="${slide.MM_COMMENT }">
						
						<c:choose>
							<c:when test="${slide.MM_URL eq ''}">
								<a href="javascript:;">
							</c:when>
							<c:otherwise>
								<a href="${slide.MM_URL}" target="_blank">
							</c:otherwise>
						</c:choose>
						<div class="img-b" style="background-image:url(${slide.FS_PATH});" title="${slide.MM_COMMENT }"></div></a>	
					</li>
				</c:forEach>
			</ul>	
		</div>

		<!-- 메인 캘린더 -->
	<!-- 	<div class="main-cal-box">
			<div class="inner1200">
				<div class="date-b">
					<p class="mt"></p>
					<p class="yr"></p>
				</div>
				<div class="btn-b">
					<button type="button" class="up"><i class="xi-angle-up-thin" id="nextMonth"></i></button>
					<div class="line"></div>
					<button type="button" class="down"><i class="xi-angle-down-thin" id="prevMonth"></i></button>
				</div>
				<div class="month-b" >
					<div id="calenderList">
					</div>

					PC팝업
					<div class="popUp-m-e pcV">
						<div class="top-b">
							<p class="day">2019.<b>05</b></p>
							<button type="button" class="btn-cl"><i class="xi-close-thin"></i></button>
						</div>
						<div class="con-b">
							<div class="row">
								
							</div>
						</div>
					</div>
				</div>
				<div class="event-b">
					<button type="button">행사<br>보기</button>
				</div>

					
				모바일팝업
				<div class="popUp-m-e-m">
					<div class="btn-s prev"><button type="button"><i class="xi-angle-left-thin"></i></button></div>
					<div class="btn-s next"><button type="button"><i class="xi-angle-right-thin"></i></button></div>
					<div class="con-b2">
						<div class="col">
							<a href="javascript:;">
								<div class="letter-b">
									<h2>박미성 귀국 피아노 독주회</h2>
									<h3>2019.05.16-05.30</h3>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div> -->

		<!-- 메인 아이콘 -->
		<div class="main-icon-u-b">
			<div class="inner1200">
				<div class="one">
					<a href="/jact/archives/material.do" title="서식자료게시판으로 이동합니다.">
						<span class="icon icon01"></span>
						<h3>서식자료</h3>
					</a>
				</div>
				<div class="one">
					<a href="/jact/open/consulting/question.do" title="1:1문의게시판으로 이동합니다." >
						<span class="icon icon02"></span>
						<h3>1:1문의</h3>
					</a>
				</div>
				<div class="one">
					<a href="/jact/open/consulting/free.do" title="자유게시판으로 이동합니다.">
						<span class="icon icon03"></span>
						<h3>자유게시판</h3>
					</a>
				</div>
				<div class="one">
					<a href="/jact/archives/reference.do"   title="카도뉴스로 이동합니다.">
						<span class="icon icon04"></span>
						<h3>카드뉴스</h3>
					</a>
				</div>
				<div class="one">
					<a href="/jact/data/data2.do"  title="정보공개청구게시판으로 이동합니다..">
						<span class="icon icon05"></span>
						<h3>정보공개청구</h3>
					</a>
				</div>
			</div>
		</div>
		
		<!-- 메인 내용 컨텐츠 -->
		<div class="main-content-box">
			<div class="inner1200">

				<div class="row one">					
					<!-- news -->
					<div class="col-m col-3 board">
						<div class="title">
							<span class="s-t">NEWS</span>
							<ul class="in-tab main-board-tab">
								<li class="active"><a href="javascript:;" onclick="setPath('notice')">공지</a></li>
								<li><a href="javascript:;" onclick="setPath('collusion')">공모</a></li>
								<li><a href="javascript:;" onclick="setPath('hire')">채용</a></li>
								<li><a href="javascript:;" onclick="setPath('biddannouncement')">입찰</a></li>
							</ul>
							<button type="button" class="btn-more" onclick="nextBoard()" title="자세히 보기"><i class="xi-plus-thin"></i></button>
						</div>
						
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=8"/> <!-- 공지  -->
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=15"/><!-- 공모 -->
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=9"/> <!-- 채용 -->
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=10"/><!-- 입찰  -->
					</div>

					<!-- 보도자료 -->
					<div class="col-m col-3 board">
						<div class="title">
							<span class="s-t">보도자료</span>
							<button title="자세히 보기" type="button" class="btn-more" onclick="location.href='/jact/open/press/press.do' "><i class="xi-plus-thin"></i></button>
						</div>
						<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=11"/>
					</div>

					<!-- 비디오 -->
					<div class="col-m col-3 prMovie">
						<a href="/culture/index.do" target="_blank" title="문화재연구소로 이동하기">
							<div class="img-b" style="background-image:url('/resources/img/main/main_video_bg_01.jpg');"></div>
							<div class="txt-box">
								<h2>문화재연구소</h2>
								<h5>남도문화유산의 요람</h5>
								<button type="button" class="btn-more" onclick="window.open('/culture/index.do')" title="문화재연구소로 이동하기">MORE</button>
							</div>
						</a>
					</div>
				</div>



				<div class="row two">
					<!-- 남도소리울림터 -->
					<div class="col-m col-3 detail-b">
						<div class="img-box" style="background-image:url('/resources/img/main/img_main_middle_01.jpg');">
							<a href="http://jnnamdosori.cafe24.com/" target="_blank" title="남도소리울림터페이지로 이동"><span><img src="/resources/img/icon/icon_in_window.png" align="icon"></span></a>
						</div>
						<div class="txt-box">
							<h2>남도소리울림터</h2>
							<h5>남도소리울림터를 만나 보실 수 <br>있습니다.</h5>
							<button type="button" class="btn-detail" onclick="window.open('http://jnnamdosori.cafe24.com/')" title="남도소리울림터페이지로 이동">자세히 보기</button>
						</div>
					</div>

					<!-- 전남도립국악단 -->
					<div class="col-m col-3 detail-b">
						<div class="img-box" style="background-image:url('/resources/img/main/img_main_middle_02.jpg');">
							<a href="http://jpg.or.kr/" target="_blank" title="전남도립국악단페이지로 이동"><span><img src="/resources/img/icon/icon_in_window.png" align="icon"></span></a>
						</div>
						<div class="txt-box">
							<h2>전남도립국악단</h2>
							<h5>전남도립국악단을 만나 보실 수 <br>있습니다.</h5>
							<button type="button" class="btn-detail" title="전남도립국악단페이지로 이동" onclick="window.open('http://jpg.or.kr/')">자세히 보기</button>
						</div>
					</div>

					<!-- 남도사이버갤러리 -->
					<div class="col-m col-3 detail-b">
						<div class="img-box" style="background-image:url('/resources/img/main/img_main_middle_03.jpg');">
							<a href="https://namdogallery.or.kr/main/" target="_blank" title="남도사이버갤러리페이지로 이동"><span><img src="/resources/img/icon/icon_in_window.png" align="icon"></span></a>
						</div>
						<div class="txt-box">
							<h2>남도사이버갤러리</h2>
							<h5>남도 사이버 갤러리를 만나 보실 수 <br>있습니다.</h5>
							<button type="button" class="btn-detail" onclick="window.open('https://namdogallery.or.kr/main/')" title="남도사이버갤러리페이지로 이동">자세히 보기</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		

		<!-- 관광포커스 SNS부분 -->
		<div class="main-sns-focus-box">
						<div class="focus-b">
				<a href="/jact/archives/letter.do">
					<div class="logo-b"><img src="/resources/img/icon/img_logo_focus_1.png" alt="전남 관광 포커스21"></div>
					<div class="btn-b">
						<p>발행물/발간물 서비스</p>
						<div class="arrow"><img src="/resources/img/icon/icon_focus_arrow_1.png"></div>
					</div>
				</a>
			</div>
		</div>
	</section>
<!-- 메인 밑에 배너 -->
	<div id="main-link-banner-w">
		<div class="inner1200">
			<div class="btn prev"><a href="javascript:;"><i class="xi-angle-left-thin"></i></a></div>
			<div class="link-banner-box">
				<ul class="m-b-link-banner">
				<c:forEach var="i" begin="0" end="2">
					<c:forEach items="${banner }" var="banners" >
						<li><a href="${banners.BM_URL }" target="_blank" title="${banners.BM_TITLE }로  이동"><img src="${banners.FS_PATH }"></a></li>
					</c:forEach>
				</c:forEach>
				</ul>
			</div>
			<div class="btn next"><a href="javascript:;"><i class="xi-angle-right-thin"></i></a></div>
		</div>
	</div>



<script>
$(function(){
	var msg = '${msg}';
	if(msg){
		alert(msg);
	}
});

var nextpath = '/jact/open/notice.do'; //공지사항
//     /jact/open/hire.do //채용
//    /jact/open/biddannouncement.do //입찰

function setPath(key){
	switch (key) {
	case "notice":
		nextpath = '/jact/open/notice.do';
		break;
		
	case "hire":
		nextpath = '/jact/open/hire.do';
		break;
			
	case "biddannouncement":
		nextpath = '/jact/open/biddannouncement.do';
		break;
	
	case "collusion":
		nextpath = '/jact/open/collusion.do';
		break;
		
	default:
		break;
	}
}

function nextBoard(){
	location.href=nextpath;
}

$(function(){
	setDateTitle('default');
	
	setDateTitle('default');
    $('#prevYear').click(function(){
    	y -= 1;
    	setDateTitle();
    })
    $('#prevMonth').click(function(){
    	if(m == 0){
    		m = 11;
    		y -= 1;
    	}else{
	    	m -= 1;
    	}
    	setDateTitle();
    })
    $('#nextYear').click(function(){
    	y += 1;
    	setDateTitle();
    })
    $('#nextMonth').click(function(){
    	if(m == 11){
    		m = 0;
    		y += 1;
    	}else{
	    	m += 1;
    	}
    	setDateTitle();
    }) 
});



var options;
var tagVal;
var date = new Date();
var d = date.getDate();
var m = date.getMonth();
var y = date.getFullYear();
var bxListSlider;
var vWebType = "";

var currentSelectedDate;
function setDateTitle(type){
// 	popUpClose()
	
	var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];
	var mString = (m+1)+ '';
	tagVal = y + '.<b>'+( mString.length == 1 ? '0'+mString:mString )+'</b>';
	$('.yr').html(tagVal)
	$('mt').html(monthNames[m])
	
	var getTemp = getCalender(y,( mString.length == 1 ? '0'+mString:mString ))
	$("#calenderList").html(getTemp)
	
	var start = y+"-"+ ( mString.length == 1 ? '0'+mString:mString )+"-01";
	var end = y+"-"+ ( mString.length == 1 ? '0'+mString:mString )+"-"+lastDay(y, ( mString.length == 1 ? '0'+mString:mString ));
	options = "&start="+getDateTime(start)+"&end="+getDateTime(end);
	
// 	getEventResultList(getEvents(options))
	
}

function getDetailList(obj){
	
// 	currentSelectedDate = obj;
	
// 	$.ajax({
// 		type: "POST",
// 		url: "/home/Board/main/DetaiList/viewAjax.do",
// 		data: "keyList="+$(obj).attr('class'),
// 		async:false,
// 		success : function(result){
// 			var temp = '';
// 			var mobiletemp = '';
// 			if(result != null && result.length > 0){
// 				$.each(result, function(i){
// 					var title = result[i].BN_TITLE;
// 					var schedule = result[i].SCHEDULE;
// 					var thumbnail = result[i].THUMBNAIL_PATH;
// 					var key = cf_setKeyno(result[i].BN_KEYNO);
//                     temp += '    <div class="one">';
//                     temp += '        <div class="img-b">';
//                     temp += '            <img src="'+thumbnail+'" alt="포스터">';
//                     temp += '        </div>';
//                     temp += '        <div class="letter-b">';
//                     temp += '            <h2>'+title+'</h2>';
//                     temp += '            <p class="d">'+schedule+'</p>';
//                     temp += '            <button type="button" class="detail" onclick="pf_DetailMove('+key+')">상세보기</button>';
//                     temp += '        </div>';
//                     temp += '    </div>';
                    
//                     mobiletemp += '<li class="row mobileLi">';
//                     mobiletemp += '	<div class="one">';
// 	                mobiletemp += '    <a href="javascript:;" onclick="pf_DetailMove('+key+')">';
// 	                mobiletemp += '        <div class="img"><img class="s-img" src=\''+thumbnail+'\'"/></div>';
// 	                mobiletemp += '        <div class="letter">';
// 	                mobiletemp += '            <h2>'+title+'</h2>';
// 	                mobiletemp += '            <h3>'+schedule+'</h3>';
// 	                mobiletemp += '        </div>';
// 	                mobiletemp += '    </a>';
// 	                mobiletemp += ' </div>';
//                     mobiletemp += '</li>';
                    
// 				});
// 				$('.bxSlider_po1').css('height','200px')
// 				$('.s-b').show();
// 			}else{
// 				   temp += '<div class="one">';
//                    temp += '    <div class="letter-b">';
//                    temp += '        <h2>등록된 공연이 없습니다.</h2>';
//                    temp += '    </div>';
//                    temp += '</div>';
                 
//                    mobiletemp += '<li class="row noData">';
//                    mobiletemp += '	<div class="one">';
// 	               mobiletemp += '    	<a href="javascript:;">';
// 	               mobiletemp += '        	<div class="letter">';
// 	               mobiletemp += '           	 <h2>등록된 공연이 없습니다.</h2>';
// 	               mobiletemp += '      	</div>';
// 	               mobiletemp += '    	</a>';
// 	               mobiletemp += '	</div>';
// 	               mobiletemp += '</li>';
// 	               $('.bxSlider_po1').css('height','auto')
// 	               $('.s-b').hide();
// 			}
			
// 			$("#DetailInfoMobile").html(mobiletemp)
// 			$("#calenderDetailInfo").html(temp)
// 			$('.month-b .day-ul li').removeClass('active');
// 			$(obj).addClass('active');
// 			$('.top-box .l-b p').html(tagVal);
// 			pf_settingMainCaledar();
// 		},
// 		error: function(){
// 			alert('알수없는 에러 발생. 관리자한테 문의하세요.')
// 			return false;
// 		}
// 	});
}

</script>