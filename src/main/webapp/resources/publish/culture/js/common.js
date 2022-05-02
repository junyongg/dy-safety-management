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

	//메인 메뉴
	$('.m-gnb > li').on('mouseenter',function(e){
		$('.m-gnb > li').removeClass('active');
		$(this).addClass('active');

		if( $(this).find('.gnd-s-wrap').is(':visible') ){
			$('.subMenu-Wrap').stop().show();
		}
	});

	$('.m-gnb').on('mouseleave',function(){
		$('.m-gnb > li').removeClass('active');
		$('.subMenu-Wrap').stop().hide();
	});

	//검색어 창
	//열기
	$('.m-sarch-btn').on('click',function(){
		$('#m-search-box').stop().slideDown();
	});
	// 모바일열기
	$('.mo-menu-b-box .search-b').on('click',function(){
		$('#m-search-box').stop().slideDown();
	})

	//닫기
	$('#m-search-box .close-b').on('click',function(){
		$('#m-search-box').stop().slideUp();
	})


	//모바일메뉴 - 뎁스1
	$('.mob-gnb > li > .m-a1').on('click',function(){
		$(this).toggleClass('active');
		$(this).next('.mob-s-gnb').stop().slideToggle();
	})

	//모바일메뉴 - 뎁스2	
	$('.mob-s-gnb > li > .m-a2').on('click',function(){
		$(this).toggleClass('active');
		$(this).next('.mob-s-s-gnb').stop().slideToggle();
		
		if($(this).hasClass('active')){
			$(this).find('.btn-mo-dep2 i').removeClass('xi-plus-thin').addClass('xi-minus-thin');
		} else {
			$(this).find('.btn-mo-dep2 i').removeClass('xi-minus-thin').addClass('xi-plus-thin');
		}
	});


	//서브탑 부분
	//서브탑 메뉴 부분
	$('.subMenu_ul .a1').on('click',function(){
         $('.subMenu_ul .a1').removeClass('active');
        $('.a1').not($(this)).next('.subMenu_in').slideUp();
		$(this).toggleClass('active');
		$(this).next('.subMenu_in').slideToggle();
	})

	// sns버튼 클릭
	$('.s-icon-b .s-icon.sns').on('click',function(){
		$(this).addClass('active');
		$('.s-sns-wrap').show();
	})

	$('.s-sns-wrap .clo-b').on('click',function(){
		$('.s-icon-b .s-icon.sns').removeClass('active');
		$('.s-sns-wrap').hide();
	})



	//햄버거 메뉴 - 사이트맵
	var forEach=function(t,o,r){if("[object Object]"===Object.prototype.toString.call(t))for(var c in t)Object.prototype.hasOwnProperty.call(t,c)&&o.call(r,t[c],c,t);else for(var e=0,l=t.length;l>e;e++)o.call(r,t[e],e,t)};

    var hamburgers = document.querySelectorAll(".hamburger");
    if (hamburgers.length > 0) {
      forEach(hamburgers, function(hamburger) {
        hamburger.addEventListener("click", function() {
          this.classList.toggle("is-active");
        }, false);
      });
    }


    //사이트맵 버튼
    $('.siteMapBtn').on('click',function(){
    	$('#site-map-wrap').stop().fadeToggle();
    })

    //히스토리 부분 탭
    tabFucNomal('.history_tab li','.history_tab_con');
		



});

//마이페이지 메뉴 펼치기
function myPageMenuShow() {
	$('.mypage_ul').stop().slideToggle();
}


// 설문조사 결과보기
function surveyResultShow() {
	$('.survey-result-b-box').show();
}

function surveyResultHide(){
	$('.survey-result-b-box').hide();
}




//서브 폰트 크기 조절 - 광주문화재단 가져옴
function pf_resizeFont(name,act){
	$('#'+name+" *").not('.no_resize_font, br').each(function(){
		if(!$(this).data("fs-initial")){
			$(this).data("fs-initial",$(this).css("font-size"));	
		}
		$(this).data("fs",$(this).css("font-size"));	
		set_font_size($(this),act)
	});
}

function set_font_size($el, act)
{
    var x = 0;
    var fs = $el.data("fs");
    var unit = fs.replace(/[0-9\.]/g, "");
    var fsize = parseFloat(fs.replace(/[^0-9\.]/g, ""));
    var nfsize;

    if(!fsize)
        return true;

    if(unit == "em")
        x = 1;

    if(act == "increase") {
        nfsize = (fsize * 1.2);
    }else if(act == "decrease"){
        nfsize = (fsize / 1.2);
    }else if(act == "initial"){
    	var fs2 = $el.data("fs-initial");
    	var fsize2 = parseFloat(fs2.replace(/[^0-9\.]/g, ""));
    	nfsize  = fsize2;
    }else{
    	return false;
    }

    nfsize = nfsize.toFixed(x);

    $el.css("font-size", nfsize+unit);
    $el.data("fs", nfsize+unit);
}


//모바일 버튼 나타나게
function mobileMenuShow() {
	$('#black-box').show();
	$('#mobile-menu-wrap').show();
}

//모바일 버튼 사라지게
function mobileMenuHide() {
	$('#black-box').hide();
	$('#mobile-menu-wrap').hide();
}



