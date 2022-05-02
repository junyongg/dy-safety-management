// JavaScript Document
$(function(){


	/************ 메인 슬라이드 ***************/

	/*******메인슬라이드 - 변수지정******/
	var $mainVisual = $(".main-slide-ul");
	/*메인슬라이드*/
	$mainVisual.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		autoplay: true,
		fade: true,
		speed:1000,
		infinite:true,
		autoplaySpeed: 4500,
		easing: 'easeInOutQuart',
		pauseOnHover:false,
		dots: true,
		appendDots: '.m-slide-paging-box',
	});

	$(".main-slide-ul li").eq(0).addClass('active');

	var mainIconNum = 1;
	var mainTourNum = 1;

	/*메인슬라이드 글자 애니메이션 - 화면바뀌고 */
	$mainVisual.on('afterChange', function(event, slick, currentSlide){		
		//메인슬라이드 글자 클래스 추가
        $(".main-slide-ul li").removeClass("active");
		$(this).find("li").eq(currentSlide).addClass("active");
	});


	/*메인슬라이드 - 화면바뀌기 전에 - 지도, 아이콘*/
	$mainVisual.on('beforeChange', function(event, slick, currentSlide){

		//화면 바뀔때마다 메인슬라이드 아이콘 바뀌기
		$mainIconUl.eq(mainIconNum).trigger('click');
		mainIconNum++;
		if(mainIconNum >= $mainIconUl.length ) {
			mainIconNum = 0;
		}

		//모바일에선 작동 안함
		if($(window).width() > 1300) {
			//화면 바뀔때마다 메인슬라이드 지도 바뀌기		
			$tourMapLocation.eq(mainTourNum).find('.name').trigger('click');
			mainTourNum++;
			if(mainTourNum >= $tourMapLocation.length ) {
				mainTourNum = 0;
			}
			
		}
    }); 


	//투어지도 - 모바일 슬라이드
    if($(window).width() < 1300) {
    	var $tourMapMobile = $('.tour-mobile-slide');

    	$tourMapMobile.slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			arrows: true,
			//autoplay: true,
			fade: true,
			speed:500,
			infinite:true,
			easing: 'easeInOutQuart',
			pauseOnHover:false,
			dots: false,
			prevArrow: '<button type="button" class="mobile-btn prev"><i class="material-icons">arrow_back_ios</i></button>',
			nextArrow: '<button type="button" class="mobile-btn next"><i class="material-icons">arrow_forward_ios</i></button>',
		});
    }


	//메인 아이콘 움직이기	
	var $mainIconUl = $(".icon-box ul li");

	$mainIconUl.on('click',function(){
		$mainIconUl.removeClass('active');
		$(this).addClass('active');
	})

	//아이콘 첫번째 클래스 추가
	$mainIconUl.eq(0).addClass('active');


	//메인 슬라이드 투어지도
	var $tourMapLocation = $('.m-s-tour-map-box .tour-detail-b');
	var $tourMapLocationTitle = $('.m-s-tour-map-box .tour-detail-b .name');

	function tourMapSlideUp(){
		$tourMapLocation.removeClass('active');
		$tourMapLocation.find(".more-tour-box").stop().fadeOut(200);
	}

	$tourMapLocationTitle.on("click",function(){
		tourMapSlideUp();
		$(this).parents('.tour-detail-b').addClass('active');
		$(this).nextAll(".more-tour-box").stop().fadeIn(200);
	})
	
	//투어지도 닫기 버튼
	$('.tour-detail-b .close-b').on('click',function(){
		tourMapSlideUp();
	})

	//투어 지도 움직이기 - pc에서만 작동 - 첫번째 클래스 추가
	if($(window).width() > 1300) {
		$tourMapLocation.eq(0).find('.name').trigger('click');
	}





	/****** 메인 달력 슬라이드 *****/
	var $mainCalendarSlide = $(".m-calendar-slide");

	$mainCalendarSlide.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		speed:1000,
		infinite:true,
		autoplaySpeed: 4000,
		easing: 'easeInOutQuint',
	});

	$(".cal-slide-arrow-Prev").on("click",function(){
		$mainCalendarSlide.slick('slickPrev');
	})
	$(".cal-slide-arrow-Next").on("click",function(){
		$mainCalendarSlide.slick('slickNext');
	})




	/***** 메인 이야기 고흥여행 슬라이드 *****/
	var $mainStorySlide = $(".m-story-slide-ul");

	$mainStorySlide.slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		fade: true,
		arrows: false,
		speed:1000,
		infinite:true,
		autoplaySpeed: 4000,
		easing: 'easeInOutQuint',
		autoplay: true,
		dots: true,
	});

	$(".m-story-slide-prev").on("click",function(){
		$mainStorySlide.slick('slickPrev');
	})
	$(".m-story-slide-next").on("click",function(){
		$mainStorySlide.slick('slickNext');
	})


	//고흥여행 플레이 버튼
	$(".main-story-slide-box .slick-dots").append("<li class='slide-Play'><a href='javascript:;'><i class='material-icons'>pause</i></a></li>");

	var $storySlideArrowPlay = $('.main-story-slide-box .slick-dots .slide-Play');
	var $storySlideArrowPlayButton = $('.main-story-slide-box .slick-dots .slide-Play i');

	var xpaused = false;
	$storySlideArrowPlay.on("click",function(){
		if(xpaused == false) {			
			$mainStorySlide.slick('slickPause');
			$storySlideArrowPlayButton.html('play_arrow');
		} else {
			$mainStorySlide.slick('slickPlay');
			$storySlideArrowPlayButton.html('pause');
		}
		xpaused = !xpaused;
	})



	/************ 메인 제이쿼리 ************/

	//예약 슬라이드 다운
	var $mainServiceReBox = $('.m-go-service-box');
	var $mainServiceOneFirst = $mainServiceReBox.children('.one').eq(0);
	var $mainServiceSubject = $mainServiceReBox.find("h3");
	var $mainServiceHideBox = $mainServiceReBox.find(".hire-01");


	$mainServiceOneFirst.addClass('active');
	$mainServiceOneFirst.find('.hire-01').show();

	$mainServiceSubject.on("mouseenter focusin",function(){
		$mainServiceReBox.children(".one").removeClass('active');
		$mainServiceHideBox.stop().slideUp(500);

		$(this).next().stop().slideDown(500);
		$(this).parents('.one').addClass('active');
	})

	//와우 애니메이션 등록
	wow = new WOW(
        {
          boxClass:     'wow',      // default
          animateClass: 'animated', // default
          offset:       0,          // default
          live:         true,        // default
          mobile:       false       // default
        }
	)
	//wow.init();


	//모바일에서만 애니메이션 작동
	if($(window).width() > 999) {
	    wow.init();		
	}

});



//슬라이드 마우스 움직임 클릭
function downMainCon() {
	var topNum = $('.main-festival-section').offset().top;

	$('html, body').stop().animate({
		scrollTop:topNum
	},500,"easeInOutCubic");
}

