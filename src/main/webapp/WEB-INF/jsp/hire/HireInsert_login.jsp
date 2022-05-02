<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<section id="sub-content">
		<div class="inner1200"> <!--inner 시작 -->

			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

                <div class="support_title_top">
                    <h3>공고명</h3>
                    <h2><c:out value="${BN_TITLE }"/></h2>
                </div>

                <div class="support_login_box">
                    <form:form id="form" action="" method="post">
                    <input type="hidden" name="TH_BNKEYNO" id="TH_BNKEYNO" value="${hireDTO.TH_BNKEYNO}">
                        <fieldset>
                            <legend>로그인</legend>
                            <div class="login-field-box">
                                <div class="row">
                                    <input type="text" class="log-f id" placeholder="지원자 성명" name="TH_USER">
                                </div>
                                <div class="row">
                                    <input type="text" class="log-f email" placeholder="이메일" name="TH_EMAIL">
                                </div>
                                <div class="row">
                                    <input type="password" class="log-f pwd" placeholder="비밀번호" name="TH_PASSWORD">
                                </div>
                                <div class="check-b clearfix">
                                    <div class="right">
                                        <ul class="bt_ul clearfix">
                                            <li><a href="javascript:;" onclick="showMemSearchPop();">비밀번호를 잊어버리셨나요?</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </fieldset>                    
                    
                        <div class="log-btn-box">
                            <c:if test="${type eq 'delete' }">
	                            <button type="button" onclick="Delete()" class="login-btn1 purple">삭제</button>
                            </c:if>
                            <c:if test="${type ne 'delete' }">
	                            <button type="button" onclick="UpdatePage()" class="login-btn1 purple">수정</button>
                            </c:if>
                        </div>
                    </form:form>
                </div>

			</div>

		</div> <!--inner 끝 -->
		
		<!-- 아이디(이메일 찾기) -->
	<div class="mem-search-pop" style="display: none;">
		<div class="top-b">
			<h2>회원정보 찾기</h2>
		</div>
		<div class="con-b">
			<p class="p-1">
				등록하신 이메일 주소를 입력해 주세요. <br>
				해당 이메일로 아이디와 비밀번호 정보를 보내드립니다.
			</p>
			<div class="join-box">
				<p class="p-t"><label for="jo-se-mail">E-mail <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txt-join-1" id="TH_EMAIL_CHECK" name="TH_EMAIL_CHECK" placeholder="E-mail을 입력해주세요.">
				</div>
				
				<p class="p-t"><label for="jo-se-mail">이름 <span class="red-c">*</span></label></p>
				<div class="jo-row">
					<input type="text" class="txtDefault txtWlong_1" id="TH_USER_CHECK" name="TH_USER_CHECK">
				</div>
			</div>
		</div>
		<div class="btn-b">
			<button type="button" class="login-btn2" onclick="pf_find();">확인</button>
			<button type="button" class="login-btn2 purple" onclick="hideMemSearchPop()">창닫기</button>
		</div>
	</div>
	</section>
	
	
	
	<script>
	
	function Delete(){
		//로그인 체크
		$.ajax({
			type 	:	"post",
			url		:	"/hire/loginAjax.do?${_csrf.parameterName}=${_csrf.token}",
			data	:	$('#form').serializeArray(),
			success :	function(data){
				var result = data;
				if(result < 1){
					alert("입력하신 정보가 잘못되었거나 없습니다.");
					return false;
				}
				
				if(confirm("삭제하시겠습니까?")){
					$("#form").attr('action','/jact/hire/delectUser.do');
					$("#form").submit();
				}else{
					aler("취소되었습니다.");
				}
			},
			error	:	function(){
				alert("중복체크 에러");
				return false;
			}
		});
	}
	
	
	function UpdatePage(){
		//로그인 체크
		$.ajax({
			type 	:	"post",
			url		:	"/hire/loginAjax.do?${_csrf.parameterName}=${_csrf.token}",
			data	:	$('#form').serializeArray(),
			success :	function(data){
				var result = data;
				if(result < 1){
					alert("입력하신 정보가 잘못되었거나 없습니다.");
					return false;
				}
				
				$("#form").attr('action','/jact/hire/mypage.do');
				$("#form").submit();
			},
			error	:	function(){
				alert("중복체크 에러");
				return false;
			}
		});
	}
	
	
	function showMemSearchPop() {
		$('.mem-search-pop').show();
	}

	function hideMemSearchPop() {
		$('#TH_EMAIL_CHECK').val("");
		$('#TH_USER_CHECK').val("");
		$('.mem-search-pop').hide();
	}
	
	function pf_find(){
		if(!$('#TH_EMAIL_CHECK').val()){
			alert('이메일을 입력하여주세요.')
			$('#TH_EMAIL_CHECK').focus()
			return false; 
		}
		var pattern = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!pattern.test($('#TH_EMAIL_CHECK').val())){
			alert('이메일 형식이 올바르지 않습니다.');
			$('#TH_EMAIL_CHECK').focus();
			return false;
		}
		
		if(!$('#TH_USER_CHECK').val()){
			alert('이름을 입력하여주세요.')
			$('#TH_USER_CHECK').focus()
			return false;
		}
		
		$.ajax({
			type	: 	"post",
			url		:	"/hire/emailPwAjax.do?${_csrf.parameterName}=${_csrf.token}",
			data	:	{
				"Email" : $('#TH_EMAIL_CHECK').val(),
				"User" : $('#TH_USER_CHECK').val(),
				"Bnkey" : $('#TH_BNKEYNO').val()
			},
			success :	function(data){
				alert(data);
				hideMemSearchPop();
			},
			error : function() {
				alert("회원정보 찾기 에러");
			}
		});
	}
	</script>