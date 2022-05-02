
/*************************************************************************************************
 
 *  Slider JS
 
 *************************************************************************************************/

$(function(){

	"use strict";

/*---------------------------------------------------------------------------------------------------------------------------
 *  매인 슬라이드
 *--------------------------------------------------------------------------------------------------------------------------*/
	var mainSlide = new Swiper('.img_slide_box', {
		loop: true,
		speed: 1000,
        autoplay: {
            delay: 5000,
		},
		effect : 'fade',
		// fadeEffect: {
		// 	crossFade: true
		// },
		slideToClickedSlide: true,
		pagination: {
			el: '.main_slide_nav nav',
			type: 'bullets',
			clickable : 'true',
		},
	});

		
	// 플레이 버튼 
	$('.main_slide_nav .btn_pause').on({
		"click": function () {
			if ($(this).hasClass('on')) {
				$(this).removeClass('on');
				$(this).find('i').removeClass('xi-play');
				$(this).find('i').addClass('xi-pause');
				$(this).attr('title','멈춤');
				mainSlide.autoplay.start();
			} else {
				$(this).addClass('on');
				$(this).find('i').removeClass('xi-pause');
				$(this).find('i').addClass('xi-play');
				$(this).attr('title', '재생');
				mainSlide.autoplay.stop();
			}
		}
	})




/*---------------------------------------------------------------------------------------------------------------------------
 *  매인 포토 갤러리
 *--------------------------------------------------------------------------------------------------------------------------*/
	new Swiper('.ma_photo_slide_wrap', {
		loop: true,
		speed: 700,
		autoplay: {
			delay: 4000,
		},
		// autoHeight: true,
		spaceBetween : 20,
		navigation: {
			nextEl: '.btn_photoSl.next',
			prevEl: '.btn_photoSl.prev',
		},
		slideToClickedSlide: true,
		slidesPerView: 4,
		// centeredSlides: true,
		slidesOffsetBefore: 0,
		// grabCursor: true,
		breakpoints: {
			1000: {
				slidesPerView: 2,
				spaceBetween: 20,
			},
			500: {
				slidesPerView: 1,
				spaceBetween: 20,
			}
		}
	});






});




