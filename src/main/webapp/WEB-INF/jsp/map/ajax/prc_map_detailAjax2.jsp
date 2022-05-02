<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script type="text/javascript" src="/resources/map/js/common.js"></script>
<script type="text/javascript" src="/resources/map/js/swiper.js"></script>
<script type="text/javascript" src="/resources/map/js/slider.js"></script>

<input type="hidden" id="Allnum" value="${Allnum }">
<input type="hidden" id="Type" value="${type }">
<input type="hidden" id="MMS_KEYNO" value="${resultData.MMS_KEYNO }">
<input type="hidden" id="PopupPageNumber" value="${Numbering }">
	
	<!-- 상세팝업 -->
    <div class="popUp_detail_1_wrap"> <!-- wrap -->
    	<c:set var="MainyoutubeId" value="${fn:substring(resultData.MMA_LINK,fn:indexOf(resultData.MMA_LINK,'?v=' ) + 3, fn:length(resultData.MMA_LINK )) }"/>
        <button type="button" class="btn_open" title="접기">
            <span class="icon"><img src="/resources/map/img/icon/icon_prev_arrow.png" alt=""></span>
            <span class="txt n01"></span>
        </button>
        <div class="popUp_detail_1">
            <div class="top_share_box">
                <button type="button" class="btn_share" title="공유하기" onclick="popUp_sns01_show('${domain}/map/prc_map.do?area=${resultData.MMA_AREA }')"><i class="xi-share"></i> 공유</button>
            </div>
            <div class="top_info_box">
                <div class="lb_pic">
                      <a href="javascript:;" onclick="popUp_youtube01_show()">
                        <span class="thumbs" style="background-image: url('https://img.youtube.com/vi/${MainyoutubeId}/mqdefault.jpg');"></span>
                        <span class="icon"><img src="/resources/map/img/icon/icon_in_youtube.png" alt=""></span>
                    </a>
                </div>
                <div class="rb_detail">
                    <div class="top_cate_1">프로젝트 명</div>
                    <div class="title">
                        <div class="lb">
                            <b>${resultData.MMA_TITLE} </b>
                        </div>
                        <div class="rb">
                        </div>
                    </div>
                    <ul class="detail_ul">
                        <c:if test="${not empty resultData.MMA_URL}">
	                        <li>
	                            <span class="cate">홈페이지</span>
	                            <span class="con">${resultData.MMA_URL}</span>
	                        </li>
                    	</c:if>
                        <c:if test="${not empty resultData.MMA_SIZE}">
	                        <li>
	                            <span class="cate">규격</span>
	                            <span class="con">${resultData.MMA_SIZE} </span>
	                        </li>
	                    </c:if>
	                    <c:if test="${not empty resultData.MMA_TYPE}">
	                        <li>
	                            <span class="cate">소재</span>
	                            <span class="con">${resultData.MMA_TYPE}</span>
	                        </li>
                    	</c:if>
                        <c:if test="${not empty resultData.MMA_ADDRESS}">
	                        <li>
	                            <span class="cate">상세주소</span>
	                            <span class="con">${resultData.MMA_ADDRESS} | ${resultData.MMA_ADDR1} ${resultData.MMA_ADDR2} </span>
	                        </li>
                    	</c:if>
                        <c:if test="${not empty resultData.MMA_TEXT}">
	                        <li>
	                            <span class="cate">설명</span>
	                            <span class="con">${resultData.MMA_TEXT}</span>
	                        </li>
                    	</c:if>
                    </ul>
                </div>
            </div>

            <!-- 탭 -->
            <div class="slide_in_tab02_wrap">
                <ul class="slide_in_tab02">
                    <li class="active"><a href="javascript:;" onclick="ChoiceType('벽화')">벽화 <span class="sm">(${Cnt2 })</span></a></li>
                    <li><a href="javascript:;" onclick="ChoiceType('설치')">설치 <span class="sm">(${Cnt3 })</span></a></li>
                    <li><a href="javascript:;" onclick="ChoiceType('기타')">기타 <span class="sm">(${Cnt1 })</span></a></li>
                </ul>
            </div>
			
			<!-- 서브 컨텐츠 -->
			<div id="SubContents">
            </div>
            
        </div>
    </div> <!-- // wrap -->
    <div class="popUp_detail_1_black"></div>




	<!-- 공유 팝업 -->
    <div class="popUp_sns_01">
        <button type="button" class="btn_close" title="닫기" onclick="popUp_sns01_hide()"><i class="xi-close"></i></button>
        <div class="title">
            <h2>공유하기</h2>
        </div>
        <div class="addr_box">
            <p class="addr_txt">
            	${domain}/map/prc_map.do?area=${resultData.MMA_AREA }
            </p>
            <button type="button" class="btn_copy" id="share_clipboard" title="주소복사" onclick="share_clipboard()">주소복사</button>
        </div>
        <div class="sns_box">
            <ul>
                <li>
                    <a href="javascript:;" id="blog" target="_blank">
                        <div class="icon"><i class="xi-naver"></i></div>
                        <div class="txt">네이버 블로그</div>
                    </a>
                </li>
              <!--   <li>
                    <a href="javascript:;" onclick="pf_kakao()">
                        <div class="icon"><i class="xi-kakaotalk"></i></div>
                        <div class="txt">카카오</div>
                    </a>
                </li> -->
                <li>
                    <a href="javascript:;" onclick="select_kakaoStroryShare2()" target="_blank">
                        <div class="icon"><i class="xi-kakaostory"></i></div>
                        <div class="txt">카카오스토리</div>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" id="Face" target="_blank">
                        <div class="icon"><i class="xi-facebook"></i></div>
                        <div class="txt">페이스북</div>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" id="Twit" target="_blank">
                        <div class="icon"><i class="xi-twitter"></i></div>
                        <div class="txt">트위터</div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="popUp_sns_01_black" onclick="popUp_sns01_hide()"></div>
    <!-- 공유 팝업 -->
    
    <!-- 유튜브 팝업 -->
    <div class="popUp_youtube_01">
        <button type="button" class="btn_close" title="닫기버튼" onclick="popUp_youtube01_hide()"><i
                class="xi-close"></i></button>
        <div class="video_box">
            <div class="in_box">
                <iframe width="100%" height="100%" src="https://www.youtube.com/embed/${MainyoutubeId}" frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen></iframe>
            </div>
        </div>
        <div class="btn_box">
            <button type="button" class="btn_youtubeGo" title="전남문화재단 유튜브 바로가기" onclick="window.open('https://www.youtube.com/channel/UCCpPH4qc1xpanrUYpVEpWdg')">
                <span class="txt">전남문화재단 유튜브 바로가기 <img src="/resources/map/img/icon/icon_btn_youtube.png" alt=""></span>
            </button>
        </div>
    </div>
    <div class="popUp_youtube_01_black" onclick="popUp_youtube01_hide()"></div>
    <!-- 유튜브 팝업 -->







