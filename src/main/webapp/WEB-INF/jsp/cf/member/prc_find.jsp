<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<form:form id="Form">
<div class="idSearchWrap">
	<p class="smallIntro">
    	* 아이디(ID) 및 비밀번호(Password)는<br>
        * 회원가입시 입력하신 이메일 주소를 통해 임시 비밀번호를 발송해드립니다.
    </p>
    <div class="formBox clearfix">
    	<ul class="listFormUl">
        	<li>
            	<p class="title"><span class="colorR">*</span> <label for="UI_EMAIL">이메일</label></p>
                <p class="formBoxInner">
                	<input type="text" class="txtDefault txtWlong_1" id="UI_EMAIL" name="UI_EMAIL">
                </p>
            </li>
            <li>
            	<p class="title"><span class="colorR">*</span> <label for="UI_NAME">이름</label></p>
                <p class="formBoxInner">
                	<input type="text" class="txtDefault txtWlong_1" id="UI_NAME" name="UI_NAME">
                </p>
            </li>
        	<li>
            	<p class="title"><span class="colorR">*</span> <label for="stopSearch_01">자동등록방지</label></p>
                <div class="formBoxInner">
                	<div class="txtDefault" id="catpcha" style="float:left;padding:0;"></div>
                	<button type="button" class="btn btnReward" style="float:left;"  onclick="changeCaptcha();">새로고침</button>
              		<button type="button" class="btn btn_autoUpload mgR15" onclick="audioCaptcha();">
              			<img src="/resources/img/icon/icon_speak_01.png" alt="자동등록방지">
              		</button>
                    <input type="text" class="txtDefault txtWshort_230" id="stopJoin" placeholder="자동등록방지 숫자 입력">
                </div>
            </li>
        </ul>
    </div>
    <div class="btnBox">
    	<button type="button" class="btn btnBig_02" onclick="pf_find();">확인</button>
    	<button type="button" class="btn btnBig_02" onclick="cf_login('main');">로그인</button>
    </div>
</div>
</form:form>
<div id="audiocatpch" style="display: none;"></div>

<script>
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



function pf_find(){
	
	if(!$('#UI_EMAIL').val()){
		alert('이메일을 입력하여주세요.')
		$('#UI_EMAIL').focus()
		return false;
	}
	
	var pattern = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	if(!pattern.test($('#UI_EMAIL').val())){
		alert('이메일 형식이 올바르지 않습니다.');
		$('#UI_EMAIL').focus();
		return false;
	}
	
	if(!$('#UI_NAME').val()){
		alert('이름을 입력하여주세요.')
		$('#UI_NAME').focus()
		return false;
	}
	
	
	 if ( !$('#stopJoin').val() ) {
         alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
         return false;
    }
	
	var state = true;
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
         }
    });
    
    if(!state){
    	return false;
    }
    
    cf_loading();
    $.ajax({
        url: '/cf/member/find/confirm.do',
        type: 'POST',
        data: {
        	'UI_EMAIL' : $('#UI_EMAIL').val(),
        	'UI_NAME' : $('#UI_NAME').val()
        },
        async: false,  
        success: function(resp) {
             if(!resp){
          	   alert('회원정보가 없습니다.')
             }else{
            	alert($('#UI_EMAIL').val() + '으로 계정정보를 전송하였습니다.\n확인하여주세요.')
            	$('#Form')[0].reset();
             }
       }
   }).done(function(){
	   cf_loading_out();
   });
    
    
    
}

//화면 호출시 가장 먼저 호출되는 부분 
$(document).ready(function() {
	changeCaptcha(); //Captcha Image 요청
});



</script>