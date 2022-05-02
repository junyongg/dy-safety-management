// JavaScript Document
$(function(){

	//메인 슬라이드
	var mainSlide = $('.main-slide-ul').not('.slick-initialized').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		autoplay: true,
		fade: true,
		speed:1000,
		infinite:true,
		autoplaySpeed: 4000,
		easing: 'swing',
		dots: true,
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


	//메인 뉴스 탭부분
	tabFucNomal('.main-survey-tab li','.main-survey-con')


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
}