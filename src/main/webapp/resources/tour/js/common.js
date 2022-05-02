// JavaScript Document
$(function(){
	
	//본문바로가기
	$('.skip').on({
		focus:function(){
			$(this).parents('#accessibility').css('top','0');
		},blur:function(){
			$(this).parents('#accessibility').css('top','-30px');
		}
	});

	//검색창 메뉴
	searchBtnMenu();
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

//누르면 페이지 위로 올라감.
function browserTop() {
	$("html, body").stop().animate({
		scrollTop:0
	},500,"easeInOutCubic")
}


//검색창 메뉴
function searchBtnMenu() {
	//PC 검색창 열기
	var $searchWrap = $('.search-header-wrap');

	$('.top-header-line .search-b').on('click',function(){
		$searchWrap.stop().slideDown();
		$("#searchHeaderId").focus();
	})

	//모바일 검색창 열기
	$('.m-btn-search-1').on('click',function(){
		mobileMenuHide();
		$searchWrap.stop().slideDown();
		$("#searchHeaderId").focus();
	})

	
	//검색창 닫기
	$('.search-header-wrap .close-b').on('click',function(){
		$searchWrap.stop().slideUp();
	})
}



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