// JavaScript Document
$(function(){

	//관광명소 전체 탭
	tabFucNomal('.sightseeTabUl li','.sightseeTabContentWrap')

	//관광명소 자세히보기 - 슬라이드
	$('.sightsee-slide-for').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		fade: true,
		asNavFor: '.sightsee-slide-nav'
	});
	var subSlide = $('.sightsee-slide-nav').slick({
		asNavFor: '.sightsee-slide-for',
		slidesToShow: 3,
		slidesToScroll: 1,
		dots: false,
		arrows: false,
		centerMode: true,
		focusOnSelect: true,
		centerPadding: '0'

	});
	//슬라이드 화살표버튼
	$(".sightsee-slide-nav-wrap .arrow.prev").on("click",function(){
		subSlide.slick('slickPrev');
	})
	$(".sightsee-slide-nav-wrap .arrow.next").on("click",function(){
		subSlide.slick('slickNext');
	})

});

//관련사이트 이동
function pf_urlMove(){
	var target = $("#siteSelect option:selected").data('target');
	var url = $("#siteSelect option:selected").data('url');
	if(target == 'N'){
		window.open(url);
	}else if(target == 'C'){
		location.href=url;
	}
}

