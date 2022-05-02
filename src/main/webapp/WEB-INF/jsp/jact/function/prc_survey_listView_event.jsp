<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>

<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>전남문화재단설문조사</title>
    <link rel="shortcut icon" href="favicon/favicon.ico">
    <link href="/resources/publish/popup/css/rest.css" type="text/css" rel="stylesheet">
    <link href="/resources/publish/popup/css/sub.css" type="text/css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,500,700,900&amp;subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
<form:form  id="Form" action="" method="post">
<input type="hidden" name="USER_ID" id="USER_ID" value="${userInfo.UI_ID }">
<input type="hidden" name="USER_NM" id="USER_NM" value="${userInfo.UI_NAME }">
<input type="hidden" name="USER_PH" id="USER_PH" value="${userInfo.UI_PHONE }">
<input type="hidden" name="USER_EM" id="USER_EM" value="${userInfo.UI_EMAIL }">
	
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
        
        <!--event_01-->
        <ul class="C_title_01" id="step1">
            <li>EVENT <span class="E_one">01</span></li>
           <li><div class="Line_Y"></div></li>
            <li>전라남도문화관광재단 <span class="E_text">리뉴얼 퀴즈 이벤트 </span></li>
        </ul>

        
        <!--F_step_01-->
        <div class="one_step_wrap_01">
            <div class="C_first">
                <div class="content_step_01">
                  <p>STEP1</p>
                 </div>

                <div class="step_right_01">
                    <div class="C_step_1">
                        <img src="/resources/publish/popup/img/W_logo.jpg" alt="하얀배경 문화관광재단 로고">
                        <p>전라남도문화관광재단 <span class="G_text">홈페이지 로그인</span><span class="J_text"> ( ※회원가입 필수 )</span></p>
                    </div>
                
                
