<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<script src="/resources/api/mask/jquery.mask.js"></script>

<!-- <div class="joinTabWrap"> -->
<!-- 	<ul class="joinTabUl"> -->
<!--     	<li><img src="/resources/img/icon/icon_join_top_01.png" alt="약관동의 아이콘"> <span>약관동의</span></li> -->
<!--     	<li class="active"><img src="/resources/img/icon/icon_join_top_02.png" alt="회원정보 아이콘"> <span>회원정보</span></li> -->
<!--     	<li><img src="/resources/img/icon/icon_join_top_03.png" alt="가입완료 아이콘"> <span>가입완료</span></li> -->
<!--     </ul> -->
<!-- </div> -->

<form:form id="Form" action="/jact/member/regist/result.do" method="post">
<input type="hidden" name="tiles" id="tiles" value="jact">
<section id="login-con">
		<div class="log-inner">

			<div class="sub-title-box">
				<h2>회원가입</h2>
			</div>

			<div class="join-terms-box">
				<div class="t-b">
					<h2>사이트 이용정보 입력 <div class="right"><h4><span class="red-c">*</span> 필수입력항목</h4></div></h2>
				</div>
				<div class="input-box">					
					<p class="p-1"><label for="UI_ID">아이디 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="text" class="txt-join-1"  name="UI_ID" id="UI_ID" maxlength="16" placeholder="아이디(이메일)를 입력해주세요.">
<!-- 						<button type="button" class="btn-join-e">이메일 인증</button> -->
					</div>
					<br>
					<p class="p-s">영문자, 숫자, 만 가능. 최소 4자 이상 입력하세요.</p>

					<p class="p-1"><label for="UI_PASSWORD">비밀번호 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="password" class="txt-join-1" name="UI_PASSWORD" id="UI_PASSWORD" maxlength="16"  placeholder="비밀번호를 입력해주세요." onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
					</div><br>
					<p class="p-s">*영문자, 숫자, 특수문자 중 임의로 8자에서 16자까지 조합해 사용할 수 있으며, 
대소문자를 구분하오니 입력시 대소문자의 상태를 확인 하시기 바랍니다.</p>
					<p class="p-1"><label for="UI_PASSWORD2">비밀번호확인 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="password" class="txt-join-1" name="UI_PASSWORD2" id="UI_PASSWORD2" maxlength="16" placeholder="비밀번호를 확인하여 입력해주세요." onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
					</div>
				</div>



				<div class="t-b">
					<h2>개인정보입력</h2>
				</div>
				<div class="input-box">
					<p class="p-1"><label for="UI_NAME">이름 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="text" class="txt-join-1"  name="UI_NAME" id="UI_NAME" maxlength="25" placeholder="이름을 입력해주세요.">
					</div>


					<p class="p-1"><label for="UI_NICK">닉네임 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="text" class="txt-join-1" name="UI_NICK" id="UI_NICK" placeholder="닉네임을 입력해주세요.">
					</div>
					<br>
					<p class="p-s">
						*공백없이 한글, 영문, 숫자만 입력 가능(한글2자, 영문4자 이상) <br>
						닉네임을 바꾸시면 앞으로 60일 이내에는 변경하실 수  없습니다. 
					</p>


					<p class="p-1"><label for="UI_EMAIL">E-mail <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="text" class="txt-join-1" name="UI_EMAIL" id="UI_EMAIL" placeholder="E-mail을 입력해주세요.">
					</div>


					<p class="p-1"><label for="UI_PHONE">휴대폰 번호 <span class="red-c">*</span></label></p>
					<div class="ro-in">
						<input type="text" class="txt-join-1" name="UI_PHONE" id="UI_PHONE" placeholder="휴대폰번호를 입력해주세요." maxlength="13">
					</div>
				</div>

				<div class="t-b">
					<h2>기타 개인설정</h2>
				</div>
				<div class="input-box">
					<p class="p-1"><label for="join-mailing">메일링 서비스 </label></p>
					<div class="txt-p">
						<label><input type="checkbox" id="UI_MB_MAILLING" name="UI_MB_MAILLING"> 정보 메일을 받겠습니다.</label>
					</div>

