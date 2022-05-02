<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<script src="/resources/api/mask/jquery.mask.js"></script>

<div class="joinTabWrap">
	<ul class="joinTabUl">
    	<li><img src="/resources/img/icon/icon_join_top_01.png" alt="약관동의 아이콘"> <span>약관동의</span></li>
    	<li class="active"><img src="/resources/img/icon/icon_join_top_02.png" alt="회원정보 아이콘"> <span>회원정보</span></li>
    	<li><img src="/resources/img/icon/icon_join_top_03.png" alt="가입완료 아이콘"> <span>가입완료</span></li>
    </ul>
</div>
<form:form id="Form" action="/jact/member/regist/result.do" method="post">
<input type="hidden" name="tiles" id="tiles" value="jact">
<input type="hidden" name="UI_ZENDER" id="UI_ZENDER" value="">
<div class="joinContentsWrap">
	<p class="titleBox">회원정보 입력
    	 <span class="colorR fs12">*회원가입시 모든항목이 필수 입력 항목입니다.</span>
    </p>                        
    <div class="contentsBox2">
    	<table class="tbl_02 tbl_join_01">
        	<caption>회원가입</caption>
            <tbody>
            	<tr>
                	<th><span>*</span> <label for="UI_ID">아이디</label></th>
                    <td>
                    	<!-- var regId = /^[A-Za-z0-9]{8,12}$/; -->

                    	<input type="text" class="txtDefault txtWlong_1" name="UI_ID" id="UI_ID" maxlength="16" >
                        <p class="small">
                        	*ID는 4~16자까지 영문자나 숫자를 조합하여 만들 수 있으며, 한글이나 특수문자 (스페이스 포함) 등은 사용할 수 없습니다.
                        </p>
                    </td>
                </tr>
            	<tr>
                	<th><span>*</span> <label for="UI_PASSWORD">비밀번호</label></th>
                    <td>
                    	<input type="password" class="txtDefault txtWlong_1" name="UI_PASSWORD" id="UI_PASSWORD" maxlength="16" >
                        <p class="small">
                        	*영문자, 숫자, 특수문자 중 임의로 8자에서 16자까지 조합해 사용할 수 있으며,
                        	<br> 대소문자를 구분하오니 입력시 대소문자의 상태를 확인 하시기 바랍니다.
                        </p>
                    </td>
                </tr>
            	<tr>
                	<th><span>*</span> <label for="UI_PASSWORD2">비밀번호 확인</label></th>
                    <td>
                    	<input type="password" class="txtDefault txtWlong_1" name="UI_PASSWORD2" id="UI_PASSWORD2" maxlength="16">
                    </td>
                </tr>
            	<tr>
                	<th><span>*</span> <label for="UI_NAME">이름</label></th>
                    <td>
                    	<input type="text" class="txtDefault txtWlong_1" name="UI_NAME" id="UI_NAME" maxlength="25">
                    </td>
                </tr>
            	<tr>
                	<th><span>*</span> <label for="UI_BIRTH">생년월일</label></th>
                    <td>
                    	<input type="text" class="txtDefault txtWlong_1" name="UI_BIRTH" id="UI_BIRTH" placeholder="ex) 1999-00-00" />
                    	<input type="radio" name="ZENDER" value="M"/>남자
						<input type="radio" name="ZENDER" value="W"/>여자
                    </td>
                </tr>
            	<tr>
                	<th><span>&nbsp;&nbsp;</span> <label for="UI_PHONE">핸드폰 번호</label></th>
                    <td>
                    	<input type="text" class="txtDefault txtWlong_1" name="UI_PHONE" id="UI_PHONE" placeholder="000-0000-0000" onkeyup="pf_autoHypenPhone(this,this.value)" maxlength="13">
                    </td>
                </tr>
                <tr>
                	<th><span>*</span> <label for="UI_REP_NAME">기관명 및 별명</label></th>
                    <td>
                    	<input type="text" class="txtDefault txtWlong_1" name="UI_REP_NAME" id="UI_REP_NAME" maxlength="25">
                    	<p class="small">
	                       	* 화면에 보이길 희망하는 문구 입력(기관명 or 이름)후 선택 . 단, 아이디로 보이길 희망한다면 선택 하지 않아도 무관
	                    </p>
                    </td>
                    
                </tr>
            	<tr>
                	<th><span>*</span> <label for="UI_EMAIL">이메일</label></th>
                    <td>
                    	<input type="text" class="txtDefault txtWlong_1" name="UI_EMAIL" id="UI_EMAIL" maxlength="50">
                    </td>
                </tr>
            	<tr>
                	<th><span>*</span> <label for="stopJoin">자동등록방지</label></th>
                    <td>
                    	<div class="txtDefault" id="catpcha" style="float:left;padding:0;"></div>
	                	<button type="button" class="btn btnReward" style="float:left;" onclick="changeCaptcha();">새로고침</button>
	              		<button type="button" class="btn btn_autoUpload mgR15" onclick="audioCaptcha();">
	              			<img src="/resources/img/icon/icon_speak_01.png" alt="자동등록방지">
	              		</button>
	                    <input type="text" class="txtDefault txtWshort_230" id="stopJoin" placeholder="자동등록방지 숫자 입력">
                    </td>
                </tr>
            </tbody>
        </table>
        <p class="subTitle">
            회원가입 "확인"버튼을 클릭하시면 입력하신 이메일 주소로 본인확인용 링크 주소를 보내드립니다.<br>
            이메일 본인확인을 하셔야 사이트를 정상적으로 사용하실 수 있습니다. 클릭하시면 회원가입절차가 완료됩니다.
        </p>
    </div>
    <div class="btnBox textC">
    	<button type="submit" class="btn btnBig_02">확인</button>
    	<button type="button" class="btn btnBig_02">취소</button>
    </div>
