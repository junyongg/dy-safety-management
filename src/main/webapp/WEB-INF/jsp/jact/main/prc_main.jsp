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


