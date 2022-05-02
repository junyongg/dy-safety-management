<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>


<div class="joinContentsWrap">   
    <section id="login-con">
		<div class="log-inner">

			<div class="sub-title-box">
				<h2>회원가입 완료</h2>
			</div>

			<div class="join-check-icon">
				<i class="xi-check"></i>
			</div>

			<div class="join-done-letter">
				<h2><b>${userInfo2.UI_NAME}님</b> 회원가입을 진심으로 축하합니다.</h2>
				<h4>회원님의 성원에 보답하고자 더욱 더 열심히 하겠습니다. <br>감사합니다.</h4>
			</div>

			<div class="join-done-letter-s">
				<p>확인버튼을 누르시면 전라남도 문화관광재단 홈페이지 메인으로 바로 이동합니다.</p>
				<p>*회원가입 시 입력하신 이메일 주소로 인증메일이 발송 되었습니다.<br>
	              		발송된 인증메일을 확인하신 후 인증처리를 하시면 사이트를 원활하게 이용하실 수 있습니다.</p>
			</div>

			<div class="join-done-letter-bt">
				<button type="button" class="join-btn1 purple" onclick="location.href='/jact/index.do'" >확인</button>
			</div>
			
			<div class="join-confirm-box">
				<div class="row">
					<p class="n-t">아이디 <span class="red-c">*</span></p>
					<p class="confirm-b"><span class="purple-c">${userInfo2.UI_ID }</span></p>
				</div>
				<div class="row">
					<p class="n-t">이메일 주소 <span class="red-c">*</span></p>
					<p class="confirm-b"><span class="purple-c">${userInfo2.UI_EMAIL }</span></p>
				</div>
			</div>

		</div>
	</section>                        
</div>