// JavaScript Document

//pc 메뉴
var $amiationBG ="";
var $pcMenuMainUl = "";
var $pcMenuMainLi = "";
var $pcMenuDep02 = "";
var $pcMenuDep02Li = "";
var $pcMenuDep02LiA = "";
var $pcMenuDep02Bg = "";
var $pcMenuDep03 = "";

//모바일
var $mobileBtn =  "";
var $wrapAll = "";
var $mobileMenu = "";
var $shadowBox = "";
var $MobileGnb = "";
var $mobileMeuA = "";
var $mobileSubMeuA = "";


$(function(){
	
	//pc 메뉴 초기화
	pcMenuInit();
	//pc 메뉴 이벤트
	pcMenuEvent();


	//모바일 메뉴 초기화
	mobileMenuInit();
	//모바일 메뉴 이벤트
	mobileMenuEvent();

	mobileSubSubMenu();
});

//pc 초기화
function pcMenuInit() {
	$amiationBG = $('#nav-animate');

	$pcMenuMainUl = $('.main-menu-ul');
	$pcMenuMainLi = $('.main-menu-ul > li');

	$pcMenuDep02 = $('.main-menu-ul .s-dep2');
	$pcMenuDep02Li = $('.main-menu-ul .s-dep2 > li');
	$pcMenuDep02LiA = $('.main-menu-ul .s-dep2 > li .s-sbj');
	$pcMenuDep02Bg = $('.main-gnb-bg');

	$pcMenuDep03 = $('.main-menu-ul .s-dep2 .s-dep3');
}

//pc 이벤트
function pcMenuEvent() {

	var amimaHeightOri = $('.top-header-line').innerHeight();
	var amimaHeight = $('.top-header-line').innerHeight()+$pcMenuDep02.innerHeight();

	var amimaHeight2 = 0;


	//pc메뉴 마우스오버 메뉴나타남

	$pcMenuMainLi.on('mouseenter',function(){

		$('#nav-animate').stop().animate({
			height:amimaHeight
		});
		
		$pcMenuMainLi.removeClass('active');
		$(this).addClass('active');
		$(this).children('.s-dep2').stop().show();
	})


	$pcMenuMainUl.on('mouseleave',function(){
		$pcMenuDep02LiA.removeClass('active');
		$('#nav-animate').stop().animate({
			height:amimaHeightOri
		});
	})


	//pc메뉴 서브 마우스오버 dep3메뉴 나타남
	$pcMenuDep02LiA.on('mouseenter',function(){
		
		amimaHeight2 = amimaHeight;

		if($(this).next('.s-dep3').length) { //옆에 있다면 .length를 사용
			amimaHeight2 = amimaHeight + $(this).next('.s-dep3').outerHeight();
		}

		$('#nav-animate').stop().animate({
			height:amimaHeight2
		});

		
		if($(this).hasClass('active')) {
			
		} else {
			$pcMenuDep02LiA.removeClass('active');
			$(this).addClass('active');
		}
	})
}





//모바일 초기화
function mobileMenuInit() {

	//모바일
	$mobileBtn =  $('.mobile-menu-btn');
	$wrapAll = $('#wrap_All');
	$mobileMenu = $('#top_mobile_menu');
	$shadowBox = $('.shadowBox');
	$MobileGnb = $('#mobile_gnb');
	$mobileMeuA = $('#mobile_gnb .m-sbj');
	$mobileSubMeuA = $('#mobile_gnb .s-sbj');
}


//모바일 이벤트
function mobileMenuEvent() {

	//모바일 메뉴 나오는 버튼
	$mobileBtn.on('click',function(){		
		mobileMenuShow();
	})

	//검은박스 누르면 메뉴 사라짐
	$shadowBox.on('click',function(){
		mobileMenuHide()	
	})

	//모바일 버튼 누르면 서브메뉴 나타남
	$mobileMeuA.on('click',function(){
		$mobileMeuA.removeClass('active');
		$(this).addClass('active');
	})

	//서브메뉴 누르면 서브3이 나옴
	$mobileSubMeuA.on('click',function(){
		mobileSubMenuSlide($(this));
	})

}


//모바일 메뉴 나타남
function mobileMenuShow() {
	$wrapAll.css({
		overflow:'visible'
	})

	$wrapAll.animate({		
		left:-300
	},300);

	$shadowBox.fadeIn();
}

//모바일 메뉴 닫힘
function mobileMenuHide() {
	$wrapAll.css({
		overflow:'hidden'
	})

	$wrapAll.css({
		left:0
	});

	$shadowBox.fadeOut();
}


//모바일 서브3 나타남
function mobileSubMenuSlide(me){

	me.next('.dep3').stop().slideToggle();

	me.stop().toggleClass('active');

	if(me.hasClass('active')) {
		me.find('.arrow i').html('remove');
	} else {
		me.find('.arrow i').html('add');
	}

	/* 아코디언	
	me.next('.dep3').slideDown();
	$mobileSubMeuA.not(me).next('.dep3').slideUp();

	me.addClass('active');
	$mobileSubMeuA.not(me).removeClass('active');

	me.find('.arrow i').html('remove');
	$mobileSubMeuA.not(me).find('.arrow i').html('add');
	*/
}


//서브메뉴 안에 서브메뉴
function mobileSubSubMenu() {

	$('.sub-sub-gnb .mobile-arrow').on('click',function() {
		$(this).toggleClass('active');
		
		if($(this).hasClass('active')){
			$('.sub-sub-gnb > li .s-sbj').css("display","block");
			$('.sub-sub-gnb .mobile-arrow i').html('arrow_drop_up');
		} else {
			$('.sub-sub-gnb .s-sbj').not('.active').css('display','none');
			$('.sub-sub-gnb .mobile-arrow i').html('arrow_drop_down');
		}
	})
}






