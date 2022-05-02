<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<script src="/resources/api/linecalendar/js/linecalendar.js"></script>
<!-- <link rel="stylesheet" type="text/css" media="screen" href="/resources/api/linecalendar/css/linecalendar.css"> -->
<section id="sub-content" style="padding: 0px;">

	<div class="main_content_top">
		<div class="inner1270"> <!-- inner -->

		<!-- 메인 슬라이드 -->
		<div class="main_slide_top_box">
			<div id="main-slide-box">
				<div class="btn-b prev"><button type="button" title="이전 슬라이드 이미지"><i class="xi-angle-left-thin"></i></button></div>
				<div class="btn-b next"><button type="button" title="다음 슬라이드 이미지"><i class="xi-angle-right-thin"></i></button></div>
				<div class="main-slide-page"></div>
				<ul class="main-slide-ul">
					<c:forEach items="${slide }" var="slide" >
						<li data-title="${slide.MM_TITLE }" data-comment="${slide.MM_COMMENT }">
							<c:choose>
								<c:when test="${slide.MM_KEYNO eq 'MM_0000000053'}">
									<img class="img-b" src="${slide.FS_PATH}" title="${slide.MM_COMMENT }" usemap="#map">
								</c:when>
								
								<c:when test="${slide.MM_URL eq ''}">
									<a href="javascript:;" title="${slide.MM_COMMENT }">
								</c:when>
								<c:otherwise>
									<a href="${slide.MM_URL}" target="_blank" title="${slide.MM_COMMENT }">
								</c:otherwise>
								
							</c:choose>
							<map name="map" id="map">
					    		<area shape="rect" coords="57,302,477,364" href="http://ncov.mohw.go.kr" alt="코로나바이러스감염증-19 바로가기" target="_blank">
					    		<area shape="rect" coords="57,377, 477,440" href="https://www.jeonnam.go.kr/M05040701/boardView.do?seq=0&menuId=jeonnam0504150400" 	alt="전라남도 일일상황보고 바로가기" target="_blank">
    						</map>
									<div class="img-b" style="background-image:url(${slide.FS_PATH});">
										<span style="position: absolute;font-size: 0;"><c:out value="${slide.MM_COMMENT }"/></span>
									</div>
								</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>



		<div class="main_notice_tab_box">
			<ul class="main_notice_tab">
				<li class="active">
					<a href="javascript:;" onclick="setPath('notice')">공지</a>
					<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=8"/> <!-- 공지  -->
				</li>
				<li>
				<a href="javascript:;" onclick="setPath('collusion')">공모</a>
				<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=15"/><!-- 공모 -->
				</li>
				<li>
				<a href="javascript:;" onclick="setPath('hire')">채용</a>
				<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=9"/> <!-- 채용 -->
				</li>
				<li>
				<a href="javascript:;" onclick="setPath('biddannouncement')">입찰</a>
				<c:import url="/common/Board/MainMiniBoard/UserViewAjax.do?key=10"/><!-- 입찰  -->
				</li>
			</ul>


			<script>

				//tabFucNomal('.main_notice_tab li', '.main_notice_tab_con');
				$('.main_notice_tab > li').eq(0).children('a').addClass('active');

				$('.main_notice_tab > li > a:not(.btn-more)').on('focus click', function () {
					$('.main_notice_tab > li > a').removeClass('active');
					$(this).addClass('active');
					return false;
				})

			</script>

		</div>


		<!-- <div class="side-bar_01">
			<div class="quickMenu_2 n02">
				<ul class="top_menu">
					<li>
						<a href="/jact/archives/material.do" title="서식자료 링크이동">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_01.jpg" alt=""></span>
							<span class="txt">서식자료</span>
						</a>
					</li>
					<li>
						<a href="/jact/open/consulting/question.do" title="1대1문의 링크이동">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_02.jpg" alt=""></span>
							<span class="txt">1:1문의</span>
						</a>
					</li>
					<li>
						<a href="/jact/open/consulting/free.do" title="고객의소리 링크이동">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_03.jpg" alt=""></span>
							<span class="txt">고객의소리</span>
						</a>
					</li>
					<li>
						<a href="/jact/archives/reference.do" title="카드뉴스 링크이동">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_04.jpg" alt=""></span>
							<span class="txt">카드뉴스</span>
						</a>
					</li>
				</ul>
				<ul class="bott_menu">
					<li><a href="https://www.facebook.com/jact5800" title="페이스북 링크이동" target="_blank"><img alt="페이스북" src="/resources/img/main/new/icon_quick_facebook.jpg"></a></li>
					<li><a href="https://www.instagram.com/jncf5800/" title="인스타그램 링크이동" target="_blank">
						<img alt="인스타그램" src="/resources/img/main/new/icon_quick_insta.jpg"></a></li>
					<li><a href="https://blog.naver.com/jact123" title="블로그 링크이동" target="_blank">
						<img alt="블로그" src="/resources/img/main/new/icon_quick_blog.jpg"></a></li>
					<li><a href="https://www.youtube.com/channel/UCCpPH4qc1xpanrUYpVEpWdg" target="_blank" title="유튜브 링크이동">
						<img alt="유튜브" src="/resources/img/main/new/icon_quick_youtube.jpg"></a></li>
					<li><button title="위로가기" class="upDown" onclick="browserTop()">
						<img src="/resources/img/main/new/icon_quick_arrow.png" alt=""> TOP</button></li>
				</ul>
			</div>
		</div>
		 -->
		
		
		
		<div class="side-bar_01">
			<div class="quickMenu_2 n02">
				<ul class="top_menu top_menuBox">
					<li class="disitalIcon">
						<a href="javascript:;">
							<span class="icon"><img src="/resources/img/main/new/icon_digitalMap.png" alt=""></span>
							<span class="txt">디지털맵</span>
						</a>
					</li>
					<li>
						<a href="/jact/archives/material.do">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_01.jpg" alt=""></span>
							<span class="txt">서식자료</span>
						</a>
					</li>
					<li>
						<a href="/jact/open/consulting/question.do">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_02.jpg" alt=""></span>
							<span class="txt">1:1문의</span>
						</a>
					</li>
					<li>
						<a href="/jact/open/consulting/free.do">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_03.jpg" alt=""></span>
							<span class="txt">고객의소리</span>
						</a>
					</li>
					<li>
						<a href="/jact/archives/reference.do">
							<span class="icon"><img src="/resources/img/main/new/icon_quick_04.jpg" alt=""></span>
							<span class="txt">카드뉴스</span>
						</a>
					</li>
				</ul>
				<ul class="bott_menu bott_squ">
					<li class="snsBox"><a href="https://www.facebook.com/jact5800" title="페이스북" target="_blank"><img alt="" src="/resources/img/main/new/icon_quick_facebook01.jpg"></a></li>
					<li class="snsBox"><a href="https://www.instagram.com/jncf5800/" title="인스타그램" target="_blank"><img alt="" src="/resources/img/main/new/icon_quick_insta01.jpg"></a></li>
					<li class="snsBox"><a href="https://blog.naver.com/jact123" title="블로그" target="_blank"><img alt="" src="/resources/img/main/new/icon_quick_blog01.jpg"></a></li>
					<li class="snsBox"><a href="https://www.youtube.com/channel/UCCpPH4qc1xpanrUYpVEpWdg" title="유튜브" target="_blank"><img alt="" src="/resources/img/main/new/icon_quick_youtube01.jpg"></a></li>
					<li><button title="위로가기" class="upDown" onclick="browserTop()"><img src="/resources/img/main/new/icon_quick_arrow.png" alt="화살표"> TOP</button></li>
				</ul>
			</div>
		</div>
		
		
		<!-- // 퀵메뉴 -->

		</div><!-- // inner -->
	</div>
	<div class="main_content_bott">
			<div class="inner1270"> <!-- inner -->

				<!-- 전남문회재단SNS -->
				<div class="main_title_munhwa">
					<h2>전남문화재단 SNS</h2>
				</div>

				<!-- 문화재단 sns 슬라이드 -->
				<div id="main_youtube_slide">
					<button type="button" class="btn_youtube prev" title="이전 유튜브영상"><i class="xi-angle-left-thin"></i></button>
					<button type="button" class="btn_youtube next" title="다음 유튜브영상"><i class="xi-angle-right-thin"></i></button>
					<ul class="main_youtube_slide_ul">

							<c:forEach items="${movie }" var="movies" >
								<c:set var="youtube_code" value="${fn:substring(movies.BM_URL ,fn:indexOf(movies.BM_URL,'?v=' ) + 3, fn:length(movies.BM_URL ))}"/>
								
								<li data-link="${youtube_code}" class="Middleslick">
									<a href="javascript:;" class="a1" onclick="window.open('${movies.BM_URL}')" title="새창 열림">
										<span class="img_s">
											<span class="icon"><i class="xi-play"></i></span>
											<img src="https://img.youtube.com/vi/${youtube_code }/mqdefault.jpg" alt="${movies.BM_TITLE }">
										</span>
									</a>
									<div class="movie_box">
										<%-- <a href="javascript" onclick="window.open('${movies.BM_URL}')" title="새창 열림">
											<img src="https://img.youtube.com/vi/${youtube_code }/mqdefault.jpg" alt="${movies.BM_TITLE }">
										</a> --%>
									</div>
								</li>

							</c:forEach>

					</ul>
					<!-- 웹접근성 수정 2020-11-27 -->
					<div class="main_youtube_bottom_box">
						<div class="main_youtube_page"></div>
						<button type="button" class="pause ma_youtube" title="멈춤"><i class="xi-pause"></i></button>
						<button type="button" class="play ma_youtube" title="재생"><i class="xi-play"></i></button>
					</div>
					<!-- // 웹접근성 수정 2020-11-27 -->
				</div>

				<script>
					$('.main_youtube_slide_ul').slick({
						// fade : true,
						autoplay: true,
						autoplaySpeed: 7000,
						// variableWidth: true,
						// adaptiveHeight: true,
						centerMode: true,
						slidesToShow: 3,
						centerPadding: '0',
						infinite: true,
						focusOnSelect: true,
						dots: true,
						arrows :true,
						prevArrow: $('.btn_youtube.prev'),
						nextArrow: $('.btn_youtube.next'),
						appendDots: $('.main_youtube_page'),
						responsive: [
							{
								breakpoint: 999,
								settings: {
									slidesToShow: 1,
									slidesToScroll: 1
								}
							},
						]
					});

					$('.ma_youtube.pause').on('click',function(){
						youtube_slide.slick('slickPause');
					})

					$('.ma_youtube.play').on('click',function(){
						youtube_slide.slick('slickPlay');
					})
				</script>




				<!-- SNS박스 -->
				<div class="main_sns_02_box">
					<ul class="main_sns02_ul">
						<c:forEach items="${crawling }" var="crawling">
							<c:choose>
								<c:when test="${crawling.TYPE eq 'facebook' }">
									<li class="facebook">
										<a href="https://www.facebook.com/jact5800" target="_blank" title="페이스북 링크이동">
											<span class="icon"><img src="/resources/img/main/new/icon_main_circle_facebook.png" alt=""></span>
											<div class="img_box"><img src="${crawling.IMGURL }" alt=""></div>
											<div class="txt_box">
												<p class="nor">
													${crawling.CONTENT }
												</p>
											</div>
										</a>
									</li>
								</c:when>
								<c:when test="${crawling.TYPE eq 'instagram' }">
									<li class="insta">
										<a href="https://www.instagram.com/jncf5800/" target="_blank" title="인스타그램 링크이동">
											<span class="icon"><img src="/resources/img/main/new/icon_main_circle_insta.png" alt=""></span>
											<div class="img_box"><img src="${crawling.IMGURL }" alt=""></div>
											<div class="txt_box">
												<p class="nor">
													${crawling.CONTENT }
												</p>
											</div>
										</a>
									</li>
								</c:when>
								<c:when test="${crawling.TYPE eq 'blog' }">
									<li class="blog">
										<a href="https://blog.naver.com/jact123" target="_blank" title="네이버 링크이동">
											<span class="icon"><img src="/resources/img/main/new/icon_main_circle_blog.png" alt=""></span>
											<div class="img_box"><img src="${crawling.IMGURL }" alt=""></div>
											<div class="txt_box">
												<h2>${crawling.TITLE }</h2>
												<p class="nor">
													${crawling.CONTENT }
												</p>
											</div>
										</a>
									</li>
								</c:when>
							</c:choose>
						</c:forEach>
					</ul>
				</div>
			</div><!-- // inner -->
		</div>
		<!-- // BOTTOM BOX -->

		<!-- // 2020-11-02 수정 -->
