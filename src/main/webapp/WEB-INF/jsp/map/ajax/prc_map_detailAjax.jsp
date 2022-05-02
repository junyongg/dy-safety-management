<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script src="/resources/js/sns/kakao.min.js"></script>
<script type="text/javascript" src="/resources/api/clipboard/clipboard.min.js"></script>


<c:set var="youtubeId" value="${fn:substring(resultData.MMA_LINK,fn:indexOf(resultData.MMA_LINK,'?v=' ) + 3, fn:length(resultData.MMA_LINK )) }"/>
<%-- <input type="hidden" id="youtubelink" value="${fn:substring(resultData.MMA_LINK,fn:indexOf(resultData.MMA_LINK,'?v=' ) + 3, fn:length(resultData.MMA_LINK )) }"> --%>
<input type="hidden" id="Allnum" value="${Allnum }">
<input type="hidden" id="PopupPageNumber" value="${Numbering }">
<input type="hidden" id="MMS_KEYNO" value="">
<input type="hidden" id="Type" value="${type }">
    
	<!-- 위치개요팝업 -->
    <div class="popUp_loca_01" style="display: block;">
        <div class="pop_in_tab_wrap">
            <ul class="pop_in_tab">
                <li class="active"><a href="javascript:;" onclick="ChoiceType('벽화')">벽화 <span class="sm">(${Cnt2 })</span></a></li>
                <li><a href="javascript:;" onclick="ChoiceType('설치')">설치 <span class="sm">(${Cnt3 })</span></a></li>
                <li><a href="javascript:;" onclick="ChoiceType('기타')">기타<span class="sm">(${Cnt1 })</span></a></li>
            </ul>
        </div>
        
        
        <!-- 슬라이드 정보 -->
        <div class="row_top_data_box">
            <div class="lb popSlide1_nav">
                <!-- <span class="slPop1_active">1</span>번째 게시물 <em>/</em> 전체 <span class="slPop1_total">7</span>건 -->
            </div>
            <div class="rb">
                <button type="button" class="btn_close" title="닫기" onclick="popUp_loca01_hide()"><i class="xi-close"></i></button>
            </div>
        </div>
        
        <!-- 슬라이드 버튼 -->
        <button type="button" class="btn_slPop1 prev" title="이전 슬라이드 버튼" onclick="MovePage('${xlocation}','${ylocation}','type','pre');"><i class="xi-angle-left"></i></button>
        <button type="button" class="btn_slPop1 next" title="다음 슬라이드 버튼" onclick="MovePage('${xlocation}','${ylocation}','type','next');"><i class="xi-angle-right"></i></button>
        
        
               <!-- 슬라이드 -->
        <div class="slide_in">
            <div class="slide_popIn_wrap swiper-container"> <!-- slide_start -->
                <div class="slide_popIn_box swiper-wrapper"> <!-- slide_box -->

                    <div class="one swiper-slide"> <!-- one -->
        				
        				<!-- 실제 값 들어가는 곳 -->
				        <div class="info_box">
				           
				        </div>
        				<!-- 값 -->
        				
				        <div class="btn_box01">
				            <button type="button" id="shareSns" class="btn_share" title="공유하기" onclick="popUp_sns01_show('${domain}/map/prc_map.do?area=${resultData.MMA_AREA }')"><i class="xi-share"></i> 공유</button>
				            <button type="button" class="btn_youtube" title="영상보기" onclick="popUp_youtube01_show()"><i class="xi-youtube-play"></i> 영상보기</button>
				            <button type="button" class="btn_detail" title="상세보기" onclick="detail2();"><i class="xi-list"></i> 상세보기</button>
				        </div>
				       </div>
				   </div><!-- // slide_box -->
            	</div><!-- // slide_start -->
    	</div>
    	<script>
            // 문화재단 위치개요 팝업
            function popUp_loca01_show() {
                $('.popUp_black_01').show();
                $('.popUp_loca_01').show();
                slide_popIn_wrap();
            }            
            function popUp_loca01_hide() {
                $('.popUp_black_01').hide();
                $('.popUp_loca_01').hide();
            }
            
            function slide_popIn_wrap() {
                new Swiper('.slide_popIn_wrap', {
                    loop: false,
                    // effect: 'fade',
                    speed: 800,
                    autoplay: {
                        delay: 4000,
                    },
                    spaceBetween: 10,
                    slideToClickedSlide: true,
                    navigation: {
                        nextEl: '.btn_slPop1.next',
                        prevEl: '.btn_slPop1.prev',
                    },
                    pagination: {
                        el: '.popSlide1_nav',
                        type: 'custom',
                        renderCustom: function (swiper, current, total) {
                            return '<span class="c_num">' + current + '</span> 번째 게시물 <em> / </em> 전체 <span class="t_num">' + total + '</span> 건';
                        }
                    },
                });
            }
        </script>
        </div>
    	<div class="popUp_black_01" onclick="popUp_loca01_hide()"></div>
    <!-- // 위치개요팝업 -->
    
    
    
    <!-- 유튜브 팝업 -->
    <div class="popUp_youtube_01">
        <button type="button" class="btn_close" title="닫기버튼" onclick="popUp_youtube01_hide()"><i class="xi-close"></i></button>
        <div class="video_box">
            <div class="in_box">
                <iframe width="100%" height="100%" id="youtubeFrame" src="https://www.youtube.com/embed/${youtubeId }" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
        <div class="btn_box">
            <button type="button" class="btn_youtubeGo" title="전남문화재단 유튜브 바로가기" onclick="window.open('https://www.youtube.com/channel/UCCpPH4qc1xpanrUYpVEpWdg')">
                <span class="txt">전남문화재단 유튜브 바로가기 <img src="resources/img/icon/icon_btn_youtube.png" alt=""></span>
            </button>
        </div>
    </div>
    <div class="popUp_youtube_01_black" onclick="popUp_youtube01_hide()"></div>
    <!-- 유튜브 팝업 -->
    
    <!-- 공유 팝업 -->
    <div class="popUp_sns_01">
        <button type="button" class="btn_close" title="닫기" onclick="popUp_sns01_hide()"><i class="xi-close"></i></button>
        <div class="title">
            <h2>공유하기</h2>
        </div>
        <div class="addr_box">
            <p id="shareText" class="addr_txt">${domain}/map/prc_map.do?area=${resultData.MMA_AREA }</p>
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

    
    <script>
    $(function(){
    	ChoiceType('${type}')
    	MovePage('${xlocation}','${ylocation}','${type }','now');
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
    		url		:	"/SubdetailAjax.do?${_csrf.parameterName}=${_csrf.token}",
    		data	:	{
    			"number" 	: num,
    			"xlocation" : b,
    			"ylocation" : c,
    			"type"		: t
    			
    		},
    		success:function(data){
    			if(data != null){
	    			$(".info_box").html(data);
    			}
    		},
    		error:function(){
    			alert("상세페이지 에러");
    		}
    	});
    }
    
    
    function ChoiceType(type){
    	$(".pop_in_tab li").removeClass();
    	
    	if(type == '기타'){
    		$('.pop_in_tab li:nth-child(3)').addClass('active');
    		$('#Type').val('기타');
    		MovePage('${xlocation}','${ylocation}','기타','one');
    	}else if(type == '설치'){
    		$('.pop_in_tab li:nth-child(2)').addClass('active');
    		$('#Type').val('설치');
    		MovePage('${xlocation}','${ylocation}','설치','one');
    	}else{
    		$('.pop_in_tab li:nth-child(1)').addClass('active');
    		$('#Type').val('벽화');
    		MovePage('${xlocation}','${ylocation}','벽화','one');
    	}
    }
    
    </script>