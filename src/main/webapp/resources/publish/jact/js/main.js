// JavaScript Document
$(function(){

	//메인 슬라이드
	var mainSlide = $('.main-slide-ul').not('.slick-initialized').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		autoplay: true, //자동으로 실행함
		fade: true, //사라지는 효과, 페이드 기능
		speed:1000, 
		infinite:true, 
		autoplaySpeed: 4000,  //메인슬라이드 속도 조절
		easing: 'swing',
		dots: true, //페이드 버튼(하단에 주로 삽입하는)
		appendDots :'.main-slide-page'
	});

	$('#main-slide-box .slick-dots').append('<span class="pause"><button type="button"><i class="xi-pause"></i></button></span>');

	$('#main-slide-box .prev').on('click',function(){
		mainSlide.slick('slickPrev');
	})
	$('#main-slide-box .next').on('click',function(){
		mainSlide.slick('slickNext');
	})

	$('#main-slide-box .pause').on('click',function(){
		mainSlide.slick('slickPause');
	})


	//메인달력 팝업
	var $mainEventPop = $('.popUp-m-e');

	$('.popUp-m-e .btn-cl').on('click',function(){
		$mainEventPop.hide();
	})

	$('.main-cal-box .day_ul li').on('click',function() {
		
		//포지션
		$mainEventPop.show();
		var poNum = $(this).position().left;

		$mainEventPop.css('left',poNum + 12);


		//클래스
		$('.main-cal-box .day_ul li').removeClass('active');
		$(this).addClass('active');
	})

	//메인 달력 모바일 팝업 - 슬라이드
	//슬라이드
	function mainMoPopF() {
		var $mainMobileEPop = $('.popUp-m-e-m .con-b2');

		var mainMobileEPopS = $mainMobileEPop.not('.slick-initialized').slick({
			slidesToShow: 2,
			slidesToScroll: 1,
			arrows: false,
			autoplay: true,
			speed:600,
			infinite:true,
			autoplaySpeed: 4000,
			easing: 'swing',
			dots: false,
			centerMode: false,
		});

		$('.popUp-m-e-m .prev').on('click',function(){
			mainMobileEPopS.slick('slickPrev');
		});

		$('.popUp-m-e-m .next').on('click',function(){
			mainMobileEPopS.slick('slickNext');
		});

	}

	//모바일 클릭
	if($(window).width() < 999) {
		$('.main-cal-box .day_ul li').on('click',function() {
			//모바일
			$('.popUp-m-e-m').show();
			mainMoPopF();
		})
	}

	
	//메인 밑에 배너
	var $mBottomBanner = $('.m-b-link-banner');

	if($(window).width() > 999) {
		var slideBottom = $mBottomBanner.not('.slick-initialized').slick({
			slidesToShow: 7,
			slidesToScroll: 1,
			arrows: false,
			autoplay: true,
			speed:600,
			infinite:true,
			autoplaySpeed: 4000,
			easing: 'swing',
			dots: false
		});
	} else { //모바일
		var slideBottom = $mBottomBanner.not('.slick-initialized').slick({
			slidesToShow: 2,
			slidesToScroll: 1,
			arrows: false,
			autoplay: true,
			speed:600,
			infinite:true,
			autoplaySpeed: 4000,
			easing: 'swing',
			dots: false
		});	
	}

	//버튼
	$('#main-link-banner-w .btn.prev a').on('click',function(){
		slideBottom.slick('slickPrev');
	});

	$('#main-link-banner-w .btn.next a').on('click',function(){
		slideBottom.slick('slickNext');
	});

	//메인 뉴스 탭부분
	tabFucNomal('.main-board-tab li','.main-board-tab-con');

      
});



// 탭 부분
var sc = "";
var a = "";

function tabFucNomal(tabTitle,tabContents) {
	
	init(tabTitle,tabContents);

	$(tabTitle).on('click',function(){
		init(tabTitle,tabContents);
		setTab($(this).index());
		return false;
	});	
}


function init(tabTitle,tabContents) {
	sc = $(tabContents);
	a = $(tabTitle);
	a.eq(0).addClass('active');
	sc.hide();
	sc.eq(0).show();	
}


function setTab(index) {
	sc.hide();
	sc.eq(index).fadeIn();
	a.removeClass('active');
	a.eq(index).addClass('active');
  	$('ul.main-board-tab li').attr('title','');
  	var str = a.eq(index).text();
	$('li.active').attr('title', str + '선택됨');
}
	
	