//누르면 페이지 위로 올라감.
function browserTop() {
	$("html, body").stop().animate({
		scrollTop:0
	},500,"easeInOutCubic")
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



/* path : 전송 URL
* params : 전송 데이터 {‘q’:’a’,’s’:’b’,’c’:’d’…}으로 묶어서 배열 입력
*/
function cf_postSend(path, params) {
	var form = document.createElement("form");
	form.setAttribute("method", "post");
	form.setAttribute("action", path);
	for(var key in params) {
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", key);
		hiddenField.setAttribute("value", params[key]);
		form.appendChild(hiddenField);
	}
	document.body.appendChild(form);
	form.submit();
}



//24시간 기준 쿠키 설정하기  
//expiredays 후의 클릭한 시간까지 쿠키 설정
function cf_setCookie(cName, cValue, cDay){
	var cDay = cDay || 365;
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}



function cf_clearCookie(cName){
	
	var expireDate = new Date();
	  
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    expireDate.setDate( expireDate.getDate() - 1 );
    document.cookie = cName+"= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}

//=======================공유==========================
//페이스북
function facebook(){
	var url = encodeURIComponent(document.URL); 
	window.open("http://www.facebook.com/share.php?u=" + url);
}
//트위터
function twitter(){
	var url = encodeURIComponent(document.URL);
	window.open("https://twitter.com/intent/tweet?url="+url); // text 파라미터 삭제함
}
//밴드
function band(title){
	var url = encodeURIComponent(document.URL);
	window.open("http://www.band.us/plugin/share?body="+encodeURIComponent(title)+encodeURIComponent("\n")+location.href+"&route="+location.href, "share_band", "width=410, height=540, resizable=no");

}
//구글+
function google(){
	var url = encodeURIComponent(document.URL);
	window.open("https://plus.google.com/share?url="+url);
}

//카카오스토리
function cf_kakaoStroryShare2() {
	var url = document.URL;
	Kakao.Story.share({  
	    url: url/*,  
	    text: '${SNSInfo.TITLE }'*/
	});
}

//블로그
function cf_blog(){
	var url = document.URL
	window.open("http://blog.naver.com/openapi/share?url="+url);
}

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


var datepickerOption = {
        "dateFormat": 'yy-mm-dd',
        "prevText": '<i class="fa fa-chevron-left"></i>',
        "nextText": '<i class="fa fa-chevron-right"></i>',
        "monthNames": ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        "monthNamesShort": ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        "dayNames": ['일', '월', '화', '수', '목', '금', '토'],
        "dayNamesShort": ['일', '월', '화', '수', '목', '금', '토'],
        "dayNamesMin": ['일', '월', '화', '수', '목', '금', '토'],
        "showMonthAfterYear": true,
        "changeYear": true,
        "cleanText": '지우기',
        "showButtonPanel": true,
        "closeText": '취소',
        "onClose": function (dateText, inst) {
            if ($(window.event.srcElement).hasClass('ui-datepicker-close'))
            {
                document.getElementById(this.id).value = '';
            }
        }
        
    };


function cf_getToday(date){
	var d;
	if(!date){
		d = new Date();
	}else if(date instanceof Date){
		d = date
	}else{
		d = new Date(date);
	}
	
	return d.getFullYear()+"-"+cf_setDigit((d.getMonth() + 1),2)+"-"+cf_setDigit(d.getDate(),2);
}

function cf_setDigit(num,length){
	num = num + ""
	var str=""
	for(var i=0;i<length-num.length;i++){
	  str += '0';
	}
	str += num;
	
	return str;
}

function cf_radio_check_val(Name){
	return $(':radio[name="'+ Name +'"]:checked').val();
}


//로딩중 처리
function cf_loading(){
	$(".loading_box").css("display","block");
	$("html").css("overflow-y","hidden");
}

//로딩중 처리 닫기
function cf_loading_out(){
	$(".loading_box").css("display","none");
	$("html").css("overflow-y","");
}

/**
 * 스크롤 위치 이동
 * @param top
 * @returns
 */
function cf_movePosition(top){
	$(window).scrollTop(top)
}

/**
 * alert
 * @param Msg
 */
function cf_alert(Msg) {    
	alert(Msg)
}

/**
 * 특정 라디오 버튼 선택 처리 Name, value
 * @param Name
 * @param value
 */ 
function cf_radio_checked(Name, value){ 
	$("input:radio[name='" + Name + "']:radio[value='" + value + "']").attr("checked",true);
} 

    
// 쿠키 가져오기
function cf_getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

function cf_clearCookie(cName){
	
	var expireDate = new Date();
	  
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    expireDate.setDate( expireDate.getDate() - 1 );
    document.cookie = cName+"= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}

//00:00 시 기준 쿠키 설정하기  
//expiredays 의 새벽  00:00:00 까지 쿠키 설정
function cf_setCookieAt00(cName, cValue, cDay){
	
    var expire = new Date();
    
    expire = new Date(parseInt(expire.getTime() / 86400000) * 86400000 + 54000000);  
    if( expire > new Date() ){  
    	cDay = cDay - 1;  
    }  
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}

/**
 * 인쇄 ie 미리보기 추가
 * @returns
 */
function cf_print(){
	 
    var browser = navigator.userAgent.toLowerCase();
    if ( -1 != browser.indexOf('chrome') ){
               window.print();
    }else if ( -1 != browser.indexOf('trident') ){
       try{
            //참고로 IE 5.5 이상에서만 동작함

            //웹 브라우저 컨트롤 생성
            var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';

            //웹 페이지에 객체 삽입
            document.body.insertAdjacentHTML('beforeEnd', webBrowser);

            //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
            previewWeb.ExecWB(7, 1);

            //객체 해제
            previewWeb.outerHTML = "";
       }catch (e) {
            alert("- 도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
       }
    }else{
    	 window.print();
    }
}
