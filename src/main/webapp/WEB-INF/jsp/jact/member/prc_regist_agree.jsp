<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>



<form:form id="Form" action="/jact/member/regist/info.do" method="post">
<input type="hidden" name="data" id="data" value="data">
<section id="login-con">
		<div class="log-inner">

			<div class="sub-title-box">
				<h2>회원가입</h2>
			</div>

			<div class="join-terms-box">
				<div class="t-b">
					<h2>회원가입약관</h2>
					<h4><span class="red-c">*</span> 회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</h4>
				</div>
				<div class="f-b">
					<h3>회원가입약관</h3>

					<div class="con-b" tabindex = "0">
						<pre class="service_intro">${userInfoSetting.US_INFO1 }</pre>   
					</div>
					<div class="row">
						<label><input type="checkbox" class="agree" tabindex = "0"> 회원가입약관의 내용에 동의합니다.</label>
					</div>
				</div>

				


				<div class="t-b">
					<h2>개인정보처리방침안내</h2>
				</div>
				<div class="f-b">
					<h3>개인정보처리방침안내 </h3>

					<div class="con-b" tabindex = "0">
						  <pre class="service_intro" >${userInfoSetting.US_INFO2 }</pre>						     
					</div>

					<div class="row">
						<label><input type="checkbox" class="agree" tabindex = "0"> 개인정보처리방침안내의 내용에 동의합니다.</label>
					</div>
				</div>
			</div>

			<div class="join-term-btn-b">
				<button type="submit" class="join-btn1 purple" onclick="return pf_check();">회원가입</button>
			</div>

		</div>
	</section>
</form:form>



<script>
 
 $(function(){
	$('#agreeAll').on('change',function(){
		if($(this).is(':checked')){
			$('.agree').prop('checked',true)
		}else{
			$('.agree').prop('checked',false)
		}
	})	 
 })
 
 function pf_check(){
	 var state = true;
	 $('.agree').each(function(){
		 if(!$(this).is(':checked')){
			 alert('이용약관에 동의하여주세요.')
			 $(this).focus();
			 state = false;
			 return false;
		 }
	 });
	return state;	 
 }
 </script>

