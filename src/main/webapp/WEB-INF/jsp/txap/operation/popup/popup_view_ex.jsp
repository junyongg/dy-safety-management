<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>전남문화재단설문조사</title>
    <link rel="shortcut icon" href="/resources/favicon/favicon.ico">
    <link href="/resources/publish/popup/css/rest.css" type="text/css" rel="stylesheet">
    <link href="/resources/publish/popup/css/sub.css" type="text/css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,500,700,900&amp;subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
    <div class="warp-All">
        <!-- 탑헤더 -->
        <div id="topHeader">
            <div class="inner1200">
                <div class="title-b">
                    <div class="tit"><img src="/resources/publish/popup/img/event_title.jpg" alt="홈페이지 리뉴얼 오픈 이벤트!"></div>
                    <div class="letter">
                        안녕하세요?<br>
                        전라남도문화관광재단 홈페이지 리뉴얼 오픈을 기념하여 이벤트를<br>
                        진행합니다. <br>
                        아래 내용 참고하셔서 많은 참여와 관심 부탁드립니다.<br>
                        전라남도문화관광재단은 앞으로도 도민과 함께 성장하고 발전하는<br>
                        동반자가 되겠습니다.
                    </div>
                </div>
                <div class="bg"><img src="/resources/publish/popup/img/title_size_set.jpg" alt="모니터 이미지"></div>
            </div>
        </div>
        <!-- 컨텐츠 -->
        <div class="inner1200">
            <div class="content_Wrap">
                <div class="Renewal_Text">
                    <img src="/resources/publish/popup/img/Renewal_text.jpg" alt="새로워진 전라남도문화관광재단을 만나보세요">
                </div>
                <div class="gift_text">
                    <p>리뉴얼된 전라남도문화관광재단 홈페이지를 경험하신 후 다양한 이벤트 상품 혜택도 받아가세요. 아래 이벤트에 모두 참여하시면 <span class="yellow_point">문화상품권</span>과<br> <span class="yellow_point">아메리카노 2잔</span>을 드려요</p>
                </div>

                <div class="event_01">
                    <div class="num_01">
                        <p>EVENT<br>
                        <span class="one">01</span></p>
                    </div>
                    <div class="height_border">
                        <div></div>
                    </div>
                    <div class="quiz_event_wrap">
                        <div class="quiz_text">
                            <p>전라남도문화관광재단</p>
                            <p>리뉴얼 퀴즈 이벤트</p>
                        </div>
                        <div class="PP_btn">
                            <button type="button" id="PP_btn" onclick="step1();">참여하기<span class="arrow_space"><img src="/resources/publish/popup/img/arrow.png" alt="참여하기 버튼"></span></button>
                        </div>
                        <div class="div"></div>
                    </div>
                </div>
            
                 <div class="event_02">
                    <div class="num_01">
                        <p>EVENT<br>
                        <span class="one">02</span></p>
                    </div>
                    <div class="height_border">
                        <div></div>
                    </div>
                    <div class="quiz_event_wrap">
                        <div class="quiz_text">
                            <p>SNS<span class="small_txt"> (블로그,페이스북,인스타그램 등)</span></p>
                            <p>소문내기 이벤트</p>
                        </div>
                        <div class="PP_btn">
                            <button type="button" id="PP_btn" onclick="step2()">참여하기<span class="arrow_space"><img src="/resources/publish/popup/img/arrow.png" alt="참여하기 버튼"></span></button>
                        </div>
                      
                    </div>
                </div>
                
                <div class="date">    
                    <p>이벤트 일정</p>
                 <div class="x_line"></div>
                    <ul class="date_list">
                        <li><span class="rhombus">◆</span> 이벤트 기간 : 2019. <span class="Y_one">9. 2</span>.(월) ~ <span class="Y_one">9. 16</span>.(월)</li>
                        <li><span class="rhombus">◆</span> 당첨자 선정 : 2019. <span class="Y_one">9. 17</span>.(화) ~ <span class="Y_one">9. 19</span>.(목)</li>
                        <li><span class="rhombus">◆</span> 당첨자 발표 : 2019. <span class="Y_one">9. 20</span>.(금)/<span class="Y_two">100여 명</span></li>
                      </ul>
                 </div>

                  <div class="date">    
                    <p>경품내역</p>
                 <div class="x_line"></div>
                    <ul class="date_list_02">
                        <li><span class="rhombus">◆</span> <span class="Y_three">1위</span>  5만 문화상품권  x  5명</li>
                        <li><span class="rhombus">◆</span> <span class="Y_three">2위</span>  1만 문화상품권  x  5명</li>
                        <li><span class="rhombus">◆</span> <span class="Y_three">3위</span>  5만 문화상품권  x  30명</li>
                        <li>*참가상 스타벅스아메리카노 1잔x70명</li>
                    </ul>
                 </div>
          </div>
    </div>

                <!--footer-->
                <div class="bottom_Wrap">
                    <div class="inner1200">
                        <div class="bottom_inner">
                            <div class="bottom_left">
                                <div class="Notice">
                                    <p>★ 유의사항</p>
                                 </div>
                                <ul class="info">
                                    <li>1.<span class="Y_info"> 두 개 이벤트(전라남도문화관광재단 리뉴얼 퀴즈, SNS소문내기)에 모두 참여하셔야 합니다.</span></li>
                                    <li>2. 당첨자 발표 이후 경품 수령을 위해 개인정보제공에 동의해 주시기 바랍니다.</li>
                                    <li>3. 당첨자의 잘못된 정보로 인해 경품 발송이 누락된 경우에는 재발송 되지 않습니다.</li>
                                </ul>
                             </div>
                        </div>
                    </div>
                </div>


    </div>
</body>

</html>

<script>
function step1(){
	if(!"${userInfo}"){
		alert("로그인이 필요합니다.");
		window.open('/jact/member/login.do');
	}else{
		window.open('/jact/info/servey.do?step=1');		
	}
}

function step2(){
	if(!"${userInfo}"){
		alert("로그인이 필요합니다.");
		window.open('/jact/member/login.do');
	}else{
		window.open('/jact/info/servey.do?step=2');		
	}
}

</script>