</div>	
 </form:form>
 
 
 
 <script>
 
//화면 호출시 가장 먼저 호출되는 부분 
 $(document).ready(function() {
	 $("#UI_BIRTH").mask('0000-00-00');
	 $("input:radio[name='ZENDER']:first").prop("checked","checked");
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

         	UI_BIRTH : {required:true},
         	
         	
         	UI_REP_NAME : {required:true, minlength:2, maxlength:20,forbiddenWordCheck:true},

         	UI_EMAIL : {required:true, minlength:5, maxlength:50, email:true}
         	
         },

         messages : {

         	UI_ID : {required:"필수정보를 적어주세요.", minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"), loginID:"아이디 형식이 잘못되었습니다.", dupleCheck:"이미 존재하거나 사용할 수 없는 아이디 입니다."},

         	UI_PASSWORD : {required:"필수정보를 적어주세요.", minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"), passwordChk:"비밀번호 형식이 잘못되었습니다."},

         	UI_PASSWORD2 : {required:"필수정보를 적어주세요.", equalTo:"입력한 비밀번호가 서로 일치하지 않습니다."},

         	UI_NAME : { minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"),forbiddenWordCheck:"사용할 수 없는 이름입니다."},
         
         	UI_BIRTH : { required:"필수정보를 적어주세요."},
         
         	UI_REP_NAME : { required:"필수정보를 적어주세요.",minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"),forbiddenWordCheck:"사용할 수 없는 별명입니다."},
         	
         	UI_EMAIL : {required:"필수정보를 적어주세요.", minlength:jQuery.validator.format("최소 {0}자 이상"), maxlength:jQuery.validator.format("최대 {0}자 이하"), email:"이메일 형식이 잘못되었습니다."}
         	
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
	 
	var gender = $("input[name='ZENDER']:radio:checked").val();
 	$("#UI_ZENDER").val(gender);
 	
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




</script>
 
 
                