</section>
<!-- 메인 밑에 배너 -->
	<div id="main-link-banner-w">
		<div class="inner1200">
			<div class="btn prev"><a href="javascript:;" title="이전 배너 이미지"><i class="xi-angle-left-thin"></i></a></div>
			<div class="link-banner-box">
				<ul class="m-b-link-banner">
				<c:forEach var="i" begin="0" end="2">
					<c:forEach items="${banner }" var="banners" >
						<li><a href="${banners.BM_URL }" target="_blank" title="${banners.BM_TITLE }로  이동"><img src="${banners.FS_PATH }" alt="${banners.BM_TITLE }"></a></li>
					</c:forEach>
				</c:forEach>
				</ul>
			</div>
			<div class="btn next"><a href="javascript:;" title="다음 배너 이미지"><i class="xi-angle-right-thin"></i></a></div>
		</div>
	</div>



<script>
$(function(){
	var msg = '${msg}';
	if(msg){
		alert(msg);
	}

	$(".slick-dots .pause .xi-pause").append("<span style='position: absolute;font-size: 0;'>멈춤</span>")
	
	pf_activeSlide();

	 $(".main_youtube_slide_ul").on("afterChange", function(){
		 pf_activeSlide();
	 });

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

function pf_activeSlide(){
    var obj = $(".slick-current > div > li.Middleslick");
    var clonedBox= $(".slick-slide > div > li.Middleslick > div");
    var currentBox = $(".slick-current > div > li.Middleslick > div");
    var temp = "";
    var link = obj.data("link");
    var url = 'https://www.youtube.com/watch?v='+link;
//     temp += '<a href="javascript" onclick="window.open(\'' + url + '\')"><img style="width:100%" src="https://img.youtube.com/vi/'+link+'/mqdefault.jpg" alt="새창 열림"></a>';
    temp += '<iframe title="전남문화재단유튜브" width="100%" height="100%" src="https://www.youtube.com/embed/'+link+'"';
    temp += ' frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture; autoplay; mute;" allowfullscreen></iframe>';
    clonedBox.html('');
    currentBox.html(temp);
}

</script>