<script>
var galleryThumbs = new Swiper(".gallery-thumbs", {
    loop : false,
    // centeredSlides: true,
    centeredSlidesBounds: true,
    spaceBetween : 3,
    slidesPerView: 5,
    watchOverflow: true,
    watchSlidesVisibility: true,
    watchSlidesProgress: true,
    direction: 'vertical',
    breakpoints: {
        800 : {
            direction: 'horizontal',
            slidesPerView: 3,
            spaceBetween: 10,
        }
    }
});

var galleryMain = new Swiper(".gallery-main", {
    autoHeight : true,
    loop: false,
    watchOverflow: true,
    watchSlidesVisibility: true,
    watchSlidesProgress: true,
    preventInteractionOnTransition: true,
    navigation: {
        nextEl: '.swiper01_btn.next',
        prevEl: '.swiper01_btn.prev',
    },
    effect: 'fade',
    fadeEffect: {
        crossFade: true
    },
    thumbs: {
        swiper: galleryThumbs
    }
});


	$(function(){
		ChoiceType('${type}')
		MovePage('${resultData.MMA_X_LOCATION}','${resultData.MMA_Y_LOCATION}','${type }','now');
	});
	
	
	function MovePage(b,c,t,p){
    	var max = $("#Allnum").val();
    	var num = parseInt($("#PopupPageNumber").val());
    	
    	if(p != 'now'){
    		if(p == 'pre'){num = num-1;}
        	else{num = num+1;	}
        	
        	if(num < 1){num = max;}
        	else if(num > max){num = 1;	}
    	}
    	
    	if(p == 'one'){
    		num = 1;
    	}
    	
    	if(t == 'type'){
    		t = $("#Type").val();
    	}
    	
    	$("#PopupPageNumber").val(num);
    	
    	$.ajax({
    		type	:	"post",
    		url		:	"/SubdetailAjax2.do?${_csrf.parameterName}=${_csrf.token}",
    		data	:	{
    			"number" 	: num,
    			"xlocation" : b,
    			"ylocation" : c,
    			"type"		: t
    			
    		},
    		success:function(data){
    			$("#SubContents").html(data);
    		},
    		error:function(){
    			alert("상세페이지 에러");
    		}
    	});
    }
	
	
	 function ChoiceType(type){
	    	$(".slide_in_tab02 li").removeClass();
	    	
	    	if(type == '벽화'){
	    		$('.slide_in_tab02 li:nth-child(1)').addClass('active');
	    		$('#Type').val('벽화');
	    		MovePage('${resultData.MMA_X_LOCATION}','${resultData.MMA_Y_LOCATION}','벽화','one');
	    	}else if(type == '설치'){
	    		$('.slide_in_tab02 li:nth-child(2)').addClass('active');
	    		$('#Type').val('설치');
	    		MovePage('${resultData.MMA_X_LOCATION}','${resultData.MMA_Y_LOCATION}','설치','one');
	    	}else{
	    		$('.slide_in_tab02 li:nth-child(3)').addClass('active');
	    		$('#Type').val('기타');
	    		MovePage('${resultData.MMA_X_LOCATION}','${resultData.MMA_Y_LOCATION}','기타','one');
	    	}
	    }

        
    </script>