<!--                     <div class="G_loginBtn"> -->
<!--                      <button type="button" id="Login_btn">로그인<img src="/resources/publish/popup/img/arrow.png" alt="초록배경 오른쪽 화살표"></button> -->
<!--                     </div> -->
                </div>
             </div>
    


            <!--F_step_02-->
            <div class="C_second">
                <div class="content_step_02">
                    <p>STEP2</p>
                 </div>

                <div class="step_right_02">    
                    <div class="C_step_2">
                        <p>오픈 이벤트 페이지에서 <span class="G_text">아래 문제 풀기</span></p>
                    </div>

                     <div class="quiz_01">
                         <p class="Question">Q1. 재단의 비전은?</p>
                         <p class="answer">
                            <input type="text" class="txt_qu" placeholder="A : " name="Q1" id="Q1">
                         </p>
                    </div>
                    <div class="hint">
                      <p >※ 힌트 : 정답을 모르겠다면? 홈페이지 재단소개메뉴</p>
                    </div>

                     <div class="quiz_02">
                         <p class="Question">Q2. 재단 창립일은?</p>
                         <p class="answer">
                          <input type="text" class="txt_qu" placeholder="A : " name="Q2" id="Q2">
                        </p>
                    </div>
                    <div class="hint">
                      <p>※ 힌트 : 전라남도문화관광재단 페이스북 ‘페이지 좋아요’를 누르고 힌트보기 URL을 클릭!</p>
                    </div>
                    
                     <div class="quiz_03">
                         <p class="Question">Q3. 전남의 문화예술로 정서적 감수성을 꽃피우고 관광으로 활력을 불어 넣겠다는 목표를 문자로 형사화한 
                             재단의 슬로건은?</p>
                         <p class="answer"><input type="text" class="txt_qu" placeholder="A : " name="Q3" id="Q3">
                         </p>
                    </div>
                    <div class="hint">
                      <p >※ 힌트 :  Jeonnam, Art, Culture, Tourism</p>
                    </div>

                    <div class="quiz_04">
                         <p class="Question">Q4. 홈페이지 리뉴얼 의견, 기타 재단에 바라는 점 등이 있다면?</p>
                         <p><input type="text" class="answer" placeholder="A : " name="Q4" id="Q4"></p>
                    </div>
                </div>
            </div>

        </div>


        <!--evnet_02-->
        <ul class="C_title_01" id="step2">
            <li>EVENT <span class="E_one">02</span></li>
           <li><div class="Line_Y"></div></li>
            <li>SNS(블로그, 페이스북, 인스타그램 등) <span class="E_text">소문내기 이벤트</span></li>
        </ul>
    
         <div class="one_step_wrap_02">
            <div class="C_first">
                <div class="content_step_01">
                  <p>STEP1</p>
                 </div>
                <div class="Event_02_Step_01">
                    <p>재단 페이스북 ‘리뉴얼 오픈 이벤트 페이지’ 자신의 SNS에 필수태그와 함께 게시</p>
                    <p>(#전라남도문화관광재단#홈페이지리뉴얼#오픈이벤트)와 함께 게시</p>
                </div>
                <div class="sns_text">
                    <img src="/resources/publish/popup/img/B_F_I_icon.png" alt="블로그,페이스북,인스타그램 연결된 아이콘">
                </div>
            
             </div>

              <div class="C_first_B">
                <div class="content_step_01">
                  <p>STEP2</p>
                 </div>
                <div class="Event_02_Step_01">
                    <p><span class="Step2_G">자신의 SNS 게시물 URL을 포함하여 전남 문화관광재단을 응원</span>해주세요.</p>
                     <p></p>
                     <p><input type="text" class="answer" placeholder="URL : " style="width: 50%;" name="URL" id="URL">
                      <input type="text" class="answer" placeholder="응원글 : "  style="width: 80%;" name="CONTENT">
                      </p>
                </div>
	
				<div class="btn">
			        <button type="button" id="event_btn" onclick="id_check()">이벤트 경품 신청하기<img src="/resources/publish/popup/img/arrow.png" alt="신청버튼 화살표"></button>
			    </div>
              </div>
        
         </div>
<!--개인정보 동의-->
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

                            <div class="B_logo">
                              <img src="/resources/publish/popup/img/logo.jpg" alt="문화관광재단 로고">
                             </div>
                        </div>
                    </div>
                </div>
</form:form>

  
</body>

</html>

<script>

	$(function(){
		if("${step}" == "1"){
			jQuery("#step1")[0].scrollIntoView(); 
		}else if("${step}" == "2"){
			jQuery("#step2")[0].scrollIntoView();
		}
	});
	
		function id_check(){
			
			if($("#Q1").val() == "" || $("#Q1").val() == null){
				alert("첫번째 질문을 작성해 주세요");
				$("#Q1").focus();
				return false;
			}else if($("#Q2").val() == "" || $("#Q2").val() == null){
				alert("두번째 질문을 작성해 주세요");
				$("#Q2").focus();
				return false;
			}else if($("#Q3").val() == "" || $("#Q3").val() == null){
				alert("세번째 질문을 작성해 주세요");
				$("#Q3").focus();
				return false;
			}else if($("#Q4").val() == "" || $("#Q4").val() == null){
				alert("네번째 질문을 작성해 주세요");
				$("#Q4").focus();
				return false;
			}else if($("#URL").val() == "" || $("#URL").val() == null){
				alert("URL을 입력해 주세요");
				$("#URL").focus();
				return false;
			}
			
			
			
			$.ajax({
				type: "POST",
				url : "/jact/info/selectajax.do",
				data : $('#Form').serializeArray() ,
				async:false ,
				success : function(data){
					if(data > 0){
						alert("이미 참여하셨습니다.")
	 					return false;
					}
					$("#Form").attr("action"," /jact/info/in.do")
					$("#Form").submit();
				},
				error: function(){
					alert("에러");
				}
			});
		}


</script>