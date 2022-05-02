// JavaScript Document
var share_url ="";
var share_img ="";
var share_title="";
var share_type="";
/**
 * 모바일 구분
 */
var isMobile = {
        Android: function () {
                 return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function () {
                 return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function () {
                 return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function () {
                 return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function () {
                 return navigator.userAgent.match(/IEMobile/i);
        },
        any: function () {
                 return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
};


// JavaScript Document
$(function () {
  
  var width = $(window).width();
  $('.popUp_detail_1_wrap .btn_open.on').parent('.popUp_detail_1_wrap').css('right','-1000px')


  // 상세페이지 팝업
  $('.popUp_detail_1_wrap .btn_open').on({
    click : function(){
      if($(this).hasClass('on')){
        $(this).removeClass('on');
        $('.popUp_detail_1_black').show();
        //모바일
        if (width>=1000) {
          $(this).parent('.popUp_detail_1_wrap').animate({right : 0,}, 1000, 'swing')
        } else {
          $(this).parent('.popUp_detail_1_wrap').animate({bottom : 0,}, 1000, 'swing')
        }
      } else {
        $(this).addClass('on');
        $('.popUp_detail_1_black').hide();
        //모바일
        if (width>=1000) {
          $(this).parent('.popUp_detail_1_wrap').animate({right : -1000,}, 1000, 'swing')
        } else {
          $(this).parent('.popUp_detail_1_wrap').animate({bottom: -70 + '%',}, 1000, 'swing')
        }
      }
    }
  })


});





// 문화재단 위치개요 팝업
function popUp_loca01_show() {
  $('.popUp_black_01').show();
  $('.popUp_loca_01').show();
}

function popUp_loca01_hide() {
  $('.popUp_black_01').hide();
  $('.popUp_loca_01').hide();
}


// 문화재단 sns공유 팝업
function popUp_sns01_show(url) {
  $('.popUp_sns_01_black').show();
  $('.popUp_sns_01').show();
  
  
  share_url = url;
  
  $("#Twit").attr("href", "https://twitter.com/intent/tweet?url="+url);
  $("#Face").attr("href", "http://www.facebook.com/share.php?u="+url);
  $("#blog").attr("href", "http://blog.naver.com/openapi/share?url="+url);
  
  
}

function popUp_sns01_hide() {
  $('.popUp_sns_01_black').hide();
  $('.popUp_sns_01').hide();
}


// 문화재단 동영상재생 팝업
function popUp_youtube01_show() {
  $('.popUp_youtube_01_black').show();
  $('.popUp_youtube_01').show();
}

function popUp_youtube01_hide() {
  $('.popUp_youtube_01_black').hide();
  $('.popUp_youtube_01').hide();
}










//스크롤이동
function scollMove(id) {
  $("html, body").stop().animate({
    scrollTop: $(id).offset().top
  }, 500, "easeInOutCubic")
}



//누르면 페이지 위로 올라감.
function browserTop() {
  $("html, body").stop().animate({
    scrollTop: 0
  }, 500, "easeInOutCubic")
}


// 프린트하기
function printPc() {
  // const origin = $('#wrap').html();
  // const protent = $('#contents').html();

  // $('#wrap').html(protent);
  // window.print();
  // $('#wrap').html(origin);

  window.print();
}



//탭부분
function tab(e, num) {
  var num = num || 0;
  var menu = $(e).children();
  var con = $(e + '_con').children();
  var select = $(menu).eq(num);
  var i = num;

  select.addClass('active');
  con.hide();
  con.eq(num).show();

  menu.click(function () {
    if (select !== null) {
      select.removeClass("active");
      con.eq(i).hide();
    }

    select = $(this);
    i = $(this).index();

    select.addClass('active');
    con.eq(i).show();
  });

}


// 프린트하기
function printPc() {
  // const origin = $('#wrap').html();
  // const protent = $('#contents').html();

  // $('#wrap').html(protent);
  // window.print();
  // $('#wrap').html(origin);

  window.print();
}


// SNS 공유하기
function snsShareShow() {
  $('.s-sns-wrap').show()
}
function snsShareHide() {
  $('.s-sns-wrap').hide()
}
           




/*---------------------------------------------------------------------------------------------------------------------------
 *   Top Zoom Control Function
 *--------------------------------------------------------------------------------------------------------------------------*/

var nowZoom = 100;

function zoomOut() { // 화면크기축소
  nowZoom = nowZoom - 10;
  if (nowZoom <= 70) nowZoom = 70; // 화면크기 최대 축소율 70%
  zooms();
}

function zoomIn() { // 화면크기확대
  nowZoom = nowZoom + 10;
  if (nowZoom >= 200) nowZoom = 200; // 화면크기 최대 확대율 200%
  zooms();
}

function zoomReset() {
  nowZoom = 100; // 원래 화면크기로 되돌아가기
  zooms();
}

function zooms() {
  document.body.style.zoom = nowZoom + "%";
  if (nowZoom == 70) {
    alert("더 이상 축소할 수 없습니다."); // 화면 축소율이 70% 이하일 경우 경고창
  }
  if (nowZoom == 200) {
    alert("더 이상 확대할 수 없습니다."); // 화면 확대율이 200% 이상일 경우 경고창
  }
}



/*---------------------------------------------------------------------------------------------------------------------------
 *  File Field
 *--------------------------------------------------------------------------------------------------------------------------*/
$(function () {

  var fileTarget = $('.file_upload');

  fileTarget.on('change', function () {
    if (window.FileReader) {
      var filename = $(this)[0].files[0].name;
    } else {
      var filename = $(this).val().split('/').pop().split('\\').pop();
    }

    $(this).siblings('.upload_name').val(filename);
  });

});


//=======================공유==========================

//카카오스토리
function select_kakaoStroryShare2() {
if(share_type == "인스타그램"){
		alert("인스타그램은 카카오스토리 공유하기가 지원되지 않습니다.");
		return false;
	}

	url = share_url;
	Kakao.Story.share({  
	    url: url/*,  
	    text: '${SNSInfo.TITLE }'*/
	});
}


function pf_kakao() {
	  
	  var title = '';
	  var desc = '';
	  var image = '';
	  var url = location.href;
  
	  title = '전남문화재단 전자지도';
	  desc = '';
	  image = '${domain}/resources/img/icon/img_top_logo.png'; 
	  
	  Kakao.Link.sendDefault({
     objectType: 'feed',
     content: {
       title: $(document).find('title').text(),
       description: '전남문화재단',
       imageUrl: 'http://jncf.or.kr/resources/img/icon/img_top_logo.png',
       imageWidth: 800,
       imageHeight: 400,
       link: {
        //mobileWebUrl: encodeURIComponent(url),
        //webUrl: encodeURIComponent(url)
        mobileWebUrl: url,
        webUrl: url
       }
     }
    });
	  
	  
     /* Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
          title: title,
          description: desc,
          imageUrl: image,
          link: {
        	  mobileWebUrl: url,
              webUrl: url
          }
    
        },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
            mobileWebUrl: url,
            webUrl: url
          },
        },
      ],
        
    });  */
    
    
  } 

function share_clipboard(){
	 var clipboard = new Clipboard('#share_clipboard', {
        text: function(trigger) {
            return share_url;
        }
    });
	 
	if(isMobile.iOS()){
		alert('아이폰에서는 지원하지 않습니다.')
	}else{
    	alert('클립보드로 현재 주소('+share_url+')가 복사되었습니다.')
	}
}