<!-- 					<p class="p-1"><label for="join-nikname">정보공개 <span class="red-c"></span></label></p> -->
<!-- 					<div class="txt-p"> -->
<!-- 						<h3>정보공개를 바꾸시면 앞으로 0일 이내에는 변경이 안됩니다.</h3> -->
<!-- 						<label><input type="checkbox" id="join-nikname"> 다른분들이 나의 정보를 볼 수 있도록 합니다.</label> -->
<!-- 					</div> -->
					
					<p class="p-1"><label for="stopJoin">자동등록방지 <span class="red-c">*</span></label></p>
					<div class="autoJoin_prevent">
						<div class="left-box">
							<span class="txt" id="catpcha" ></span>
							<span class="btn-bs">
								<button type="button" class="btn-auto" onclick="changeCaptcha();" ><i class="xi-refresh"></i></button>
								<button type="button" class="btn-auto" onclick="audioCaptcha();" ><i class="xi-microphone"></i></button>
							</span>
						</div>
						<div class="right-box">
							<input type="text" class="txt-autoJoin" id="stopJoin" placeholder="숫자를 입력해주세요">
						</div>
					</div>
					<p class="p-s">자동등록방지 숫자를 순서대로 입력하여 주세요.</p>

				</div>
			</div>

			<div class="join-term-btn-b">
				<button type="submit" class="join-btn1 purple">가입하기</button>
				<button type="button" class="join-btn1" onclick="location.href='/jact/index.do'" >가입취소</button>
			</div>

		</div>
	</section>
 </form:form>
 
 
 
 <script>
 
