<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>



<form:form id="Form" action="/jact/member/regist/info.do" method="post">
	<input type="hidden" name="data" id="data" value="data">
	<div class="joinTabWrap">
		<ul class="joinTabUl">
			<li class="active"><img
				src="/resources/img/icon/icon_join_top_01.png" alt="약관동의 아이콘">
				<span>약관동의</span></li>
			<li><img src="/resources/img/icon/icon_join_top_02.png"
				alt="회원정보 아이콘"> <span>회원정보</span></li>
			<li><img src="/resources/img/icon/icon_join_top_03.png"
				alt="가입완료 아이콘"> <span>가입완료</span></li>
		</ul>
	</div>

	<div class="joinContentsWrap">
		<p class="titleBox">약관동의</p>
		<div class="contentsBox">
			<p class="contentsTitle">서비스 이용약관</p>
			<pre class="service_intro">${userInfoSetting.US_INFO1 }</pre>
			<p class="agreeBox mgB20">
				이용약관에 동의하십니까? <label class="pointer"><input type="radio"
					name="agree1" class="agree"> 동의함</label>
			</p>

			<p class="contentsTitle">개인정보 취급방침</p>
			<pre class="service_intro">${userInfoSetting.US_INFO2 }</pre>
			<p class="agreeBox left">
				<label class="pointer" style="text-align: left"><input
					style="position: relative; top: -1px;" type="checkbox"
					name="agreeAll" id="agreeAll"> 전체 동의하기</label>
			</p>
			<p class="agreeBox right">
				이용약관에 동의하십니까? <label class="pointer"><input type="radio"
					name="agree2" class="agree"> 동의함</label>
			</p>
			<div class="clear"></div>
		</div>
		<div class="btnBox textC">
			<button type="submit" class="btn btnBig_02"
				onclick="return pf_check();">회원가입</button>
		</div>
	</div>
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

