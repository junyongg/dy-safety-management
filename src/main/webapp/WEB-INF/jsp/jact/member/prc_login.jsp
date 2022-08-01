<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<script type="text/javascript" src="/resources/api/rsa/jsbn.js"></script>
<script type="text/javascript" src="/resources/api/rsa/rsa.js"></script>
<script type="text/javascript" src="/resources/api/rsa/prng4.js"></script>
<script type="text/javascript" src="/resources/api/rsa/rng.js"></script>
<script type="text/javascript" src="/resources/api/rsa/login.js"></script>
<style>
.login-field-box .row .log-f {
    width: 90%;
    height: 70px;
    border: 1px solid #bbb;
    margin-top: -1px;
    padding-left: 55px;
    position: relative;
    font-size: 16px;
}

#login-con {
    width: 99%;
    padding: 120px 10px 120px;
}

</style>
<form:form id="securedLoginForm" name="securedLoginForm" action="/jact/j_spring_security_check.do" method="post" style="display: none;">
	<input type="hidden" name="customReturnPage" value="${customReturnPage}" />
	<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}" />
	<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}" />
	<input type="hidden" name="securedUsername" id="securedUsername" value="" />
	<input type="hidden" name="securedPassword" id="securedPassword" value="" />
</form:form>

<form:form id="Form">
<input type="hidden" name="customReturnPage" value="${customReturnPage}" />
<section id="login-con">
<div class="log-inner">

	<!-- 로그인 -->
	<div class="login-logo-b">
		<img src="/resources/img/safeAdmin/logo_login.jpg" alt="로고">
	</div>
		<fieldset>
			<legend>로그인</legend>
			<div class="login-field-box">
				<div class="row">
					<input type="text" name="UI_ID" id="UI_ID" class="log-f id" placeholder="아이디를 입력하세요">
				</div>
				<div class="row">
					<input type="password" name="UI_PASSWORD" id="UI_PASSWORD" class="log-f pwd" placeholder="비밀번호를 입력하세요">
				</div>
				<div class="check-b clearfix">
					<div class="left">
						<label><input type="checkbox" id="idSave" style="position: relative;top: -1px;left: 10px;margin-right: 15px;"> 아이디저장</label>
						<p class="samllChar" style=" color:red;margin: 10px;">${customExceptionmsg}</p>
					</div>
<!-- 					<div class="right"> -->
<!-- 						<ul class="bt_ul clearfix"> -->
<!-- 						<a href="javascript:;" onclick="showMemSearchPop()"><li>아이디 | 비밀번호 찾기</li></a> -->
<!-- 						</ul> -->
<!-- 					</div> -->
				</div>
			</div>
		</fieldset>

		<div class="log-btn-box">
			<button type="submit" class="login-btn1 purple" onclick="validateEncryptedForm(); return false;">로그인</button>
<!-- 			<button type="button" class="login-btn1 gray" onclick="location.href='/jact/member/regist.do'">회원가입</button> -->
		</div>
</div>
</section>

<!-- 아이디(이메일 찾기) -->
<div class="mem-search-pop" style="display: none;">
		<div class="top-b">
			<h2>회원정보 찾기</h2>
		</div>
		<div class="con-b">
			<p class="p-1">
				회원가입 시 등록하신 이메일 주소를 입력해 주세요. <br>
				해당 이메일로 아이디와 비밀번호 정보를 보내드립니다.
			</p>
			<div class="join-box">
				<p class="p-t"><label for="jo-se-mail">E-mail <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txt-join-1" id="UI_EMAIL" name="UI_EMAIL" placeholder="E-mail을 입력해주세요.">
				</div>
				
				<p class="p-t"><label for="jo-se-mail">이름 <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txtDefault txtWlong_1" id="UI_NAME" name="UI_NAME">
				</div>

				<p class="p-t"><label for="jo-se-auto">자동등록방지 <span class="red-c">*</span></label></p>
				<div class="autoJoin_prevent">
					<div class="left-box">
						<span class="txt">
						<div class="txtDefault" id="catpcha" style="float:left;padding:0;"></div>
						</span>
						<span class="btn-bs">
							<button type="button" class="btn-auto" style="float:left;"  onclick="changeCaptcha();"><i class="xi-refresh"></i></button>
		              		<button type="button" class="btn-auto" onclick="audioCaptcha();">
		              			<i class="xi-microphone"></i>
		              		</button>
						</span>
					</div>
					<div class="right-box">
						<input type="text" class="txt-autoJoin" id="stopJoin" placeholder="숫자를 입력해주세요">
					</div>
				</div>
				<p class="p-s">자동등록방지 숫자를 순서대로 입력하여 주세요.</p>

			</div>
		</div>
		<div class="btn-b">
			<button type="button" class="login-btn2" onclick="pf_find();">확인</button>
			<button type="button" class="login-btn2 purple" onclick="hideMemSearchPop()">창닫기</button>
		</div>
	</div>
</form:form>


<script type="text/javascript">
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
	
	

		function showMemSearchPop() {
			$('.mem-search-pop').show();
		}

		function hideMemSearchPop() {
			$('.mem-search-pop').hide();
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
		        url: '/jact/member/find/confirmAjax.do?${_csrf.parameterName}=${_csrf.token}',
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