//화면 호출시 가장 먼저 호출되는 부분 
 $(document).ready(function() {
	 $("#UI_PHONE").mask('000-0000-0000');
 	changeCaptcha(); //Captcha Image 요청
 	
 	
 	 $("#Form").validate({

         onfocusout : function (element) {

             $(element).valid();

         },
         
         submitHandler: function(form) {   
        	
            return Membership_save();
           }, 

         rules : {

         	UI_ID : {required:true, minlength:4, maxlength:16, loginID:true, dupleCheck:true},
         	
         	UI_PASSWORD : {required:true, minlength:8, maxlength:16, passwordChk:true},

         	UI_PASSWORD2 : {required:true, equalTo:"#UI_PASSWORD"},

         	UI_NAME : {required:true, minlength:2, maxlength:20,forbiddenWordCheck:true},

         	UI_NICK : {required:true, minlength:2, maxlength:20,forbiddenWordCheck:true},

         	UI_REP_NAME : {required:true, minlength:2, maxlength:20,forbiddenWordCheck:true},

         	UI_EMAIL : {required:true, minlength:5, maxlength:50, email:true,dupleCheckEmail:true},

         	UI_PHONE : {required:true, minlength:13, maxlength:14 }
         	
         },

         messages : {

         	UI_ID : {required:"ID는 필수 정보입니다. 필수정보를 적어주세요.", minlength:jQuery.validator.format("ID는 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("ID는 최대 {0}자 이하만 입력해주세요."), loginID:"아이디 형식이 잘못되었습니다.", dupleCheck:"이미 존재하거나 사용할 수 없는 아이디 입니다."},

         	UI_PASSWORD : {required:"비밀번호는 필수정보입니다. 정보를 입력해주세요.", minlength:jQuery.validator.format("비밀번호는 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("비밀번호는 최대 {0}자 이하만 입력해주세요."), passwordChk:"비밀번호 형식이 잘못되었습니다."},

         	UI_PASSWORD2 : {required:"필수정보입니다. 정보를 입력해주세요.", equalTo:"입력한 비밀번호가 서로 일치하지 않습니다."},

         	UI_NAME : { required:"이름은 필수정보입니다. 정보를 입력해주세요.",minlength:jQuery.validator.format("이름은 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("이름은 최대 {0}자 이하만 입력해주세요."),forbiddenWordCheck:"사용할 수 없는 이름입니다."},
         	
         	UI_NICK : { required:"닉네임은 필수정보입니다. 정보를 입력해주세요.",minlength:jQuery.validator.format("닉네임은 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("닉네임은 최대 {0}자 이하만 입력해주세요."),forbiddenWordCheck:"사용할 수 없는 닉네임입니다."},
         
         	UI_REP_NAME : { required:"필수정보를 적어주세요.",minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"),forbiddenWordCheck:"사용할 수 없는 별명입니다."},
         	
         	UI_EMAIL : {required:"E-mail은 인증을 위한 필수정보입니다. 정보를 입력해주세요.", minlength:jQuery.validator.format("E-mail은 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("E-mail은 최대 {0}자 이하만 입력해주세요."), email:"이메일 형식이 잘못되었습니다." ,dupleCheckEmail: "이미 존재하는 이메일입니다."},
         	
         	UI_PHONE : {required:"전화번호는 필수정보입니다. 정보를 입력해주세요.", minlength:jQuery.validator.format("핸드폰 번호는 최소 {0}자 이상 입력해주세요."), maxlength:jQuery.validator.format("핸드폰 번호는 최대 {0}자 이하만 입력해주세요.")}
         	}, 

         invalidHandler : function(form, validator) {

             var errors = validator.numberOfInvalids();

             if( errors ) 

             {
                 $("h3 span.ok").html("(유효성 검사 실패)"); 

                 alert(validator.errorList[0].message);

                 validator.errorList[0].element.focus();

             }

         },
         
         errorPlacement: function(error, element) {
             	if($(element).hasClass('phonesize')){
 	              	$(element).parent().find('.errorMessage').html(error)
             	}else{
             		$(element).after(error);
             	}
           }

     });
 	
 });
 
 //회원가입
 function Membership_save(){
	 
	 var state = true;
	 
	 if(!state){
		 return state;
	 }
	if ( !$('#stopJoin').val() ) {
         alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
         return false;
    }
	
    $.ajax({
          url: '/common/captcha/submit.do',
          type: 'POST',
          data: 'answer=' + $('#stopJoin').val(),
          async: false,  
          success: function(resp) {
               if(!resp){
            	   alert('입력하신 값이 일치하지 않습니다. 다시 확인하여주세요.')
            	   state = false;
               }
               changeCaptcha();
               $('#stopJoin').val('');
         },
	       error :function(){
	    	   alert('에러!!! 관리자한테 문의하세요');
	    	   state = false;
	       }
    });
	
   return state;
 }
 
/* 
 * Captcha Image 요청
 * [주의] IE의 경우 CaptChaImg.jsp 호출시 매번 변하는 임의의 값(의미없는 값)을 파라미터로 전달하지 않으면
 * '새로고침'버튼을 클릭해도 CaptChaImg.jsp가 호출되지 않는다. 즉, 이미지가 변경되지 않는 문제가 발생한다. 
 *  그러나 크롭의 경우에는 파라미터 전달 없이도 정상 호출된다.
 */
function changeCaptcha() {
 //IE에서 '새로고침'버튼을 클릭시 CaptChaImg.jsp가 호출되지 않는 문제를 해결하기 위해 "?rand='+ Math.random()" 추가 
	 $('#catpcha').html('<img style="height:32px;" src="/common/captcha/img.do?rand='+ Math.random()+'" alt="자동등록방지"/>');
}



function winPlayer(objUrl) {
 $('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
}

/* 
 * Captcha Audio 요청
 * [주의] IE의 경우 CaptChaAudio.jsp 호출시 매번 매번 변하는 임의의 값(의미없는 값)을 파라미터로 전달하지 않으면
 * '새로고침'된 이미지의 문자열을 읽지 못하고 최초 화면 로드시 로딩된 이미지의 문자열만 읽는 문제가 발생한다. 
 * 이 문제의 원인도 결국 매번 변하는 파라미터 없이는 CaptChaAudio.jsp가 호출되지 않기 때문이다. 
 * 그러나 크롭의 경우에는 파라미터 전달 없이도 정상 호출된다.  
 */
function audioCaptcha() {

  var uAgent = navigator.userAgent;
  var soundUrl = '/common/captcha/audio.do?lan=kor';
  if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
      //IE일 경우 호출
      winPlayer(soundUrl+'&agent=msie&rand='+ Math.random());
  } else if (!!document.createElement('audio').canPlayType) {
      //Chrome일 경우 호출
      try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
  } else window.open(soundUrl, '', 'width=1,height=1');
}


//휴대폰번호
function pf_autoHypenPhone(obj,str){
   str = str.replace(/[^0-9]/g, '');
   var tmp = '';
   if(str.length < 4){
       tmp += str;
   }else if(str.length < 7){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3);
   }else if(str.length < 11){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 3);
       tmp += '-';
       tmp += str.substr(6);
   }else{              
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 4);
       tmp += '-';
       tmp += str.substr(7);
   }
   $(obj).val(tmp)
}


function noSpaceForm(obj) { // 공백사용못하게
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(obj.value)) { //공백 체크
        alert("비밀 번호에는 공백을 사용할수 없습니다.");
        obj.focus();
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;
    }
}

</script>
 
 
                
