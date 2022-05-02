// JavaScript Document
$(function(){
	
	/***************************		
		해더 메인메뉴안의 서브메뉴		
	***************************/	
	//펼침, 닫힘
	$('.mainMenu li').on('mouseover',function(){
		$('.navWrapSubMenu').stop().slideDown();
	});
	
	$('.navWrapSubMenu').on('mouseleave',function(){
		$(this).stop().slideUp();
	});
	$('.mainMenu li a, .subMenu_Sub a').on({
		focus:function(){
			$('.navWrapSubMenu').stop().slideDown();
		}
		,blur:function(){
			$('.navWrapSubMenu').stop().slideUp();
		}
	})
	
	//서브메뉴 마우스오버 메인메뉴 글자 색 바뀜
	$('.subMenu > li').on('mouseover',function(){
		var menuNum = $(this).index();		
		$('.mainMenu li a').eq(menuNum).css('color','#e22730');
	});
	
	$('.subMenu > li').on('mouseleave',function(){
		var menuNum = $(this).index();		
		$('.mainMenu li a').eq(menuNum).css('color','#333');
	});
	
		
	//서브메뉴 플러스 누르면 나오는 말풍선메뉴		
	$('.subMoreBtn a').on('click',function(){
		var $subMoreBtn = $(this).parents('.subMoreBtn');
		var $subMenu_SubInner = $(this).next();
		var $img = $(this).find('img');
		$subMoreBtn.toggleClass('active');
		
		$('.subMenu_SubInner').hide();
		$subMenu_SubInner.show();
		$('.subMoreBtn img').attr('src',$('.subMoreBtn img').attr('src').replace('minus','plus'));
		$img.attr('src',$img.attr('src').replace('plus','minus'));
		
		$('.subMoreBtn').not($subMoreBtn).removeClass('active');
		
		if($subMoreBtn.hasClass('active')){
			
		}else {	
			$subMenu_SubInner.hide();
			$img.attr('src',$img.attr('src').replace('minus','plus'));
		}
	});
	
	
	/*********************************		
		헤더 모바일 메뉴 (햄버거 메뉴)		
	**********************************/
	var forEach=function(t,o,r){if("[object Object]"===Object.prototype.toString.call(t))for(var c in t)Object.prototype.hasOwnProperty.call(t,c)&&o.call(r,t[c],c,t);else for(var e=0,l=t.length;l>e;e++)o.call(r,t[e],e,t)};

	var hamburgers = document.querySelectorAll(".hamburger");
	if (hamburgers.length > 0) {
	  forEach(hamburgers, function(hamburger) {
		hamburger.addEventListener("click", function() {
		  this.classList.toggle("is-active");
		}, false);
	  });
	}
	
	// 모바일 메뉴 누르면 (햄버거메뉴)
	$(".mobileMenuBtnBox").on('click',function(){
		
		$('#mobileMenu').stop().toggle();
	});
	
	
	//모바일 서브메뉴 펼침
	$('ul.mobileMenuUl > li').on('click', function(){
		
		$(this).toggleClass('active');
		$('ul.mobileMenuUl > li').not($(this)).removeClass('active');
		$('ul.mobileMenuUl > li img').not($(this)).attr('src',$('ul.mobileMenuUl > li img').attr('src').replace('minus','plus'));
		$('ul.mobileSubMenuUl').stop().slideUp();
		
		if($(this).hasClass('active')){
			$('+ul.mobileSubMenuUl',this).stop().slideDown();
			$('img',this).attr('src',$('img',this).attr('src').replace('plus','minus'));
		} else {
			$('+ul.mobileSubMenuUl',this).stop().slideUp();
			$('img',this).attr('src',$('img',this).attr('src').replace('minus','plus'));
		}
	});
	$('ul.mobileSubMenuUl > li').on('click', function(){
				
		$(this).toggleClass('active');
		$('ul.mobileSubMenuUl > li').not($(this)).removeClass('active');
		$('ul.mobileSubMenuUl > li img').not($(this)).attr('src',$('ul.mobileSubMenuUl > li img').attr('src').replace('minus','plus'));
		$('ul.mobileSubInnerMenuUl').stop().slideUp();
		
		if($(this).hasClass('active')){
			$('+ul.mobileSubInnerMenuUl',this).stop().slideDown();
			$('img',this).attr('src',$('img',this).attr('src').replace('plus','minus'));
		} else {
			$('+ul.mobileSubInnerMenuUl',this).stop().slideUp();
			$('img',this).attr('src',$('img',this).attr('src').replace('minus','plus'));
		}
	});
	
	/***************************		
		메인 공지사항 탭 부분		
	***************************/	
	// 메인 공지사항 탭 클릭
	$('.noticeBox .topBox ul li').click(function() {
		setTab($(this).index());
		return false;
  	});
	  
	var sc = $('.noticeBox .contentsBox ul');
	var a = $('.noticeBox .topBox ul li');
	a.eq(0).addClass('active');
	sc.hide();
	sc.eq(0).show();
	function setTab(what) {
		sc.hide();
		sc.eq(what).show();
		a.removeClass('active');
		a.eq(what).addClass('active');
	}; 
	
	/***********************
	 sns 탭 부분
	************************/
	$('.titleBox .snsBox  ul li').click(function() {
		setsnsTab($(this).index());
		var snsimg = $('.snsBox ul li a img');
		snsimg.eq(0).attr("src", "/resources/img/icon/icon_mainSns_inner_facebook_nomal.png");
		snsimg.eq(1).attr("src", "/resources/img/icon/icon_mainSns_inner_blog_nomal.png");
		snsimg.eq(2).attr("src", "/resources/img/icon/icon_mainSns_inner_youtube_nomal.png");
		var snsState = $(this).index();
		if(snsState == 0){
			snsimg.eq(0).attr("src", "/resources/img/icon/icon_mainSns_inner_facebook_over.png");
		}else if(snsState ==1){
			snsimg.eq(1).attr("src", "/resources/img/icon/icon_mainSns_inner_blog_over.png");
		}else if (snsState ==2){
			snsimg.eq(2).attr("src", "/resources/img/icon/icon_mainSns_inner_youtube_over.png");
		}
		
		return false;
  	});
	  
	var scSns = $('.main_sns_Box_face .mainRelateSite');
	var aSns = $('.snsBox  ul li');
	aSns.eq(0).addClass('active');
	scSns.hide();
	scSns.eq(0).show();
	function setsnsTab(what) {
		scSns.hide();
		scSns.eq(what).show();
		aSns.removeClass('active');
		aSns.eq(what).addClass('active');
	}; 
	
	/*********************************
	본문바로가기
	*********************************/
	$('.skip').on({
		focus:function(){
			$(this).css("width","auto")
		},blur:function(){
			$(this).css("width","0px")
		}
	});
	
	/******************************
		서브탭 모바일 메뉴
	*******************************/
	var subTabHeight = parseInt($('.mobileSubMenuTab .title').innerHeight());
	$('.mobileSubMenuTab .menuList').css('top',subTabHeight+"px");
	
	$('.mobileSubMenuTab .title').on('click',function(){
		$('.mobileSubMenuTab .menuList').stop().slideToggle();
	});
	
	/******************************
	한눈에 보기
	*******************************/
	$('.viewAllBox').on('click',function(){
		$('#viewAllWrap').fadeIn('fast');		
	});
	
	$('#viewAllWrap .closeBtn').on('click',function(){
		$('#viewAllWrap').fadeOut('fast');		
	});
	
	$('.blackBox_02').on('click',function(){
		$('#viewAllWrap').fadeOut('fast');		
	});
	
	/******************************
	팝업창
	*******************************/
	
	//팝업 밑에 회색부분
	var popGrayHeight = parseInt($('.popUpBox .bottomBox').innerHeight());
	
	$('.popUpBox .backGrayBox').css("height",popGrayHeight+11+"px");
	$('.popUpBox .innerBox .whiteLineLeft').css("height",popGrayHeight+"px");
	$('.popUpBox .innerBox .whiteLineRight').css("height",popGrayHeight+"px");
	
	//팝업가운데 띄우기
	
	var popUpHeight = parseInt($('.popUpBox').outerHeight());
	var popUpWidth = parseInt($('.popUpBox').outerWidth());
	
	var popHeightHalf = parseInt(popUpHeight/2);
	var popWidthHalf = parseInt(popUpWidth/2);
	
	
	$('.popUpBox').css({
		marginTop:"-"+popHeightHalf+"px",
		marginRight:"-"+popWidthHalf+"px"
	});
	
	/*****************************		
	검색창, 검색어 입력 부분		
	******************************/
	$('.mobileSearchBtn').on('click',function(){
		$('.mobileSearchWrap').stop().show();
        $('img',this).stop().hide();
        if($('.hamburger').hasClass('is-active')){
        	$('.hamburger').trigger('click')
        }
	});
	
	$('.mobileSaerchGoBox .closeBox').on('click',function(){
		$('.mobileSearchWrap').stop().hide();
        $('.mobileSearchBtn img').stop().show();
	});
	
	$(window).resize(function(){
		if($(window).width() > 850){
			$('.mobileSearchWrap').stop().hide();
	        $('.mobileSearchBtn img').stop().show();
		}
	})
	
});